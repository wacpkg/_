#!/usr/bin/env coffee

> @w5/read
  @w5/u8 > U8 u8eq
  fs > existsSync
  _/Redis:R
  path > join
  @w5/utf8/utf8e.js
  @w5/lib > z85Dump
  !/PKG
  !/ROOT

bin2luaStr = (bin)=>
  li = []
  for i from bin
    li.push '\\'+i
  li.join ''

hash = (bin)=>
  U8(await crypto.subtle.digest(
    name: "SHA-256"
    utf8e bin
  ))

isFlags = (i)=>
  i.startsWith '-- flags '

NO_WRITES = '\'no-writes\''

init = (lua)=>
  version = await hash lua

  li = ['#!lua name=UserTax\n\n']

  + function_name,body,flags

  func = =>
    if body[0] == '()'
      flags = flags or []
      if not flags.includes NO_WRITES
        flags.push NO_WRITES

    if flags
      li.push(
        """redis.register_function{
        function_name='#{function_name}',
        callback=function#{body.join('\n')},
        flags={#{flags}}
        }\n"""
      )
    else
      li.push(
        """redis.register_function('#{function_name}',function#{body.join('\n')})\n"""
      )
    flags = body = undefined
    return

  for i,pos in lua.split('\n')
    if i.startsWith 'function '
      i = i[8..].trim()
      pos = i.indexOf('(')
      function_name = i[...pos]
      ap = i.indexOf(')',pos)
      body = [
        i[pos..ap]
        '  redis.setresp(3)'+i[ap+1..]
      ]
    else if body
      trim = i.trim()
      if trim.startsWith '-- flags'
        t = []
        for i from trim[8..].split(' ')
          if i
            t.push '\''+i+'\''
        flags = t.join(',')
      else
        body.push i
        if i == 'end'
          func()
    else
      li.push i+'\n'

  lua = li.join('').trim()
  lua = lua.replace("return 'VERSION'", "return '#{bin2luaStr version}'")

  try
    ver = await R.fbinR 'ver',[],[]
  catch
    null

  if ver and u8eq version,ver
    console.log "-- redis lua version exist : #{z85Dump version}"
    return

  await R.fnload lua
  return

< default main = =>
  REDIS_LUA = []
  for mod from PKG
    fp = join ROOT,mod,'init/redis.lua'
    if existsSync fp
      console.log fp
      REDIS_LUA.push read fp
  init REDIS_LUA.join '\n'

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()
