DAYS = ["mo", "tu", "we", "th", "fr", "sa", "su"]

loadSchedule = ()->
  if localStorage.schedule
    return JSON.parse(localStorage.schedule)
  else
    return null
loadConfig = ()->
  if localStorage.config
    return JSON.parse(localStorage.config)
  else
    return null

checkTime = ()->
  schedule = loadSchedule()
  if !schedule
    return true
  else
    now = new Date()
    day = DAYS[now.getDay() - 1]
    hour = now.getHours()
    return schedule["#{day}#{hour}"]

checkTimeForResponse = (req,sender,sendResponse)->
  sendResponse
    type: "checkTime"
    playable: checkTime()
    config: loadConfig()

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
