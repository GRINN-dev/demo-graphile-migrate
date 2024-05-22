drop function if exists priv.tg__generate_artist_slug cascade;
create function priv.tg__generate_artist_slug() returns trigger as $$
begin

    NEW.slug := coalesce(
        to_slug(NEW.artistname)
        , to_slug(NEW.firstname || '-' || NEW.lastname)
        , NEW.id::text
    );

    WHILE EXISTS (SELECT 1 FROM publ.artists WHERE artists.slug = NEW.slug) LOOP
        NEW.slug := NEW.slug || ('-' || (random() * 1000)::integer)::text;
    END LOOP;


    perform graphile_worker.add_job(
        'artist_slug_generator',
        json_build_object(
            'id', NEW.id,
            'slug', NEW.slug
        )
    );

    return NEW;
    
end;
$$ language plpgsql volatile security definer;


create trigger _200_generate_artist_slug
before insert on publ.artists
for each row execute procedure priv.tg__generate_artist_slug();
