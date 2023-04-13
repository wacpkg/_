#!/usr/bin/env coffee

> fs > existsSync
  @w5/write
  ./conf > PWD
  path > dirname join
  !/PKG
  !/ROOT

REDIS_ROOT = dirname(PWD)

< gen = ([fp, ofp, export_form, init])=>
  li = []

  if init
    li.push init

  for pkg from PKG
    if not existsSync join(ROOT,pkg,fp)
      continue
    li.push export_form("'!/#{pkg}/#{fp}'")

  console.log REDIS_ROOT, ofp
  write(
    join REDIS_ROOT, ofp
    li.join('\n')
  )
  return

EXPORT = 'const EXPORT = [];\nexport default EXPORT;'

< default main = =>
  [
    [
      'redis/key.js'
      'pkg/key.js'
      (s)=>
        'export * from '+s
    ]
    [
      'redis/lua.js'
      'pkg/lua.js'
      (s)=>
        "EXPORT.push((await import(#{s})).default)"
      EXPORT
    ]
  ].forEach(gen)

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

