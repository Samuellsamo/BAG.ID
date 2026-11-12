-- BAG.ID / Kolekcie miest (doplnok k existujúcej databáze)
-- Spusti v Supabase SQL Editor pred aktivovaním novej webovej verzie.
-- Existujúce účty, NFC štítky a obľúbené miesta nemení.

create table if not exists public.collections (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  title text not null check (char_length(title) between 1 and 80),
  description text not null default '' check (char_length(description) <= 280),
  share_enabled boolean not null default false,
  share_token text not null unique default (replace(gen_random_uuid()::text, '-', '') || replace(gen_random_uuid()::text, '-', '')),
  created_at timestamptz not null default now()
);
create index if not exists collections_owner_idx on public.collections(owner_id);
create table if not exists public.collection_places (
  collection_id uuid not null references public.collections(id) on delete cascade,
  place_id text not null check (char_length(place_id) between 1 and 200),
  name text not null check (char_length(name) between 1 and 250),
  kind text not null default '' check (char_length(kind) <= 100),
  lat double precision check (lat between -90 and 90),
  lon double precision check (lon between -180 and 180),
  primary key (collection_id, place_id)
);

alter table public.collections enable row level security;
alter table public.collection_places enable row level security;

create policy "collections owner all" on public.collections
  for all to authenticated
  using (owner_id = (select auth.uid()))
  with check (owner_id = (select auth.uid()));

create policy "collection places owner all" on public.collection_places
  for all to authenticated
  using (exists (
    select 1 from public.collections c
    where c.id = collection_id and c.owner_id = (select auth.uid())
  ))
  with check (exists (
    select 1 from public.collections c
    where c.id = collection_id and c.owner_id = (select auth.uid())
  ));

grant select, insert, update, delete on public.collections to authenticated;
grant select, insert, update, delete on public.collection_places to authenticated;

-- Verejný náhľad vracia LEN názov kolekcie, popis a zdieľané miesta.
-- E-mail, profil používateľa a nezdieľané kolekcie nie sú sprístupnené.
create or replace function public.get_shared_collection(p_token text)
returns table (
  collection_id uuid,
  title text,
  description text,
  place_id text,
  place_name text,
  place_kind text,
  lat double precision,
  lon double precision
)
language sql stable security definer
set search_path = ''
as $$
  select c.id, c.title, c.description, p.place_id, p.name, p.kind, p.lat, p.lon
  from public.collections c
  left join public.collection_places p on p.collection_id = c.id
  where c.share_enabled = true
    and c.share_token = p_token
    and char_length(p_token) = 64
  order by p.name nulls last;
$$;

revoke all on function public.get_shared_collection(text) from public;
grant execute on function public.get_shared_collection(text) to anon, authenticated;
