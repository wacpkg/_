class TOAST
    constructor:->
        @_li = []
        @_offset = 0

    new : (msg, option={})->
        {timeout, body, close} = Object.assign(
            {
                timeout:5
                body:document.body
                close:1
            }
            option
        )
        if close
          msg+='<i class="x"></i>'

        li = @_li
        elem = document.createElement("div")
        elem.className = "animated fadeInLeft toast"
        elem.style.marginBottom = @_offset+'px'
        elem.innerHTML = msg
        # elem = $ """<div class="" style=>#{msg}</div>"""
        li.push elem
        body.appendChild elem
        @_offset += (14+elem.offsetHeight)
        elem.close = close = =>
            elem.classList.add "fadeOutLeft"
            setTimeout(
                =>
                    li.splice li.indexOf(elem), 1
                    body.removeChild elem
                    offset = 0
                    for i,pos in li
                        i.style.marginBottom = offset+'px'
                        offset += (14+i.offsetHeight)
                    @_offset = offset
                500
            )
        if close
          elem.getElementsByClassName("x")[0].onclick = close
        if timeout
          setTimeout(
              close
              timeout*1000
          )
        return elem

TOAST = new TOAST()

window.toast = ->
    TOAST.new.apply TOAST, arguments
