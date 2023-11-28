function onCreatePost()
    if boyfriendName == 'bambi-3d' then
        propsforChar("boyfriend")
    end
    if dadName == 'bambi-3d' then
        propsforChar("dad")
    end
    if getProperty("dadmirror.curCharacter") == 'bambi-3d' then
        propsforChar("dadmirror")
    end
end

function propsforChar(char)
    setGraphicSize(char, math.ceil((getProperty(char..".width") * 1.5) / 1.02))
    playAnim(char, "idle", true)
end