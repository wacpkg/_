> ./pkg/lua
  @w5/redis_lua/dot_bind.js

< (redis)=>
  R = DotBind(redis)
  for f from lua
    f R,redis
  return
