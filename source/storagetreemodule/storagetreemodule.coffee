storagetreemodule = {name: "storagetreemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["storagetreemodule"]?  then console.log "[storagetreemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
storageRoot = {}

############################################################
storagetreemodule.initialize = () ->
    log "storagetreemodule.initialize"
    return

############################################################
class StorageMove
    constructor: (@keyHex, @contentString) -> 
        @current = storageRoot
        @i = 0
        return
    
    ########################################################
    start: ->
        @c = @keyHex.charAt(@i)
        @storeCheck()
        return
    offset: (i, node) ->
        @current = node
        @i = i
        return

    ########################################################
    storeCheck: ->
        if @current[@c]? 
            if @current[@c].type == "leaf" then @nextStepForLeaf()
            @nextStep()
        else @store()
        return

    ########################################################
    nextStep: ->
        @current = @current[@c]
        @i++
        @c = @keyHex.charAt(@i)
        if @i == 64 then throw new Error("Collision!")
        @storeCheck()
        return
    
    ########################################################
    nextStepForLeaf: ->
        #In this situation we have another leaf in our way
        # -> push this leaf to the next level
        newNode = {}
        
        leaf = @current[@c]
        key = leaf.keyHex
        nc = key.charAt(@i+1)
        newNode[nc] = leaf

        @current[@c] = newNode
        return

    ########################################################
    store: ->
        @current[@c] = {}
        @current[@c].type = "leaf"
        @current[@c].keyHex = @keyHex
        @current[@c].contentString = @contentString
        return

############################################################
storagetreemodule.store = (keyHex, contentString)->
    log "storagetreemodule.store"
    olog {keyHex}
    move = new StorageMove(keyHex, contentString)
    move.start()
    olog {storageRoot}
    return

storagetreemodule.load = (keyHex) ->
    log "storagetreemodule.load"
    current = storageRoot
    for c,i in keyHex
        if current[c]? then current = current[c]
        else if current.type == "leaf" and current.keyHex == keyHex
            return current.contentString
        else
            throw new Error("Loading failed @"+i+" with char "+c+" for key "+" keyHex \nLast found object was: "+ostr(current))
    return


module.exports = storagetreemodule