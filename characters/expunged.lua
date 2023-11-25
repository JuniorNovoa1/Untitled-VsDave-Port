function onCreatePost()
    if boyfriendName == 'expunged' then
        propsforChar("boyfriend")
    end
    if dadName == 'expunged' then
        propsforChar("dad")
    end
    if getProperty("dadmirror.curCharacter") == 'expunged' then
        propsforChar("dadmirror")
    end
end

function propsforChar(char)
    setGraphicSize(char, math.ceil((getProperty(char..".width") * 0.8) / 1.02))
end