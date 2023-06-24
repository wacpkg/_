> ./HEADER.js
  ./MAP.js
  @w5/console/global.js
  @w5/lib > tld
  @w5/assign
  @w5/stream_buffer
  @w5/msgpack > unpack
  worker_threads > parentPort
  zlib > createBrotliCompress
  ./CONF.js > HOST
  ./Err.js > HttpErr
  !/MID.js

compress = (code,support_br,body,header)=>
  if body
    {length} = body
    if length > 512
      if support_br
        s = createBrotliCompress()
        result = StreamBuffer s
        s.end(body)
        body = await result
        length = body.length
        header['Content-Encoding'] = 'br'
  else
    length = 0
  [
    code
    header
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

  header = {...HEADER}

  f = funcByUrl url
  if f
    func = f[0]
    code = 200
    loop
      try
        if body.length
          r = unpack body
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
        header
      }
      if type
        self.type = type
      try
        for mid from MID
          mr = await mid.call self
          if mr
            assign self, mr

        if r
          if Array.isArray r
            body = func.apply(self, r)
          else
            body = func.call(self, r)
        else
          body = func.call(self)
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

  compress(code,support_br,body,header)

