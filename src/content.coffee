treeContent = []
visible = true
ggksmkk = false

removeChildrenOfTree = (tree)->
  children = []
  for c in tree.children
    children.push(c)
    tree.removeChild(c)
  return children

hideGame = (config)->
  visible = false
  tree = document.querySelector('#area-game')
  width = tree.clientWidth
  height = tree.clientHeight
  placeHolder = generatePlaceHolder(width,height,config)
  treeContent = removeChildrenOfTree(tree)
  tree.appendChild(placeHolder)

showGame = ->
  visible = true
  tree = document.querySelector('#area-game')
  removeChildrenOfTree(tree)
  for c in treeContent
    tree.appendChild(c)

generatePlaceHolder = (w,h,config)->
  p = document.createElement('div')
  s = p.style
  s.width = "#{w}px"
  #s.height = "#{h}px"
  s.height = "610px"
  s.background = "#000"
  s.color = "#fff"
  p.appendChild generateMessage()
  if(config && config.useGGKSMKK)
    p.appendChild generateIgnoreButton()
  return p

generateMessage = ->
  m = document.createElement('div')
  m.textContent = "提督、今日はお休みではなかったのですか？"
  s = m.style
  s.font = "28px sans-serif"
  s.textAlign = "center"
  s.padding = "15px 0 10px"
  return m

generateIgnoreButton = ->
  w = document.createElement('div')
  b = document.createElement('button')
  w.appendChild(b)
  b.innerText = "月月火水木金金"
  b.addEventListener 'click',(e)->
    ggksmkk = true
    showGame()
    e.preventDefault()
    return false
  s = b.style
  s.padding = "8px"
  s.background = "#000"
  s.color = "#fff"
  s.border = "1px solid #fff"
  s.font = "16px sans-serif"
  return w


###############
requestPlayable = ()->
  chrome.runtime.sendMessage {type:"checkTime"},(res)->
    if(visible && !res.playable && !ggksmkk)
      hideGame(res.config)
    else if(!visible && res.playable)
      showGame(res.config)
    now = new Date()
    next = new Date(now.getTime() + 60*60*1000)
    next.setMilliseconds(0)
    next.setSeconds(0)
    next.setMinutes(0)
    setTimeout(requestPlayable,next-now)
    #setTimeout(requestPlayable,60000)

requestPlayable()
