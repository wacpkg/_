CREATE EXTENSION IF NOT EXISTS moreint;

UPDATE
  pg_type
SET oid = 100000
WHERE typname = 'u64';

UPDATE
  pg_type
SET oid = 100001
WHERE typname = 'u32';

UPDATE
  pg_type
SET oid = 100002
WHERE typname = 'u16';

UPDATE
  pg_type
SET oid = 100003
WHERE typname = 'u8';

UPDATE
  pg_type
SET oid = 100004
WHERE typname = 'i8';

CREATE EXTENSION IF NOT EXISTS md5hash;
