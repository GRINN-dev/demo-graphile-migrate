drop function if exists priv.tg__generate_album_slug cascade;
create function priv.tg__generate_album_slug() returns trigger as $$
begin

    NEW.slug := coalesce(
        to_slug(NEW.name || '-' || NEW.release_date::text)
        , NEW.id::text
    );

    WHILE EXISTS (SELECT 1 FROM publ.albums WHERE albums.slug = NEW.slug) LOOP
        NEW.slug := NEW.slug || ('-' || (random() * 1000)::integer)::text;
    END LOOP;

    return NEW;
    
end;
$$ language plpgsql volatile security definer;


create trigger _200_generate_album_slug
before insert on publ.albums
for each row execute procedure priv.tg__generate_album_slug();
