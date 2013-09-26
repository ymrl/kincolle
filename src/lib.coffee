window.Kincolle ||= {}


Kincolle.Schedule = {}
Kincolle.Schedule.load = ()->
  if localStorage.schedule
    return JSON.parse(localStorage.schedule)
  else
    return null

Kincolle.Schedule.save = (data)->
  localStorage.schedule = JSON.stringify(data)

Kincolle.Schedule.isDatePlayable =(date)->
  schedule = Kincolle.Schedule.load()
  if schedule
    day = Kincolle.DAY_KEYS[date.getDay() - 1]
    hour = date.getHours()
    return schedule["#{day}#{hour}"]
  else
    return true

Kincolle.Config = {}
Kincolle.Config.load = ()->
  if localStorage.config
    return JSON.parse(localStorage.config)
  else
    return null

Kincolle.Config.save = (config)->
  current = Kincolle.Config.load()
  if current
    for key of config
      current[key] = config[key]
    config = current
  localStorage.config = JSON.stringify(config)
