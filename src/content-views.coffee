window.Kincolle ||= {}
Kincolle.Views ||= {}

Kincolle.Views.generatePlaceHolder =(w,h,config)->
  p = document.createElement('div')
  s = p.style
  s.width = "#{w}px"
  s.height = "#{h}px"
  s.background = "#000"
  s.color = "#fff"
  p.appendChild Kincolle.Views.generateMessage()
  if(config && config.useGGKSMKK)
    p.appendChild Kincolle.Views.generateIgnoreButton(config.click)
  return p

Kincolle.Views.generateMessage = ->
  m = document.createElement('div')
  m.textContent = "提督、今日はお休みではなかったのですか？"
  s = m.style
  s.font = "28px sans-serif"
  s.textAlign = "center"
  s.padding = "15px 0 10px"
  return m

Kincolle.Views.generateIgnoreButton = (click)->
  w = document.createElement('div')
  w.style.textAlign = "center"
  b = document.createElement('button')
  w.appendChild(b)
  b.innerText = "月月火水木金金"
  if click
    b.addEventListener 'click',click
  s = b.style
  s.padding = "8px"
  s.background = "#000"
  s.color = "#fff"
  s.border = "1px solid #fff"
  s.font = "16px sans-serif"
  return w

