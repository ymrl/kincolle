checkTimeForResponse = (req,sender,sendResponse,option)->
  playable = Kincolle.Schedule.isDatePlayable(new Date())
  if option && option.from is "iframe" 
    Kincolle.Temp.set("iframe-url",option.url)
    if Kincolle.Temp.get("playableOnce")
      playable = true
  sendResponse
    type: "checkTime"
    playable: playable
    config: Kincolle.Config.load()

playableOnceForResponse = (req,sender,sendResponse,option)->
  Kincolle.Temp.set('playableOnce',true)
  sendResponse
    type: "playableOnce"

getIframeURLForResponse = (req,sender,sendResponse,option)->
  sendResponse
    type: "getIFrameURL"
    url: Kincolle.Temp.get("iframe-url")

chrome.runtime.onInstalled.addListener ()->
  if !localStorage.schedule
    chrome.tabs.create({url:chrome.runtime.getURL("options.html")})

chrome.runtime.onMessage.addListener (req,sender,sendResponse)->
  if req.type is "checkTime"
    return checkTimeForResponse(req,sender,sendResponse,req.option)
  else if req.type is "playableOnce"
    return playableOnceForResponse(req,sender,sendResponse,req.option)
  else if req.type is "getIframeURL"
    return getIframeURLForResponse(req,sender,sendResponse,req.option)
  else
    sendResponse
      type: "error"
      message: "invalid message"
