textinputmodule = {name: "textinputmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["textinputmodule"]?  then console.log "[textinputmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
utl = null
storage = null
contentList = null

############################################################
textinputmodule.initialize = ->
    log "textinputmodule.initialize"
    utl = allModules.utilmodule
    storage = allModules.storagetreemodule
    contentList = allModules.contentlistmodule

    textinput.addEventListener("change", textChanged)
    return

############################################################
textChanged = (evt) ->
    log "textChanged"
    content = textinput.value
    key = await utl.sha256Hex(content)
    storage.store(key, content)

    contentList.add(key)
    return
    
module.exports = textinputmodule