< ENV = process.env

< new Proxy(
  {}
  get:(_,name)=>
    new Proxy(
      {}
      get:(_, attr)=>
        ENV[name+'_'+attr] or ''
    )
)

process.on 'uncaughtException', (err) =>
  console.error err
  process.exit 1
  return

