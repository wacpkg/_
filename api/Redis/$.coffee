> @w5/u8 > U8
  @w5/utf8/utf8e.js
  _/Http/CONF.js > DEBUG

if DEBUG
  {default:assert} = await import('assert/strict')
  {BinSet} = await import('@w5/wasm-set')
  SET = new BinSet()

wrap = (...args)=>
  r = args[0]
  if Array.isArray r
    r = U8 r
  else
    r = utf8e r

  if DEBUG
    assert not SET.has(r)
    SET.add(r)

  if args[1]
    r.bind = args[1]
  r

< new Proxy(
  wrap
  get:(_,name)=>
    wrap name[2..].toLowerCase().replace(
      /_./g
      (x)=>
        x[1..].toUpperCase()
    )
)
