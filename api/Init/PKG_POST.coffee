#!/usr/bin/env coffee

> !/ROOT.js
  !/PKG.js
  json5
  fs > existsSync
  path > join
  @w5/write

< default main = =>
  POST = [
    '''
    import merge from 'lodash-es/merge.js'
    const PKG = {}
    export default PKG\n
    '''
  ]
  for pkg from PKG
    dir = join ROOT,pkg

    if not existsSync join dir,'post.js'
      continue

    out = t = {}
    li = pkg.split('.')
    li0 = li[0]
    li[0] = li0[li0.indexOf('/')+1..]
    end = li.pop()
    for i from li
      t = t[i] = {}
    t[end] = 0
    t = json5.stringify(out).replace(':0}',":await import('./#{pkg}/post.js')}")
    POST.push "merge(PKG,#{t})"

  write(
    join ROOT, 'POST.js'
    POST.join('\n')
  )
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

