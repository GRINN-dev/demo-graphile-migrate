
/*
  TABLE: publ.artists
  DESCRIPTION: A collection of artists.
*/
drop table if exists publ.artists cascade;
create table publ.artists (
    id uuid not null default uuid_generate_v4() primary key unique, 
    firstname text,
    lastname text,
    artistname text,
    slug text unique not null,
    bio text,
    picture_url text,
    website_url text,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- indexes
  create index on publ.artists(created_at);
  create index on publ.artists(updated_at);
    create index on publ.artists(slug);
    create index on publ.artists(artistname);

-- RBAC
  grant select on publ.artists to :DATABASE_VISITOR;

-- triggers
  create trigger _100_timestamps
  before insert or update on publ.artists
  for each row
  execute procedure priv.tg__timestamps();

-- RLS
  alter table publ.artists enable row level security;

 create policy no_limit /*TODO: update policy*/
   on publ.artists
   for all
   using (true)
   with check(true);

-- fixtures
  -- fixtures go here
/*
  END TABLE: publ.artists
*/

--!include /triggers/to-slug.sql
--!include /triggers/slug/artists.sql
