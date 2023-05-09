#!/usr/bin/env coffee

> _/Redis > R R_CONF
  @w5/lib > randomBytes

< default main = =>
  if not await R.hexist R_CONF, 'SK'
    SK = randomBytes(32)
    await R.hset R_CONF,{SK}
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
