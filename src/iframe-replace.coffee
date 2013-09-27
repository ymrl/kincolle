ggksmkk = false

reload = ()->
  Kincolle.ContentMessaging.getIframeURL (url)->
    location.href = url

playable = (config)->
  reload()

unplayable = (config)->
  config.click = (e)->
    Kincolle.ContentMessaging.playableOnce (config)->
      reload()
    e.preventDefault()
    return false
  width = $(window).innerWidth()
  height = $(window).innerHeight()
  placeHolder = Kincolle.Views.generatePlaceHolder(width,height,config)
  $('#area-game').append(placeHolder)
  $(window).on 'resize',(e)->
    $(placeHolder).css
      width  : $(@).width()
      height : $(@).height()

requestPlayable = ()->
  Kincolle.ContentMessaging.isPlayable playable,unplayable
  now = new Date()
  next = Kincolle.ContentMessaging.getNextPeriod(now)
  setTimeout(requestPlayable,next-now)

$ ->
  requestPlayable()
  
