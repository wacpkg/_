> ./channel.js > toAll hook

# 选举领导人

< TAB_ID = ((Math.floor(new Date)%9007199254739) * 1e3) + Math.floor(Math.random()*1e3)

MSG_LEADER = 1

send = (msg...)=>
  toAll(MSG_LEADER, TAB_ID, ...msg)
  return


+ I_LEADER, LEADER, unbindBeforeunload, I_LEADER_TIMER

上位 = =>
  LEADER = TAB_ID
  I_LEADER = 1
  unbindBeforeunload = On window,{
    beforeunload:=>
      I_LEADER = LEADER = undefined
      send(0)
      return
  }
  send(1)
  document.title = 'leader'
  return

我想上位 = (timeout)=>
  I_LEADER_TIMER = setTimeout(
    上位
    timeout
  )
  return

下台 = =>
  I_LEADER = undefined
  return

hook(
  MSG_LEADER
  (tab_id, leader)=>
    if leader != undefined
      clearTimeout I_LEADER_TIMER
      if leader == 0 # leader 被关了
        我想上位(Math.random()*20)
      else # 新的 leader 诞生了
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
