-- Heirloom Awakenings — Neon Data API access control
--
-- This app has no login. Every request reaches the Data API WITHOUT an
-- Authorization header, so it runs as the built-in `anonymous` role.
-- Today on Supabase the equivalent is the anon key + permissive RLS = fully
-- public read/write. We reproduce that here with table GRANTs + RLS left OFF.
--
-- Run this AFTER 01_schema.sql, and after the Data API is enabled on the branch
-- (enabling it creates the `anonymous` role). If you ticked "Grant public schema
-- access" when enabling the Data API, the first GRANTs may already be in place —
-- re-running them is harmless.

grant usage on schema public to anonymous;

grant select, insert, update, delete
  on public.ha_characters, public.ha_upgrades, public.ha_character_awakenings
  to anonymous;

-- Future tables in public also get access (so later migrations don't need a re-grant):
alter default privileges in schema public
  grant select, insert, update, delete on tables to anonymous;

-- RLS is intentionally left disabled on these tables: the app is public by design,
-- so there is no per-row owner to filter on. If you later add user accounts, enable
-- RLS here and add policies instead of relying on the anonymous GRANTs above.
