#!/usr/bin/env coffee

> ./run

< GEN = [
  'PKG_POST'
  'MID'
]

INIT = [
  'i18n'
  'PkgInit'
]

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await run(
    GEN.concat INIT
  )
  process.exit()
