function onCreatePost()
    if boyfriendName == 'dave-festival-3d' then
        propsforChar("boyfriend")
    end
    if dadName == 'dave-festival-3d' then
        propsforChar("dad")
    end
    if getProperty("dadmirror.curCharacter") == 'dave-festival-3d' then
        propsforChar("dadmirror")
    end
end
function fuckyShitg()
    if boyfriendName == 'dave-festival-3d' then
        propsforChar("boyfriend")
    end
    if dadName == 'dave-festival-3d' then
        propsforChar("dad")
    end
    if getProperty("dadmirror.curCharacter") == 'dave-festival-3d' then
        propsforChar("dadmirror")
    end
end

function propsforChar(char)
    setGraphicSize(char, math.ceil((getProperty(char..".width") * 0.8) / 1.02))
    playAnim(char, "idle", true)
end