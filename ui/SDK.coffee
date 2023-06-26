> @w5/sdk
  ./gen/sdkThrow.js
  ./CDN.js > set:cdnSet
  ./lang.js:@ > HOOK
  !/DEV
  ./toast.js:

[proxy, sdkInit, setLang] = sdk(
  (r, next, url, req_option)=>
    if not ( r instanceof Error )
      for t from sdkThrow
        r = await t(r, next, url, req_option)
        if not ( r instanceof Response )
          return r
    toast.err(url+' ❯ '+r.toString())
    throw r
    return
)

< init = (api_url, cdn)=>
  cdnSet cdn
  sdkInit(api_url, lang())
  HOOK.add setLang
  return

if DEV
  window.SDK = proxy

< default proxy

