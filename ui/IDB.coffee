> idb > openDB

$ = (db, mode)=>
  new Proxy(
    {}
    get:(_,name)=>
      tx = db.transaction name,mode
      tx.objectStore name
  )

export default new Proxy(
  {}
  get:(_,name)=>
    (ver, upgrade)=>
      db = await openDB(
        name
        ver
        upgrade
      )

      [
        db
        $(db)
        $(db,'readwrite')
      ]
)

