#!/usr/bin/env coffee

> !/ROOT
  path > join dirname
  fs > existsSync
  ./rsync

LIB = join dirname(ROOT), 'lib'

< main = =>
  await rsync()
  {default:PKG} = await import("!/PKG")
  for pkg from PKG
    fp = join LIB,pkg,'init/build.js'
    if existsSync fp
      {default:build} = await import(fp)
      await build()
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

