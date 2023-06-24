#!/usr/bin/env coffee

> ./IDB.js

[DB,R,W] = await IDB.wac(
  1 # version
  upgrade:(db)=> # upgrade(db, oldVersion, newVersion, transaction, event)
    for [k,o] from Object.entries {
      i18n:keyPath:'id'
      conf:keyPath:'id'
    }
      db.createObjectStore k,o
    return
)

export default DB
export R = R
export W = W
