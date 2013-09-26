save = (scheduleTable)->
  Kincolle.Schedule.save(scheduleTableToObject(scheduleTable))
  config =
    useGGKSMKK:$('#useGGKSMKK').prop('checked')
  Kincolle.Config.save(config)

load = (scheduleTable)->
  schedule = Kincolle.Schedule.load()
  if schedule
    scheduleObjectToTable(scheduleTable,schedule)
  else
    scheduleTable.find('input').each ()->
      toggleCheck $(this),true,scheduleTable
  setOtherConfig(Kincolle.Config.load())

setOtherConfig = (config)->
  if !config
    return null
  if config.useGGKSMKK
    $('#useGGKSMKK').prop('checked',config.useGGKSMKK)

getDate = (elm)->
  e = $(elm)
  for k in Kincolle.DAY_KEYS
    if e.hasClass(k)
      return k

colorCheck = (cb,scheduleTable)->
  p = $(cb).parents('td')
  if $(cb).prop('checked')
    p.addClass('checked')
  else
    p.removeClass('checked')
  checkDate(scheduleTable, getDate(cb))
  checkHour(cb)

toggleCheck = (cb,val,scheduleTable)->
  colorCheck cb.prop('checked',val),scheduleTable
  cb.parents('td').find('.status').text(if val then "プレイ可" else "プレイ不可")

toggleDateAll = (scheduleTable,date,val)->
  scheduleTable.find("input.#{date}").each ->
    toggleCheck($(@), val, scheduleTable)
    true

checkDate = (scheduleTable,date)->
  s = $(scheduleTable)
  d = s.find("th.date.#{date}")
  flag = true
  s.find("input.#{date}").each ()->
    return (flag = $(@).prop('checked'))
  if flag
    d.addClass('checked')
  else
    d.removeClass('checked')

checkHour = (elm)->
  r = $(elm).parents('tr')
  h = r.find('.hour')
  flag = true

  r.find('input').each ()->
    return (flag = $(@).prop('checked'))
  if flag
    h.addClass('checked')
  else
    h.removeClass('checked')

scheduleTableToObject = (scheduleTable)->
  r = {}
  $(scheduleTable).find('input').each ()->
    n = $(@).attr('id')
    v = $(@).prop('checked')
    r[n] = v
    true
  return r
scheduleObjectToTable = (scheduleTable,object)->
  for k of object 
    toggleCheck(scheduleTable.find("input##{k}"),object[k],scheduleTable)
  null



$ ->
  scheduleTable = $('#schedule-table')
  load(scheduleTable)
  scheduleTable.find('input').on 'change',(e)->
    c = $(@)
    toggleCheck(c,c.prop('checked'),scheduleTable)
    save(scheduleTable)
  scheduleTable.find('td').click (e)->
    c = $(@).find('input')
    toggleCheck(c, !c.prop('checked'),scheduleTable)
    save(scheduleTable)
  scheduleTable.find(".date").click (e)->
    t = $(@)
    for k in Kincolle.DAY_KEYS
      if t.hasClass k
        toggleDateAll scheduleTable,k,!t.hasClass('checked')
        break
    save(scheduleTable)
  scheduleTable.find(".hour").click (e)->
    t = $(@)
    val = !t.hasClass('checked')
    t.parents('tr').find('input').each ()->
      toggleCheck $(@),val,scheduleTable
      true
  $('#useGGKSMKK').on 'change',(e)->
    save(scheduleTable)
