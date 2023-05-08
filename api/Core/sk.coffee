> @w5/msgpack > pack unpack
  _/Redis > R R_CONF
  @w5/lib > xxh3B36
  @w5/time > Hour

export SK = await R.hgetB R_CONF,'SK'

_code = (hour, args)=>
  msg = pack args.concat [hour]
  xxh3B36(
    msg
    SK
  )

< skCode = (args...)=>
  _code(
    Hour(), args
  )

< skVerify = (code, args...)=>
  code = code.trim()
  hour = Hour()
  (
    code == _code(hour, args) or code == _code(hour-1, args)
  )

