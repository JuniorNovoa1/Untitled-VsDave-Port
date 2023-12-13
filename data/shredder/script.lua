local lockCam = false;
local prevPos = {0, 0}

function onCreate()
    addCharacterToList("bambi-shredder", "dad")
    local cahcedpAssets = {'bambi_spot', 'boyfriend_spot', 'ch_highway'}
	for i = 1, #cahcedpAssets do
		precacheImage('festival/shredder/'..cahcedpAssets[i]);
	end
end

function onUpdate(elapsed)
    if lockCam then triggerEvent("Camera Follow Pos", ""..prevPos[1], ""..prevPos[2]) end
end

local xPosSytrumsd = 271;
function onStepHit()
    if curStep == 261 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
		cameraFlash("hud", "FFFFFF", 0.5 / playbackRate)
		makeLuaSprite("black", "", 0, 0)
		makeGraphic("black", screenWidth * 2, screenHeight * 2, '000000')
		setProperty("black.alpha", 0)
		screenCenter("black")
		addLuaSprite("black", true)
		doTweenAlpha("black", "black", 0.6, 1 / playbackRate, "")
		callOnLuas("makeInvisibleNotes", {true});
        callOnLuas("createDialogue", {"shred_sub1", 0.02, 0.3})
	end 
    if curStep == 273 then
        callOnLuas("createDialogue", {"shred_sub2", 0.02, 0.6})
	end 
    if curStep == 296 then
		callOnLuas("createDialogue", {"shred_sub3", 0.02, 0.6})
	end 
    if curStep == 325 then
		callOnLuas("createDialogue", {"shred_sub4", 0.02, 0.6})
	end 
    if curStep == 342 then
        callOnLuas("createDialogue", {"shred_sub5", 0.02, 0.6})
	end 
    if curStep == 356 then
        callOnLuas("createDialogue", {"shred_sub6", 0.02, 0.6})
	end 
    if curStep == 361 then
        callOnLuas("createDialogue", {"shred_sub7", 0.02, 0.6})
	end 
    if curStep == 384 then
		callOnLuas("createDialogue", {"shred_sub8", 0.02, 0.6, 60})
	end 
    if curStep == 393 then
        callOnLuas("createDialogue", {"shred_sub9", 0.02, 0.6, 60})
	end 
    if curStep == 408 then
        callOnLuas("createDialogue", {"shred_sub10", 0.02, 0.6, 60})
	end 
    if curStep == 425 then
        callOnLuas("createDialogue", {"shred_sub11", 0.02, 0.6, 60})
	end 
    if curStep == 484 then
        callOnLuas("createDialogue", {"shred_sub12", 0.02, 0.6, 60})
	end 
    if curStep == 512 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
		cameraFlash("hud", "FFFFFF", 1 / playbackRate)
        doTweenAlpha("black", "black", 0, 1 / playbackRate, "")
		callOnLuas("makeInvisibleNotes", {false})
	end 
    if curStep == 784 or curStep == 816 or curStep == 912 or curStep == 944 then
		--blocked shaders
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
        doTweenAlpha("black", "black", 0.6, 1 / playbackRate, "")
	end 
    if curStep == 800 or curStep == 832 or curStep == 928 then
		--remove blocked shaders
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
        doTweenAlpha("black", "black", 0, 1 / playbackRate, "")
	end 
    if curStep == 960 then
        --blocked shaders?
        setProperty("defaultCamZoom", 0.7)
        doTweenAlpha("black", "black", 0, 1 / playbackRate, "")
	end 
    if curStep == 992 then
        for i = 0, 3 do
            noteTweenAlpha("dadNote"..i, i, 0, 1 / playbackRate, "")
        end
	end 
    if curStep == 1008 then
        triggerEvent("Change Character", "dad", "bambi-shredder")
        playAnim("dad", "takeOut", true)
	end
    if curStep == 1024 then
        cameraFlash("hud", "FFFFFF", 1 / playbackRate)

        for i = 4, 7 do
            cancelTween("bfNote"..i)
        end
        for i = 0, 3 do
            setPropertyFromGroup("opponentStrums", i, "alpha", 1)
        end
        setPropertyFromGroup("opponentStrums", 4, "alpha", 1)
		
        prevPos = {getProperty("camFollowPos.x"), getProperty("camFollowPos.y")}
		lockCam = true;

        runHaxeCode([[
            game.dad.cameras = [game.camHUD];
            game.dad.scrollFactor.set();
        ]])
        scaleObject("dad", getProperty("dad.scale.x") * 0.55, getProperty("dad.scale.y") * 0.55, true)
        runHaxeCode([[
            game.dad.setPosition(0, 0);
        ]])

        makeLuaSprite("bambiSpot", "festival/shredder/bambi_spot", 34, 151)
        setScrollFactor("bambiSpot", 0, 0)
        setBlendMode("bambiSpot", 'ADD')
        setObjectCamera("bambiSpot", 'hud')
        addLuaSprite("bambiSpot", false)

        makeLuaSprite("bfSpot", "festival/shredder/boyfriend_spot", 995, 381)
        setScrollFactor("bfSpot", 0, 0)
        setBlendMode("bfSpot", 'ADD')
        setObjectCamera("bfSpot", 'hud')
        addLuaSprite("bfSpot", false)
        setProperty("bfSpot.alpha", 0)

        setProperty("boyfriend.alpha", 0)
        runHaxeCode([[
            game.boyfriend.cameras = [game.camHUD];
            game.boyfriend.scrollFactor.set();
        ]])
        scaleObject("boyfriend", getProperty("boyfriend.scale.x") * 0.45, getProperty("boyfriend.scale.y") * 0.45, true)
        runHaxeCode([[
            game.boyfriend.setPosition((game.getLuaObject("bfSpot", false).x - (game.boyfriend.width / 3.25)) + game.boyfriend.positionArray[0] * 0.45, (game.getLuaObject("bfSpot", false).y - (game.boyfriend.height * 1.1)) + game.boyfriend.positionArray[1] * 0.45);
        ]])

        makeLuaSprite("black", "", 0, 0)
        makeGraphic("black", 2560, 1440, '000000')
        setScrollFactor("black", 0.0, 0.0)
        setProperty("black.alpha", 0.9)
        screenCenter("black")
        addLuaSprite("black", true)

        makeLuaSprite("highway2", "festival/shredder/ch_highway", 0, 0)
        setGraphicSize("highway2", math.floor(getProperty("highway2.width") * (640 / getProperty("highway2.width"))), math.floor(getProperty("highway2.height") * (1280 / getProperty("highway2.height"))), true)
        updateHitbox("highway2")
        screenCenter("highway2", 'xy')
        setObjectCamera("highway2", 'hud')
        addLuaSprite("highway2", false)

        makeLuaSprite("highway", "festival/shredder/ch_highway", 0, 0)
        setGraphicSize("highway", math.floor(getProperty("highway.width") * (640 / getProperty("highway.width"))), math.floor(getProperty("highway.height") * (1280 / getProperty("highway.height"))), true)
        updateHitbox("highway")
        screenCenter("highway", 'xy')
        setObjectCamera("highway", 'hud')
        setBlendMode("highway", 'ADD')
        addLuaSprite("highway", false)
						
        callOnLuas("changeNoteSkin", {false, "NOTE_gh"})
        for i = 0, 1 do
            setPropertyFromGroup("strumLineNotes", i, "x", getPropertyFromGroup("strumLineNotes", i, "x") + xPosSytrumsd)
        end
        for i = 2, 3 do
            setPropertyFromGroup("strumLineNotes", i, "x", getPropertyFromGroup("strumLineNotes", i, "x") + (xPosSytrumsd + 114))
        end
        setPropertyFromGroup("opponentStrums", 4, "x", getPropertyFromGroup("opponentStrums", 4, "x") - 220)
        for i = 4, 7 do
            setPropertyFromGroup("strumLineNotes", i, "x", getPropertyFromGroup("strumLineNotes", i, "x") - 310)
            setPropertyFromGroup("strumLineNotes", i, "alpha", 0)
        end
	end 
    if curStep == 1276 then
        doTweenAlpha("dadNoteGuitar", "opponentStrums.members[4]", 0, (stepCrochet / 1000) * 2, "")
        for i = 0, 3 do
            noteTweenAlpha("dadNote"..i, i, 0, ((stepCrochet / 1000) * 2) / playbackRate, "")
        end
        for i = 4, 7 do
            noteTweenAlpha("bfNote"..i, i, 1, ((stepCrochet / 1000) * 2) / playbackRate, "")
        end
	end 
    if curStep == 1280 then
        doTweenAlpha("boyfriend", "boyfriend", 1, 1 / playbackRate, "")
        doTweenAlpha("bfSpot", "bfSpot", 1, 1 / playbackRate, "")
	end 
    if curStep == 1536 then
        makeLuaSprite("blackFront", "", 0, 0)
		makeGraphic("blackFront", screenWidth * 2, screenHeight * 2, '000000')
		setProperty("blackFront.alpha", 0)
		screenCenter("blackFront")
		addLuaSprite("blackFront", true)
        doTweenAlpha("blackFront", "blackFront", 1, 0.5 / playbackRate, "")
        --[[ after tween
        ]]
						--regenerateStaticArrows(0);

        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
	    --set blocked shader
        doTweenAlpha("black", "black", 0.6, 1 / playbackRate, "")
		callOnLuas("makeInvisibleNotes", {true})
	end 
    if curStep == 1552 then
		--remove blocked shoder
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
	end 
    if curStep == 1568 then
		--blocked shader
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
	end 
    if curStep == 1584 then
		--removed blocked shader
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
	end
    if curStep == 1600 then
		--blocked shader
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
	end 
    if curStep == 1616 then
		--remove blocked shader
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
	end 
    if curStep == 1632 then
		--blocked shader
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
	end 
    if curStep == 1648 then
        doTweenAlpha("black", "black", 1, 1 / playbackRate, "")
		--remove blocked shader
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
	end 
    if curStep == 1664 then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.9)
        cameraFlash("hud", "FFFFFF", 1 / playbackRate)
        doTweenAlpha("black", "black", 0, 1 / playbackRate, "")
        for i = 0, 1 do
            setPropertyFromGroup("strumLineNotes", i, "x", getPropertyFromGroup("strumLineNotes", i, "x") - xPosSytrumsd)
        end
        for i = 2, 3 do
            setPropertyFromGroup("strumLineNotes", i, "x", getPropertyFromGroup("strumLineNotes", i, "x") - (xPosSytrumsd + 114))
        end
        for i = 4, 7 do
            setPropertyFromGroup("strumLineNotes", i, "x", getPropertyFromGroup("strumLineNotes", i, "x") + 310)
        end
		callOnLuas("makeInvisibleNotes", {false})
	end 
    if curStep == 1937 then
        callOnLuas("createDialogue", {"shred_sub13", 0.02, 0.6, 60})
	end 
    if curStep == 1946 then
        callOnLuas("createDialogue", {"shred_sub14", 0.02, 0.6, 60})
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if lockCam then
        runHaxeCode([[
            game.boyfriend.offset.x *= 0.45;
            game.boyfriend.offset.y *= 0.45;
        ]])
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if lockCam then
        runHaxeCode([[
            game.dad.offset.x *= 0.55;
            game.dad.offset.y *= 0.55;
        ]])
    end
end

function onTweenCompleted(tag)
    if tag == "blackFront" then
        lockCam = false;
        triggerEvent("Change Character", "dad", "bambi-new")
        triggerEvent("Change Character", "bf", "bambi-new")
        triggerEvent("Change Character", "bf", "bf")
        
        local itesm = {"black", "blackFront", "bambiSpot", "bfSpot", "highway", "highway2"}
        for i = 1, #itesm do
            removeLuaSprite(itesm[i], true)
        end
        doTweenAlpha("blackFront", "blackFront", 0, 0.5 / playbackRate, "")
    end
end