#!/usr/bin/env coffee

> @w5/xedis > conn Server
  @w5/onexit
  ./CONF > REDIS_DB REDIS_PASSWORD REDIS_USER REDIS_HOST_PORT

redis = await conn(
  if Array.isArray REDIS_HOST_PORT[0] then Server.cluster(REDIS_HOST_PORT) else Server.hostPort(...REDIS_HOST_PORT)
  REDIS_USER
  REDIS_PASSWORD
  REDIS_DB
)

onexit =>
  redis.quit()

< default redis
