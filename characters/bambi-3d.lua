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
end

local anims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if dadName == 'bambi-3d' or getProperty("dadmirror.curCharacter") == 'bambi-3d' then
        local healthtolower = 0.02;
        if altAnim then 
            healthtolower = 0.005;
            setProperty("dad.holdTimer", 0)
            playAnim("dad", anims[noteData+1], true)
        end
        setProperty("health", getProperty("health") -healthtolower)
    end
end
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if boyfriendName == 'bambi-3d' then
        setProperty("boyfriend.holdTimer", 0)
        playAnim("boyfriend", anims[noteData+1], true)
    end
end