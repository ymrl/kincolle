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
  width = 916
  height = 610
  placeHolder = Kincolle.Views.generatePlaceHolder(width,height,config)
  treeContent = removeChildrenOfTree(tree)
  tree.appendChild(placeHolder)

showGame = ->
  visible = true
  tree = document.querySelector('#area-game')
  removeChildrenOfTree(tree)
  for c in treeContent
    tree.appendChild(c)

###############
playable = (config)->
  if(!visible)
    showGame(config)
unplayable = (config)->
  if(visible && !ggksmkk)
    config.click = (e)->
      ggksmkk = true
      showGame()
      e.preventDefault()
      return false
    hideGame(config)
requestPlayable = ()->
  Kincolle.ContentMessaging.isPlayable playable,unplayable
  now = new Date()
  next = Kincolle.ContentMessaging.getNextPeriod(now)
  setTimeout(requestPlayable,next-now)
requestPlayable()
