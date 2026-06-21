"""Apply migration/setup_neon.sql to Neon over a direct Postgres connection.

Reads the connection string from the DATABASE_URL env var (never written to
disk). Uses pg8000 (pure-Python, no native deps) so it runs on any Python.

  DATABASE_URL="postgresql://neondb_owner:PW@ep-...neon.tech/neondb?sslmode=require" \
      python migration/apply_to_neon.py
"""
import os, ssl, sys
from urllib.parse import urlparse, unquote, parse_qs
import pg8000.dbapi

HERE = os.path.dirname(os.path.abspath(__file__))
SQL_PATH = os.path.join(HERE, "setup_neon.sql")


def split_statements(sql):
    """Split on ';' that are outside single-quoted strings and -- comments.
    Handles '' escaped quotes. The SQL is machine-generated and only uses
    single-quoted string literals, so this is safe (effect text contains ';')."""
    stmts, buf = [], []
    i, n, in_str = 0, len(sql), False
    while i < n:
        c = sql[i]
        if in_str:
            if c == "'":
                if i + 1 < n and sql[i + 1] == "'":  # escaped quote
                    buf.append("''"); i += 2; continue
                in_str = False
            buf.append(c); i += 1; continue
        if c == "'":
            in_str = True; buf.append(c); i += 1; continue
        if c == "-" and i + 1 < n and sql[i + 1] == "-":  # line comment
            j = sql.find("\n", i)
            i = n if j == -1 else j
            continue
        if c == ";":
            s = "".join(buf).strip()
            if s:
                stmts.append(s)
            buf = []; i += 1; continue
        buf.append(c); i += 1
    tail = "".join(buf).strip()
    if tail:
        stmts.append(tail)
    return stmts


def main():
    url = os.environ.get("DATABASE_URL")
    if not url:
        sys.exit("ERROR: set DATABASE_URL to your Neon connection string.")
    u = urlparse(url)
    statements = [s for s in split_statements(open(SQL_PATH, encoding="utf-8").read())
                  if s.lower() not in ("begin", "commit")]
    print(f"Parsed {len(statements)} statements from setup_neon.sql")

    ctx = ssl.create_default_context()  # Neon serves valid certs; SNI via host
    conn = pg8000.dbapi.connect(
        host=u.hostname, port=u.port or 5432,
        database=u.path.lstrip("/"),
        user=unquote(u.username or ""), password=unquote(u.password or ""),
        ssl_context=ctx,
    )
    try:
        cur = conn.cursor()
        for s in statements:
            cur.execute(s)
        conn.commit()
        print("Applied OK. Row counts:")
        for t in ("ha_characters", "ha_upgrades", "ha_character_awakenings"):
            cur.execute(f"select count(*) from public.{t}")
            print(f"  {t}: {cur.fetchone()[0]}")
    except Exception:
        conn.rollback()
        raise
    finally:
        conn.close()


if __name__ == "__main__":
    main()
