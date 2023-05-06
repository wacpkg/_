#!/usr/bin/env coffee

> !/PKG
  !/ROOT
  path > join
  fs > existsSync
  @w5/read
  chalk
  assert/strict:assert
  @w5/yml > load

{yellowBright} = chalk

< default main = (pkg=PKG)=>
  for mod from pkg
    fp = join ROOT,mod,'init.yml'
    if not existsSync fp
      continue
    li = load fp
    for fp from li
      fp = "!/#{mod}/init/#{fp}"
      console.log yellowBright fp
      {default:m} = await import(fp)
      await m()
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()
