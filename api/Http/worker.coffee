> ./HEADER.js
  ./MAP.js
  @w5/console/global.js
  @w5/lib > tld
  @w5/assign
  @w5/stream_buffer
  worker_threads > parentPort
  zlib > createBrotliCompress
  ./CONF.js > HOST
  ./Err.js > HttpErr
  !/MID.js

compress = (code,support_br,body,res_headers)=>
  if body
    {length} = body
    if length > 512
      if support_br
        s = createBrotliCompress()
        result = StreamBuffer s
        s.end(body)
        body = await result
        length = body.length
        res_headers['Content-Encoding'] = 'br'
  else
    length = 0
  [
    code
    res_headers
    body
  ]

funcByUrl = (url)=>
  li = url.split('.')
  n = 0
  len = li.length

  f = MAP
  while n < len
    i = li[n++]
    f = f.get(i)
    if n < len
      if f not instanceof Map
        return

  if f instanceof Map
    f = f.get 'default'

  f

< ([url,body,ip,protocol,origin,referer,host,lang,I,agent,type,support_br])=>
  + body

  res_headers = {...HEADER}

  f = funcByUrl url
  if f
    func = f[0]
    code = 200
    loop
      try
        if body.length
          r = JSON.parse body
      catch
        code = 500
        body = "NOT MSGPACK : #{body}"
        break

      origin = tld origin

      self = {
        I
        ip
        host
        protocol
        referer
        origin
        lang
        url
        agent
      }
      if type
        self.type = type
      req = new Proxy(
        self
        set:(_,k,v)=>
          res_headers[k]=v
          true
      )
      try
        for mid from MID
          mr = await mid.call req
          if mr
            assign self, mr

        if r
          if Array.isArray r
            body = func.apply(req, r)
          else
            body = func.call(req, r)
        else
          body = func.call(req)
        body = await body
        for f from f[1]
          body = f body
      catch err
        if err instanceof HttpErr
          {code,body} = err
        else
          [
            url
            r
            err
          ].map (e, pos)=>

            if pos == 1
              args = [' ',e]
            else
              args = [e]
            console.error(...args)
            return
          code = 500
          body = err.toString()
      break
  else
    code = 404
    body = '404 : '+url

  compress(code,support_br,body,res_headers)

