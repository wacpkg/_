#!/usr/bin/env coffee

> !/ROOT
  !/PKG
  path > join
  fs > existsSync
  @w5/camel
  @w5/read
  @w5/split
  @w5/walk > walkRel
  _/Redis:R

< default main = =>
  ing = []
  for pkg from PKG
    dir = join ROOT,pkg,'i18n'
    if existsSync dir
      console.log dir
      for await fp from walkRel(
        dir
      )
        if fp.endsWith '.md'
          [lang, name] = split fp[..-4],'/'
          ing.push R.hset(
            'i18n:'+camel(pkg.replaceAll('.','_')+'_'+name)
            lang
            read(join(dir, fp))
          )
  await Promise.all ing
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()

