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
    (ver, option)=>
      db = await openDB(
        name
        ver
        option
      )

      [
        db
        $(db)
        $(db,'readwrite')
      ]
)

