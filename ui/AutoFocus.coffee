> ./On.js
  ./Focus.js

< (form)=>
  _focus = =>
    focus = Focus form
    focus()
    return
  _focus()
  On form,{
    submit:_focus
  }
  On document, {
    visibilitychange: =>
      (document.visibilityState == 'visible') and _focus()
      return
  }
