> ./toast.js > toastErr

< (r, url)=>
  status = r.status
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
  return
