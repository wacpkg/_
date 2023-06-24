#!/usr/bin/env coffee

> ./IDB.js

[DB,R,W] = await IDB.wac(
  1 # version
  upgrade:(db)=> # upgrade(db, oldVersion, newVersion, transaction, event)
    db.createObjectStore('i18n', keyPath:'id')
    return
)

export default DB
export R = R
export W = W
