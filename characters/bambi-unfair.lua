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
end

local anims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if dadName == 'bambi-unfair' or getProperty("dadmirror.curCharacter") == 'bambi-unfair' then
        local healthtolower = 0.02;
        setProperty("health", getProperty("health") -(healthtolower / 3))
    end
end