#!/usr/bin/env coffee

> ./conf > PWD
  path > join
  @w5/write
  @w5/sleep
  @w5/pg/PG > Q

< default main = =>
  n = 9
  while --n
    li = []
    for [oid,name] from await Q"select oid,typname from pg_type where typname in ('u64','u32','u16','u8','i8')".values()
      li.push [oid,name]
    if li.length
      break
    await sleep 999

  li.sort()
  fp = join(PWD, '..', 'PG_UINT.js')
  console.log fp
  write(
    fp
    """\
import { UINT } from "@w5/pg/PG_ENV.js"
UINT.splice(
  UINT.length,
  0,
  #{JSON.stringify(li)[1..-2]}
)"""
  )
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()
