function onCreatePost()
    if boyfriendName == 'bambi-unfair' then
        propsforChar("boyfriend")
    end
    if dadName == 'bambi-unfair' then
        propsforChar("dad")
    end
    if getProperty("dadmirror.curCharacter") == 'bambi-unfair' then
        propsforChar("dadmirror")
    end
end

function propsforChar(char)
    setGraphicSize(char, math.ceil((getProperty(char..".width") * 1.3) / 1.02))
    playAnim(char, "idle", true)
end