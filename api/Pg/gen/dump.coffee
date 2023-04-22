#!/usr/bin/env coffee

> !/_pkg > PKG_YML MOD PROJECT
  @w5/pg/PG/PG_URI
  @w5/pg/PG > LI0
  fs > existsSync mkdirSync
  path > join dirname
  @w5/read
  @w5/write
  zx/globals:

CREATE_KIND = [
  'INDEX'
  'TABLE'
  'SEQUENCE'
]

dump = (dir, schema)=>
  to = join PROJECT,'src',dir,'Sql'
  if not existsSync to
    mkdirSync to
  out = "#{to}/#{schema}.sql"
  await $"pg_dump #{PG_URI} --no-owner --no-acl -s -n #{schema} -f #{out}"
  sql = read(out).split('\n').filter(
    (i)=>
      i and not i.startsWith('--')
  ).map(
    (sql)=>
      create = 'CREATE SCHEMA '
      if sql.startsWith create
        s = sql[14..-2]
        search_path = s
        if s != 'public'
          search_path+=',public'
        sql = "#{create}IF NOT EXISTS #{s};\nSET search_path TO #{search_path};"
      else
        sql = sql.replaceAll('public.','').replaceAll('CREATE FUNCTION ','CREATE OR REPLACE FUNCTION ')
        for i from CREATE_KIND
          sql = sql.replaceAll(
            "CREATE #{i} "
            "CREATE #{i} IF NOT EXISTS "
          )
      sql
  ).join('\n')
  write(out,sql)
  return

< default main = ->
  exist = new Set await LI0'''select schema_name from information_schema.schemata WHERE schema_name NOT IN ('information_schema', 'pg_catalog')'''
  for [mod,{db}] from MOD.entries()
    if db
      {schema} = db
      schema = schema.split ' '
      if schema.length
        dir = mod[..mod.indexOf('/')-1]
        for s from schema
          if exist.has s
            await dump dir, s
            yield [dir, s]
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  for await i from await main()
    null
  process.exit()

