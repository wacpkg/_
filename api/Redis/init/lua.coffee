#!/usr/bin/env coffee

> _/Redis:R
  @w5/read
  @w5/redis_lua
  fs > existsSync
  path > join
  !/PKG
  !/ROOT


< default main = =>
  REDIS_LUA = []
  for mod from PKG
    fp = join ROOT,mod,'init/redis.lua'
    if existsSync fp
      console.log fp
      REDIS_LUA.push read fp
  if REDIS_LUA.length
    lua = REDIS_LUA.join '\n'
    await RedisLua(R).WacTax lua
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()
