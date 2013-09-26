checkTimeForResponse = (req,sender,sendResponse)->
  sendResponse
    type: "checkTime"
    playable: Kincolle.Schedule.isDatePlayable(new Date())
    config: Kincolle.Config.load()

chrome.runtime.onInstalled.addListener ()->
  if !localStorage.schedule
    chrome.tabs.create({url:chrome.runtime.getURL("options.html")})

chrome.runtime.onMessage.addListener (req,sender,sendResponse)->
  if req.type is "checkTime"
    return checkTimeForResponse(req,sender,sendResponse)
  else
    sendResponse
      type: "error"
      message: "invalid message"
