> wtax/On.js

< ({content}, bind, rm)=>
  ({target})->
    {parentNode} = target
    if target.menu
      return
    target.menu = true
    menu = document.importNode(content,true)
    parentNode.append menu
    menu = parentNode.lastChild
    bind?.call(target,menu)
    setTimeout =>
      unbind = On document.body,{
        click:=>
          rm?.call(target)
          delete target.menu
          setTimeout(
            =>
              parentNode.removeChild menu
              return
          )
          unbind()
          return
      }
      return
    menu
