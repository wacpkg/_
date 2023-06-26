> @w5/sdk
  @w5/escape
  ./gen/sdkThrow.js
  ./CDN.js > set:cdnSet
  ./lang.js:@ > HOOK
  !/DEV
  ./toast.js > toastErr

[proxy, sdkInit, setLang] = sdk(
  (r, next, url, req_option)=>
    if not ( r instanceof Error )
      for t from sdkThrow
        r = await t(r, next, url, req_option)
        if not ( r instanceof Response )
          return r

    status = r?.status
    if not [406,412].includes status
      if status
        tip = status
        try
          tip += (' : '+await r.text())
        catch
          null
      else
        tip = r.toString()
      toastErr escape(url+' ❯ '+tip)
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

