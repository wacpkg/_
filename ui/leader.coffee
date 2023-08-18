> ./channel.js > toAll hook
  !/_/On.js

ms = => + new Date
# 选举领导人

MSG_LEADER = 1

send = (msg...)=>
  toAll(MSG_LEADER, 1, ...msg)
  return

send1 = => send(1)

+ I_LEADER, unbindBeforeunload, I_LEADER_TIMER, INTERVAL

< ON = new Set # 上位传入 1 下台传入 0

LEADER_HEARTBEAT = ms()

上位 = =>
  I_LEADER = 1
  unbindBeforeunload = On window,{
    beforeunload:=>
      I_LEADER = undefined
      send(0) # 我下台了
      return
  }
  _setInterval send1
  send1()
  for func from ON
    func 1
  return

我想上位 = (timeout)=>
  I_LEADER_TIMER = setTimeout(
    上位
    timeout
  )
  return

heartbeat = =>
  if ms() - LEADER_HEARTBEAT > 2e3
    上位()
  return


_setInterval = (func)=>
  clearInterval(INTERVAL)
  INTERVAL = setInterval(
    func
    1e3
  )
  return

_setInterval heartbeat

下台 = =>
  I_LEADER = undefined
  _setInterval heartbeat
  if unbindBeforeunload
    unbindBeforeunload()
    unbindBeforeunload = undefined
    for func from ON
      func 0
  return

hook(
  MSG_LEADER
  (tab_id, leader)=>
    if leader != undefined
      clearTimeout I_LEADER_TIMER
      switch leader
        when 0 # leader 被关了
          if not I_LEADER
            我想上位(Math.random()*20)
        when 1# 新的 leader 诞生了
          LEADER_HEARTBEAT = ms()
          if I_LEADER
            # 放弃领导权
            下台()
    else if I_LEADER # 响应新窗口的空请求
      send(1)
    return
)

我想上位(200 + Math.random()*100)
send()
