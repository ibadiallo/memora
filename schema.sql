-- MEMORA — run once in Supabase: SQL Editor → New query → paste → Run

-- Products ----------------------------------------------------------------
create table if not exists public.products (
  slug            text primary key,                 -- used in the URL: #/product/<slug>
  name            text not null,
  type            text not null check (type in ('Abaya', 'Voile')),
  price           integer not null check (price >= 0),   -- CFA
  image           text,                             -- main photo (full URL or images/... path)
  hover_image     text,                             -- photo shown on hover
  gallery         text[],                           -- product page photos; empty = image + hover_image
  sizes           integer[],                        -- e.g. {54,56}; empty = all sizes for abayas
  colors          text[],                           -- e.g. {"Jaune ambré"}
  in_stock        boolean not null default true,    -- false = "Rupture de stock"
  description_fr  text,
  description_en  text,
  featured        boolean not null default false,   -- shown in "Pièces Signatures" on the home page (max 6)
  sort_order      integer not null default 0,
  active          boolean not null default true,    -- false = hidden from the site
  created_at      timestamptz not null default now()
);

-- Editorial carousel ------------------------------------------------------
create table if not exists public.editorial_slides (
  id          bigint generated always as identity primary key,
  image       text not null,
  title       text default 'MEMORA',
  credit      text default 'Photo by: MEMORA',
  sort_order  integer not null default 0,
  active      boolean not null default true
);

-- Product page texts (key = care | delivery) ------------------------------
create table if not exists public.site_info (
  key  text primary key check (key in ('care', 'delivery')),
  fr   text,
  en   text
);

-- Visitors can read, nobody can write with the public key -----------------
alter table public.products         enable row level security;
alter table public.editorial_slides enable row level security;
alter table public.site_info        enable row level security;

drop policy if exists "public read products" on public.products;
create policy "public read products" on public.products
  for select to anon, authenticated using (active);

drop policy if exists "public read slides" on public.editorial_slides;
create policy "public read slides" on public.editorial_slides
  for select to anon, authenticated using (active);

drop policy if exists "public read info" on public.site_info;
create policy "public read info" on public.site_info
  for select to anon, authenticated using (true);

-- Public bucket for photos uploaded from the dashboard --------------------
insert into storage.buckets (id, name, public)
values ('memora', 'memora', true)
on conflict (id) do nothing;
