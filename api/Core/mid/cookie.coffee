> @w5/lib > randomBytes cookieDecode cookieEncode xxh64 ipBin zipU64 unzipU64
  @w5/u8 > U8 u8eq u8merge
  _/Core/sk > SK
  _/Sql/clientNew
  @w5/redis/ID

{client:clientId} = ID

MAX_INTERVAL = 41
BASE = 4096

+ DAY

_day = =>
  # 每10天为一个周期，超过40个周期没访问就认为无效, base是为了防止数字过大
  # https://chromestatus.com/feature/4887741241229312
  # When cookies are set with an explicit Expires/Max-Age attribute the value will now be capped to no more than 400 days
  DAY = Number.parseInt(new Date()/864e6)%BASE
  return

_day()
setInterval _day, 864e5

SK_LEN = 8

_set = (client_id)->
  args = zipU64 DAY,client_id
  sk = xxh64(SK,args)
  cookie = cookieEncode(sk, args)
  {host} = @
  p = host.indexOf ':'
  if p > 0
    host = host[...p]
  @header['Set-Cookie'] = "I=#{cookie};max-age=99999999;domain=#{host};path=/;HttpOnly;SameSite=None;Secure"
  return

_new = ->
  client_id = await clientId()

  clientNew(
    client_id
    ipBin @ip
    ...@agent
  )
  _set.call @,client_id
  client_id

< ->

  {I,agent} = @

  if I
    try
      I = cookieDecode I
    catch
      I = undefined

    if I and I.length > SK_LEN
      sk = I[...SK_LEN]
      I = I[SK_LEN..]
      if not u8eq xxh64(SK,I),sk
        I = undefined

  if I
    [day, client_id] = unzipU64 I
    if day != DAY
      if (
        (DAY - day) < MAX_INTERVAL
      ) or (
        day > DAY and (DAY + BASE - day) < MAX_INTERVAL
      )
        _set.call @,client_id
      else
        client_id = await _new.call @
  else
    client_id = await _new.call @

  {
    I:client_id
  }
