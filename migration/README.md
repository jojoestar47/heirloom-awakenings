# Supabase → Neon migration

Migrating Heirloom Awakenings off Supabase (project `Dungeon Data`) onto a
dedicated Neon project, using Neon's **Data API** (PostgREST-compatible) so the
app stays a static page with no backend.

## What changes

| Piece | Before (Supabase) | After (Neon) |
|-------|-------------------|--------------|
| DB host | Supabase Postgres, `heirloom_awakenings` schema + `ha_` views in `public` | Dedicated Neon project, `ha_` tables directly in `public` |
| Browser → DB | `@supabase/supabase-js` + anon key + RLS | `@neondatabase/postgrest-js` + Data API, `anonymous` role |
| Images | Supabase Storage bucket `heirloom-images` | Committed to `images/` in this repo (static files) |

Only **2** of the 5 character images were actually in Supabase Storage (Herbert,
Tessa) — they're now in `images/`. The other 3 (Gator, Lilith, Till) were always
hot-linked D&D Beyond URLs and are unaffected.

## Runbook

1. **Create a Neon project** (free tier is plenty for this data: 5 + 146 + 14 rows).
2. **Enable the Data API** on the project's main branch (Neon Console → Data API).
   - A JWT provider must be chosen to enable it (Neon Auth is fine) — but this app
     never sends a token, so every request runs as `anonymous`.
   - Note the **Data API URL** (looks like `https://<id>.dataapi.<region>.neon.tech/rest/v1/`).
3. **Apply schema:** run [`01_schema.sql`](01_schema.sql).
4. **Load data:** the rows are pulled live from Supabase at migration time and
   inserted (the `repeatable` boolean is rendered as `true`/`false`, not the bare
   `t`/`f` that `format('%s', ...)` produces, which would fail to parse).
5. **Apply grants:** run [`02_grants.sql`](02_grants.sql).
6. **Point the app at Neon:** update `config.js` with the Data API URL and swap the
   client in `index.html` (`supabase-js` → `@neondatabase/postgrest-js`, drop the
   Storage upload calls).
7. **Test** reads + writes in the browser, then cut over.

## Rollback

The Supabase project stays fully intact until cutover is confirmed stable —
reverting is just restoring the old `config.js` + `index.html`.
