> ./worker.js
  ./CONF.js > DEBUG

if DEBUG
  await import('@w5/console/global.js')

_exit = =>
  process.kill(process.pid, "SIGINT")
  return


MAX_MEM_LEAK = 256
{memoryUsage} = process
{ rss } = memoryUsage()

gcpoint = 32

+ WORKER_ID
TIMEOUT_COUNT = 0
ING = 0

# 定时任务: 没请求就退出，防止孤儿进程
INTERVAL = setInterval(
  =>
    console.log {WORKER_ID}
    if TIMEOUT_COUNT == 0
      exit()
    else
      TIMEOUT_COUNT = 0
      used = memoryUsage().rss
      diff = (used - rss)/1048576
      if gcpoint > MAX_MEM_LEAK and diff > MAX_MEM_LEAK
        exit()
        return
      else if diff > gcpoint
        gc()
        gcpoint += 32
    return
  4e4
)

exit = =>
  clearInterval INTERVAL
  process.send WORKER_ID
  setInterval(
    =>
      if ING == 0
        _exit()
      else
        console.log 'memoryUsage', used, 'leak', diff, 'ING', ING, 'wait auto exit'
      return
    3e3
  )
  return


next = (msg)=>
  if DEBUG
    console.log 'recv TIMEOUT_COUNT='+TIMEOUT_COUNT,'ING='+ING,msg
  if Array.isArray msg
    ++TIMEOUT_COUNT
    ++ING
    rid = msg.pop()
    try
      process.send [
        rid
        await worker msg
      ]
    catch err
      console.trace err
    finally
      --ING
  else
    switch msg
      when -1
        exit()
  return

MESSAGE = 'message'
process.on MESSAGE,(id)=>
  WORKER_ID = id
  console.log {WORKER_ID}
  process.removeAllListeners MESSAGE
  process.on MESSAGE, next
  return
