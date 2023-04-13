#!/usr/bin/env coffee

> !/PKG
  !/ROOT
  @w5/write
  @w5/read
  path > join dirname
  fs > existsSync

{env} = process

class _EnvEdit
  constructor:(li)->
    @li = li = li.split('\n')
    @exist = exist = new Set
    for i from li
      i = i.trim()
      if i
        p = i.indexOf '='
        if ~p
          i = i[...p].trim()
          if i.startsWith '#'
            i = i.replace(/^#+/,'').trimStart()
          exist.add i

  push:(name)->
    if not @exist.has name
      @li.push '# '+name+' ='
    return

EnvEdit = (li)=>
  new _EnvEdit(li)

ENV = new Set
{env} = process
process.env = new Proxy(
  env
  {
    get:(self,name)=>
      ENV.add name
      env[name]
  }
)
await import('_/ENV')
process.env = env

CONF = 'CONF.js'

< default main = =>
  env_fp = join dirname(ROOT),'.env'
  if existsSync env_fp
    env_txt = read env_fp
  else
    env_txt = ''
  out = EnvEdit env_txt

  for i from PKG
    fp = join ROOT,i,CONF
    if existsSync fp
      ENV.clear()
      p = join('!',i,CONF)
      await import(p)
      for i from ENV
        out.push i
  write(
    env_fp
    out.li.join('\n')
  )
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

