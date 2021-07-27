contentlistmodule = {name: "contentlistmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["contentlistmodule"]?  then console.log "[contentlistmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion


############################################################
M = require("mustache")

entryTemplate = """
    <li id="content-entry{{{count}}}">{{{content}}}</li>
"""

############################################################
contentCount = 0
storage = null

############################################################
contentlistmodule.initialize = ->
    log "contentlistmodule.initialize"
    storage = allModules.storagetreemodule
    return

############################################################
elementClicked = (evt) ->
    log "elementClicked"
    keyHex = evt.target.textContent
    content = storage.load(keyHex)
    textinput.value = content
    return


############################################################
contentlistmodule.add = (keyHex) ->
    log "contentlistmodule.add"
    # cObj = {}
    # cObj.count = ++contentCount
    # cObj.content = keyHex
    contentCount++

    li = document.createElement("LI")
    li.id = "content-entry"+contentCount
    li.textContent = keyHex
    li.addEventListener("click", elementClicked)
    
    contentlist.append(li)
    return


module.exports = contentlistmodule