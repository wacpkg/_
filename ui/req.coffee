###
网络请求:
* 如响应的content-type以/json结尾，则返回对象;否则返回Uint8Array
* 在网络故障的时候，自动重试
###

> ./toastReq.js

export HOOK = new Map

HOOK.set 'json',(r)=> r.json()


export default req = (...args)=>
  try
    n = 0
    loop
      try
        r = await fetch(...args)
        if r.ok or (304 == r.status)
          break
        else
          throw r
      catch err
        if err.name == 'AbortError'
          return
        if ++n < 7
          continue
        else
          throw err

    content = r.headers.get('content-type')
    if content
      func = HOOK.get content.slice(content.lastIndexOf('/')+1)
      if func
        return await func r
    return new Uint8Array await r.arrayBuffer()
  catch err
    throw err
    toastReq err, args[0]
  return

###
对网址创建请求对象，发出下一个请求的时候，会自动取消之前的请求
可以避免网络响应抖动造成后面的请求响应被之前的请求响应覆盖
###
< Req = =>
  + ctrl
  (url, opt)=>
    opt = opt or {}

    if ctrl
      ctrl.abort()
    ctrl = new AbortController()
    opt.signal = ctrl.signal
    try
      return await req(url,opt)
    finally
      ctrl = undefined
    return
