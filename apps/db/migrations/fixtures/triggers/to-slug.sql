CREATE OR REPLACE FUNCTION public.to_slug(text)
RETURNS text AS $$
DECLARE
  slug text;
BEGIN
  slug := translate(slug, ' (', '-');
  slug := translate(slug, ' )', '-');
  slug := translate(slug, '(', '-');
  slug := translate(slug, ')', '-');
  slug := translate(lower($1), ' ', '-');
  slug := unaccent(slug);
  slug := translate(slug, '.', '-');
  slug := translate(slug, '_', '-');
  slug := translate(slug, ',', '');
  slug := translate(slug, '/', '-');
  slug := translate(slug, '&', 'and');
  slug := translate(slug, '°', '');
  slug := translate(slug, '''', '');
  slug := translate(slug, '"', '');
  slug := translate(slug, '?', '');
  slug := translate(slug, '!', '');
  slug := translate(slug, '`', '');
  slug := translate(slug, '*', '');
  slug := translate(slug, 'é', 'e');
  slug := translate(slug, 'è', 'e');
  slug := translate(slug, 'ç', 'c');
  slug := translate(slug, 'à', 'a');
  slug := translate(slug, 'ù', 'u');
  slug := translate(slug, 'ê', 'e');
  slug := translate(slug, 'â', 'a');
  slug := translate(slug, 'î', 'i');
  slug := translate(slug, 'ô', 'o');
  slug := translate(slug, 'û', 'u');
  -- Supprimer les caractères non alphanumériques
  slug := regexp_replace(slug, '[^a-zA-Z0-9-]', '', 'g');
    -- Supprimer les premiers et derniers caractères s'ils ne sont pas alphanumériques
  IF length(slug) > 0 THEN
    WHILE not slug ~ '^[a-zA-Z0-9]' LOOP
      slug := substring(slug from 2);
    END LOOP;

    WHILE not slug ~ '[a-zA-Z0-9]$' LOOP
      slug := reverse(substring(reverse(slug) from 2));
    END LOOP;
  END IF;
  RETURN slug;
END;
$$ LANGUAGE plpgsql;