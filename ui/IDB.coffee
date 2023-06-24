> idb > openDB

export SAMPLER_NAME = 'samplerName'

export new Proxy(
  {}
  get:(_,name)=>
    (upgrade)=>
      db = openDB(
        name
        1
        upgrade
      )
      db
)

# openDB(
#   'art'
#   1
#   # upgrade(db, oldVersion, newVersion, transaction, event)
#   upgrade:(db)=>
#     db.createObjectStore(SAMPLER_NAME, keyPath:'id')
#     return
# )
#
# IDB = await
# _t = (mode, name)=>
#   tx = IDB.transaction name,mode
#   tx.objectStore name
#
# export R = _t.bind(_t,undefined)
#
# export W = _t.bind(_t,'readwrite')
#
#
# export default IDB
