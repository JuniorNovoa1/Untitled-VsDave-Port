local spotLightPart = false;
local secondAngle = false;

function onCreatePost()
	makeLuaSprite('spotLight', 'spotLight', 0, 0)
    --setGraphicSize('spotLight', getProperty('spotLight.width') * (getProperty('spotLight.frameWidth') / getProperty('spotLight.width') * spotLightScaler))
    setProperty('spotLight.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
    updateHitbox('spotLight')
    setProperty('spotLight.scale.x', 0.7)
    setProperty('spotLight.scale.y', 0.7)
    setProperty('spotLight.alpha', 0)
    addLuaSprite('spotLight', true)
    setBlendMode('spotLight', 'add')

    if string.lower(songName) == 'maze' then
        setProperty('health', getProperty('health') - 0.2)
    end
end

function onBeatHit()
	updateSpotlight(mustHitSection)
	if curBeat % 3 == 0 then
		cancelTween("angleSpotlight")
		if secondAngle then
			doTweenAngle('angleSpotlight', 'spotLight', 2, (crochet / 1000) * 3, 'expoInOut')
			secondAngle = false;
		else
			doTweenAngle('angleSpotlight', 'spotLight', -2, (crochet / 1000) * 3, 'expoInOut')
			secondAngle = true;
		end
	end
end

function onStepHit()
	if curStep == 466 then
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.2)
		cameraFlash('camother', 'FFFFFF', 1)
		makeLuaSprite("black", "", 0, 0)
		makeGraphic("black", screenWidth * 2, screenHeight * 2, '000000')
		setProperty("black.alpha", 0)
		screenCenter("black")
		addLuaSprite("black", true)
		doTweenAlpha("black", "black", 0.6, 1, "")
		doTweenAlpha('black', 'black', 0.6, 1, 'quadInOut')
		callOnLuas("createDialogue", {"maze_sub1", 0.02, 1})
		callOnLuas("makeInvisibleNotes", {true})
	end

	if curStep == 476 then
		callOnLuas("createDialogue", {"maze_sub2", 0.02, 0.7})
	end
	if curStep == 484 then
		callOnLuas("createDialogue", {"maze_sub3", 0.02, 1})
	end
	if curStep == 498 then
		callOnLuas("createDialogue", {"maze_sub4", 0.02, 1})
	end
	if curStep == 510 then
		callOnLuas("createDialogue", {"maze_sub5", 0.02, 1, 60})
		callOnLuas("makeInvisibleNotes", {false})
	end

	if curStep == 528 then
		setProperty('defaultCamZoom', 0.8)
		cameraFlash('camother', 'FFFFFF', 1)
		setProperty('black.alpha', 0)
	end

	if curStep == 832 then
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.2)
		doTweenAlpha('black', 'black', 0.4, 1, 'quadInOut')
	end

	if curStep == 838 then
		callOnLuas("createDialogue", {"maze_sub6", 0.02, 1})
		callOnLuas("makeInvisibleNotes", {true})
	end
	if curStep == 847 then
		callOnLuas("createDialogue", {"maze_sub7", 0.02, 0.5})
	end
	if curStep == 856 then
		callOnLuas("createDialogue", {"maze_sub8", 0.02, 1})
	end
	if curStep == 867 then
		callOnLuas("createDialogue", {"maze_sub9", 0.02, 1, 40})
	end
	if curStep == 879 then
		callOnLuas("createDialogue", {"maze_sub10", 0.02, 1})
	end
	if curStep == 890 then
		callOnLuas("createDialogue", {"maze_sub11", 0.02, 1})
	end
	if curStep == 902 then
		callOnLuas("createDialogue", {"maze_sub12", 0.02, 1, 60})
		callOnLuas("makeInvisibleNotes", {false})
	end

	if curStep == 908 then
		local speed = getPropertyFromClass('Conductor.stepCrochet') / 1000 * 4;
		doTweenAlpha('black', 'black', 1, speed, 'quadInOut')
	end

	if curStep == 912 and not spotLightPart then
		--spotlight
		spotLightPart = true;
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.1)
		if flashingLights then cameraFlash('camother', 'FFFFFF', 1) end
		updateSpotlight(false)

		doTweenAlpha('black', 'black', 0.6, 1, 'quadInOut')
		doTweenAlpha('fadeINNSPOT', 'spotLight', 0.7, 1, 'quadInOut')
	end

	if curStep == 1168 then
		spotLightPart = false;
		doTweenAlpha('fadeINN', 'black', 0, 1, 'quadInOut')
		doTweenAlpha('fadeOUTTSPOT', 'spotLight', 0, 1, 'quadInOut')
	end

	if curStep == 1232 and flashingLights then
		cameraFlash('camother', 'FFFFFF', 1)
	end
end

function updateSpotlight(bfSinging)
	if bfSinging then
		doTweenX('moveSpotLightX', 'spotLight', getGraphicMidpointX('boyfriend') -getCharacterX('boyfriend') * 0.4, 0.66, 'circOut')
		doTweenY('moveSpotLightY', 'spotLight', getGraphicMidpointY('boyfriend') -getGraphicMidpointY('boyfriend') -175, 0.66, 'circOut')
	end

	if not bfSinging then
		doTweenX('moveSpotLightX', 'spotLight', getGraphicMidpointX('dad') -getCharacterX('dad') * 1.225, 0.66, 'circOut')
		doTweenY('moveSpotLightY', 'spotLight', getGraphicMidpointY('dad') -getGraphicMidpointY('dad') -125, 0.66, 'circOut')
	end
end