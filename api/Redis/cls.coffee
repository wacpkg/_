> @w5/u8 > u8merge U8
  @w5/utf8/utf8e.js
  _/Http/CONF.js > DEBUG

_prefix = (prefix, f)=>
  (k, args...)=>
    if k.constructor == String
      k = utf8e k
    k = u8merge prefix, k
    f(
      k
      ...args
    )

key = (prefix)=>
  u8merge(
    prefix
    U8 [0]
  )


< (redis, lua)=>
  for i of redis.constructor::
    redis[i] = redis[i].bind redis

  lua redis

  (prefix, bind)=>
    if bind
      t = key prefix
      for i from bind.split ' '
        prefix[i] = _prefix(
          t
          redis[i]
        )
    prefix

