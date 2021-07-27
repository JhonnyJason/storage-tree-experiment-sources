utilmodule = {name: "utilmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["utilmodule"]?  then console.log "[utilmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

secUtl = require("secret-manager-crypto-utils")
Object.assign(utilmodule,secUtl)

############################################################
utilmodule.initialize = () ->
    log "utilmodule.initialize"
    return
    
module.exports = utilmodule