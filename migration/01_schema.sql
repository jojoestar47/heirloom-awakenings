-- Heirloom Awakenings — Neon schema
-- Run this on your Neon project's database (the branch where the Data API is enabled).
--
-- Tables live directly in `public` and keep the `ha_` prefix so the existing
-- client calls (`db.from('ha_characters')` etc.) work unchanged. On a dedicated
-- Neon project the prefix is vestigial, but keeping it means zero diff in index.html.

create table if not exists public.ha_characters (
  id            uuid primary key default gen_random_uuid(),
  name          text        not null,
  heirloom_name text        not null,
  heirloom_type text        not null default 'Weapon',
  points        integer     not null default 6,
  level         integer     not null default 1,
  image_url     text,
  sort_order    integer     default 0,
  created_at    timestamptz default now()
);

create table if not exists public.ha_upgrades (
  id                text primary key,
  name              text    not null,
  tier              integer not null default 1,
  min_level         integer not null default 1,
  cost              integer not null default 1,
  repeatable        boolean not null default false,
  requirements_note text,
  effect            text    not null,
  sort_order        integer default 0
);

create table if not exists public.ha_character_awakenings (
  character_id uuid not null references public.ha_characters(id) on delete cascade,
  upgrade_id   text not null references public.ha_upgrades(id),
  count        integer not null default 1,
  taken_at     timestamptz default now(),
  primary key (character_id, upgrade_id)
);
