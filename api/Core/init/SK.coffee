#!/usr/bin/env coffee

> _/Redis > R R_CONF
  @w5/lib > randomBytes

< default main = =>
  console.log '>1'
  if not await R.hexist R_CONF, 'SK'
    console.log '>2'
    SK = randomBytes(32)
    await R.hset R_CONF,{SK}
  console.log '>3'
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
