
/*
  TABLE: publ.albums
  DESCRIPTION: a collection music albums
*/
drop table if exists publ.albums cascade;
create table publ.albums (
    id uuid not null default uuid_generate_v4() primary key unique, 
    name text not null,
    slug text unique not null,
    artist_id uuid not null references publ.artists(id),
    release_date date not null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- indexes
  create index on publ.albums(created_at);
  create index on publ.albums(updated_at);
    create index on publ.albums(name);
    create index on publ.albums(release_date);
    create index on publ.albums(slug);
    create index on publ.albums(artist_id);

-- RBAC
  grant select on publ.albums to :DATABASE_VISITOR;

-- triggers
  create trigger _100_timestamps
  before insert or update on publ.albums
  for each row
  execute procedure priv.tg__timestamps();

-- RLS
  alter table publ.albums enable row level security;

 create policy no_limit /*TODO: update policy*/
   on publ.albums
   for all
   using (true)
   with check(true);

-- fixtures
  -- fixtures go here
/*
  END TABLE: publ.albums
*/

--!include /triggers/slug/albums.sql




insert into publ.artists (id, artistname, firstname, lastname, bio, picture_url, website_url) values
  ('59988ec1-ede7-495a-9da0-05c16ca2c1fb','The Beatles', 'John', 'Lennon', 'The Beatles were an English rock band formed in Liverpool in 1960. With a line-up comprising John Lennon, Paul McCartney, George Harrison and Ringo Starr, they are regarded as the most influential band of all time.', 'https://upload.wikimedia.org/wikipedia/commons/4/47/The_Beatles_in_America.jpg', 'https://www.thebeatles.com/'),
  ('7508251a-2fb6-46a1-9d4e-e4b51285e13b','The Rolling Stones', 'Mick', 'Jagger', 'The Rolling Stones are an English rock band formed in London in 1962. The first settled line-up consisted of Brian Jones (guitar, harmonica), Ian Stewart (piano), Mick Jagger (lead vocals, harmonica), Keith Richards (guitar), Bill Wyman (bass) and Charlie Watts (drums).', 'https://upload.wikimedia.org/wikipedia/commons/1/1c/Rolling_Stones_Tour_2017_%28cropped%29.jpg', 'https://www.rollingstones.com/'),
  ('18e2b90b-a27e-4f2c-8039-db90c78a29a3','The Who', 'Roger', 'Daltrey', 'The Who are an English rock band formed in London in 1964. Their classic line-up consisted of lead singer Roger Daltrey, guitarist and singer Pete Townshend, bass guitarist John Entwistle and drummer Keith Moon.', 'https://upload.wikimedia.org/wikipedia/commons/4/4e/The_Who_1975.jpg', 'https://www.thewho.com/'),
  ('3c71c749-0c08-4029-b4d9-c33d2bdde749','Led Zeppelin', 'Robert', 'Plant', 'Led Zeppelin were an English rock band formed in London in 1968. The group consisted of vocalist Robert Plant, guitarist Jimmy Page, bassist/keyboardist John Paul Jones, and drummer John Bonham.', 'https://upload.wikimedia.org/wikipedia/commons/3/3b/Led_Zeppelin_1977.jpg', 'https://www.ledzeppelin.com/'),
  ('74334962-c27b-46e9-a5c2-1ff0fac90992','Pink Floyd', 'Roger', 'Waters', 'Pink Floyd were an English rock band formed in London in 1965. Gaining a following as a psychedelic band, they were distinguished for their extended compositions, sonic experimentation, philosophical lyrics and elaborate live shows, and became a leading band of the progressive rock genre.', 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Pink_Floyd-1973.jpg', 'https://www.pingfloyd.com/'),
  ('7aef2f9c-969c-4660-872c-f3ca684c6a4f','Queen', 'Freddie', 'Mercury', 'Queen are a British rock band formed in London in 1970. Their classic line-up was Freddie Mercury (lead vocals, piano), Brian May (guitar, vocals), Roger Taylor (drums, vocals) and John Deacon (bass).', 'https://upload.wikimedia.org/wikipedia/commons/2/2e/Queen_1974.jpg', 'https://www.queenonline.com/'),
  ('d87087a6-7654-48fd-b88c-6f30463047fc','The Doors', 'Jim', 'Morrison', 'The Doors were an American rock band formed in Los Angeles in 1965, with vocalist Jim Morrison (1943–1971), keyboardist Ray Manzarek (1939–2013), guitarist Robby Krieger, and drummer John Densmore.', 'https://upload.wikimedia.org/wikipedia/commons/4/4e/The_Doors_in_1968.jpg', 'https://www.thedoors.com/');


insert into publ.albums (id, name, artist_id, release_date) values
  ('b48ac20a-14d3-4698-ab98-c24587c08935', 'Abbey Road', '59988ec1-ede7-495a-9da0-05c16ca2c1fb', '1969-09-26'),
  ('d9c02281-3bfe-4b1a-8a49-306ea9ccae6c', 'Let It Be', '59988ec1-ede7-495a-9da0-05c16ca2c1fb', '1970-05-08'),
  ('53fc0fc7-5e23-4c31-9a44-9f0cabc1e6fd', 'Sticky Fingers', '7508251a-2fb6-46a1-9d4e-e4b51285e13b', '1971-04-23'),
  ('b28e0730-a1dd-4a9f-99cc-bf6141e2a878', 'Who''s Next', '18e2b90b-a27e-4f2c-8039-db90c78a29a3', '1971-08-14'),
  ('a9de20e0-5a83-4966-b99c-29b8a019a03a', 'Led Zeppelin IV', '3c71c749-0c08-4029-b4d9-c33d2bdde749', '1971-11-08'),
  ('a98b26ab-d96b-4185-9905-fdb7bb2d1476', 'The Dark Side of the Moon', '74334962-c27b-46e9-a5c2-1ff0fac90992', '1973-03-01'),
  ('898a86cb-1263-43cc-8351-1f18b2b82b9d', 'A Night at the Opera', '7aef2f9c-969c-4660-872c-f3ca684c6a4f', '1975-11-21'),
  ('34f75443-33ef-4c1e-9b53-c172ed9fba36', 'L.A Woman', 'd87087a6-7654-48fd-b88c-6f30463047fc', '1971-04-19');
