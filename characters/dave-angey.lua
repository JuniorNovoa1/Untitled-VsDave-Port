function onCreatePost()
    if boyfriendName == 'dave-angey' then
        propsforChar("boyfriend")
    end
    if dadName == 'dave-angey' then
        propsforChar("dad")
    end
    if getProperty("dadmirror.curCharacter") == 'dave-angey' then
        propsforChar("dadmirror")
    end
end

function propsforChar(char)
    setGraphicSize(char, math.ceil((getProperty(char..".width") * 0.8) / 1.02))
    --updateHitbox(char)
    setProperty(char..".antialiasing", false)
end