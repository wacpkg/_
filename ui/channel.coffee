#!/usr/bin/env coffee

> wtax/web/tld.js
  wtax/On.js

HOOK = new Map

< PREFIX='wac:'

< ALL = new BroadcastChannel PREFIX+tld

On ALL,{
  message:(e)=>
    {data} = e
    kind = data.pop()
    HOOK.get(kind)(...data)
    return
}

< hook = (kind, func)=>
  HOOK.set kind, func
  =>
    HOOK.delete kind
    return

< toAll = (kind, msg...)=>
  ALL.postMessage [...msg,kind]
  return

# MSG_NEW = 1
# LEADER = 0
# NEW_REPLY = []
#
# < reply = (tab_id)=>
#   CHANNEL.postMessage [
#     MSG_NEW
#     tab_id
#     TAB_ID
#     USER_SIGNIN
#     USER_EXIT
#   ]
#   return
#
# On CHANNEL,{
#   message:(e)=>
#     {data,origin} = e
#     if not sameHost origin
#       return
#
#     {length} = data
#
#     switch data[0]
#       when MSG_NEW
#         tab_id = data[1]
#
#         if length == 2
#           if INIT
#             return
#
#           if LEADER
#             reply tab_id
#           else
#             data.push _ms()
#             NEW_REPLY.push data
#             timeout = 10
#             await sleep timeout
#             if NEW_REPLY.length
#               li = NEW_REPLY.filter(
#                 (i)=>
#                   time = i[2]
#                   timeout = (new Date - time) >= timeout
#                   if timeout
#                     reply(i[1])
#                   !timeout
#               )
#               if li.length != NEW_REPLY.length
#                 NEW_REPLY = li
#                 if not LEADER
#                   LEADER = 1
#                   #document.title = 'leader'
#                   unbindBeforeunload = On window,{
#                     beforeunload:=>
#                       # 重新选举避免延时(没有leader的时候，延时甚至可能会高达1秒)
#                       initPost()
#                       return
#                   }
#         else
#           user_li = data[3..]
#           _setUser ...user_li
#
#           if tab_id == 0
#             return
#
#           src_id = data[2]
#           if src_id == TAB_ID
#             initPost()
#
#           for i,pos in NEW_REPLY
#             if i[1] == tab_id
#               NEW_REPLY.splice(pos,1)
#               return
#
#           if LEADER
#             if src_id <= TAB_ID
#               #document.title = 'member'
#               unbindBeforeunload()
#               unbindBeforeunload = undefined
#               LEADER = 0
#     return
# }
#
# initPost()
