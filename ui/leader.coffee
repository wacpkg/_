> ./channel.js > toAll hook

ms = => + new Date
# 选举领导人

< TAB_ID = ((Math.floor(new Date)%9007199254739) * 1e3) + Math.floor(Math.random()*1e3)

MSG_LEADER = 1

send = (msg...)=>
  toAll(MSG_LEADER, TAB_ID, ...msg)
  return

send1 = => send(1)

+ I_LEADER, LEADER, unbindBeforeunload, I_LEADER_TIMER, INTERVAL

LEADER_HEARTBEAT = ms()

上位 = =>
  LEADER = TAB_ID
  I_LEADER = 1
  unbindBeforeunload = On window,{
    beforeunload:=>
      I_LEADER = LEADER = undefined
      send(0) # 我下台了
      return
  }
  _setInterval send1
  send1()
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
  unbindBeforeunload?()
  _setInterval heartbeat
  return

hook(
  MSG_LEADER
  (tab_id, leader)=>
    if leader != undefined
      clearTimeout I_LEADER_TIMER
      switch leader
        when 0 # leader 被关了
          我想上位(Math.random()*20)
        when 1# 新的 leader 诞生了
          LEADER_HEARTBEAT = ms()
          if I_LEADER
            if TAB_ID < tab_id
              send(1)
            else
              # 放弃领导权
              下台()
              LEADER = tab_id
          else
            LEADER = tab_id
    else if I_LEADER
      send(1)
    return
)

我想上位(200 + Math.random()*100)
send()
