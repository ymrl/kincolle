unplayable = ()->
  window.location.href = chrome.runtime.getURL("iframe-replace.html")
playable = (()->)
Kincolle.ContentMessaging.isPlayable playable,unplayable,
  from: "iframe"
  url: location.href
