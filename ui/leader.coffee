#!/usr/bin/env coffee

> ./channel.js > toAll hook

# 选举领导人

< TAB_ID = ((Math.floor(new Date)%9007199254739) * 1e3) + Math.floor(Math.random()*1e3)


MSG_LEADER = 1

+ I_LEADER, LEADER, unbindBeforeunload, I_LEADER_TIMER

iLeader = =>
  LEADER = TAB_ID
  I_LEADER = 1
  unbindBeforeunload = On window,{
    beforeunload:=>
      I_LEADER = LEADER = undefined
      toAll(MSG_LEADER, TAB_ID, 0)
      return
  }
  toAll(MSG_LEADER, TAB_ID, 1)
  document.title = 'leader'
  return

can_i_leader = =>
  I_LEADER_TIMER = setTimeout(
    iLeader
    200 + Math.random()*100
  )
  return

can_i_leader()

hook(
  MSG_LEADER
  (tab_id, leader)=>
    if leader != undefined
      clearTimeout I_LEADER_TIMER
      if leader == 0
        can_i_leader()
      else
        if I_LEADER
          if TAB_ID < tab_id
            toAll(MSG_LEADER, TAB_ID, 1)
          else
            # 放弃领导权
            I_LEADER = undefined
            LEADER = tab_id
            document.title = ''
        else
          LEADER = tab_id
    else if I_LEADER
      toAll(MSG_LEADER, TAB_ID, 1)
    return
)

toAll(MSG_LEADER, TAB_ID)
