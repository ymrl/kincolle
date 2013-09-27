window.Kincolle ||={}

Kincolle.ContentMessaging ||={}
Kincolle.ContentMessaging.isPlayable = (playable,unplayable,option)->
  chrome.runtime.sendMessage {type:"checkTime",option:option},(res)->
    if res.playable
      playable(res.config)
    else
      unplayable(res.config)

Kincolle.ContentMessaging.getNextPeriod = (now)->
  next = new Date(now.getTime() + 60*60*1000)
  next.setMilliseconds(0)
  next.setSeconds(0)
  next.setMinutes(0)
  return next
Kincolle.ContentMessaging.playableOnce = (callback,option)->
  chrome.runtime.sendMessage {type:"playableOnce",option:option},(res)->
    callback(res.config)

Kincolle.ContentMessaging.getIframeURL = (callback,option)->
  chrome.runtime.sendMessage {type:"getIframeURL",option:option},(res)->
    callback(res.url)
