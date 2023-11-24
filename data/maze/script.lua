local spotLightPart = false;
local secondAngle = false;
playVideo = true;
playDialogue = true;

function onStartCountdown()
	if isStoryMode and not seenCutscene then
		if playVideo then
			startVideo('mazeCutscene');
			playVideo = false;
			return Function_Stop;
		elseif playDialogue then
			startDialogue('dialogue', "DaveDialogue");
			playDialogue = false;
			return Function_Stop;
		end
	end
	return Function_Continue;
end

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

    setProperty('health', getProperty('health') - 0.2)
end

local backgroundSAprites = {};
local tweenTime = 0.0;
function onSongStart()
	tweenTime = sectionStartTime(25);
	backgroundSAprites = getDataFromSave("UntitledVsDavePortSettings", "backgroundSprites")
	for i = 1, #backgroundSAprites do
		if i == 1 then
			doTweenAlpha(backgroundSAprites[i].."StartTween", backgroundSAprites[i], 0, (tweenTime / 1000) / playbackRate, "")
		elseif i == 2 then
			doTweenAlpha(backgroundSAprites[i].."StartTween", backgroundSAprites[i], 1, (tweenTime / 1000) / playbackRate, "")
		elseif i == 3 then
			doTweenAlpha(backgroundSAprites[i].."StartTween", backgroundSAprites[i], 0, (tweenTime / 1000) / playbackRate, "")
		else
			doTweenColor(backgroundSAprites[i].."StartTween", backgroundSAprites[i], getDataFromSave("UntitledVsDavePortSettings", "sunsetColor"), (tweenTime / 1000) / playbackRate, "")
		end
	end
	doTweenColor("dadStartTween", "dad", getDataFromSave("UntitledVsDavePortSettings", "sunsetColor"), (tweenTime / 1000) / playbackRate, "")
	doTweenColor("gfStartTween", "gf", getDataFromSave("UntitledVsDavePortSettings", "sunsetColor"), (tweenTime / 1000) / playbackRate, "")
	doTweenColor("bfStartTween", "boyfriend", getDataFromSave("UntitledVsDavePortSettings", "sunsetColor"), (tweenTime / 1000) / playbackRate, "")
end

function onTweenCompleted(tag)
	for i = 1, #backgroundSAprites do
		if i == 2 and tag == backgroundSAprites[i].."StartTween"then
			doTweenAlpha(backgroundSAprites[i].."EndTween", backgroundSAprites[i], 0, (tweenTime / 1000) / playbackRate, "")
		elseif i == 3 and tag == backgroundSAprites[i].."StartTween" then
			doTweenAlpha(backgroundSAprites[i].."EndTween", backgroundSAprites[i], 1, (tweenTime / 1000) / playbackRate, "")
		elseif tag == backgroundSAprites[i].."StartTween" then
			doTweenColor(backgroundSAprites[i].."EndTween", backgroundSAprites[i], getDataFromSave("UntitledVsDavePortSettings", "nightColor"), (tweenTime / 1000) / playbackRate, "")
		end
	end
	if tag == "dadStartTween" then doTweenColor("dadEndTween", "dad", getDataFromSave("UntitledVsDavePortSettings", "nightColor"), (tweenTime / 1000) / playbackRate, "") end
	if tag == "gfStartTween" then doTweenColor("gfEndTween", "gf", getDataFromSave("UntitledVsDavePortSettings", "nightColor"), (tweenTime / 1000) / playbackRate, "") end
	if tag == "bfStartTween" then doTweenColor("bfEndTween", "boyfriend", getDataFromSave("UntitledVsDavePortSettings", "nightColor"), (tweenTime / 1000) / playbackRate, "") end
end
function sectionStartTime(section)
	local daBPM = bpm;
	local daPos = 0;
	for i = 0, section do
		daPos = daPos + (4 * (1000 * 60 / bpm));
	end
	return daPos;
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
		cameraFlash('camother', 'FFFFFF', 1 / playbackRate)
		makeLuaSprite("black", "", 0, 0)
		makeGraphic("black", screenWidth * 2, screenHeight * 2, '000000')
		setProperty("black.alpha", 0)
		screenCenter("black")
		addLuaSprite("black", true)
		doTweenAlpha('black', 'black', 0.6, 1 / playbackRate, 'quadInOut')
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
		cameraFlash('camother', 'FFFFFF', 1 / playbackRate)
		setProperty('black.alpha', 0)
	end

	if curStep == 832 then
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.2)
		doTweenAlpha('black', 'black', 0.4, 1 / playbackRate, 'quadInOut')
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
		doTweenAlpha('black', 'black', 1, speed / playbackRate, 'quadInOut')
	end

	if curStep == 912 and not spotLightPart then
		--spotlight
		spotLightPart = true;
		setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.1)
		if flashingLights then cameraFlash('camother', 'FFFFFF', 1 / playbackRate) end
		updateSpotlight(false)

		doTweenAlpha('black', 'black', 0.6, 1 / playbackRate, 'quadInOut')
		doTweenAlpha('fadeINNSPOT', 'spotLight', 0.7, 1 / playbackRate, 'quadInOut')
	end

	if curStep == 1168 then
		spotLightPart = false;
		doTweenAlpha('fadeINN', 'black', 0, 1 / playbackRate, 'quadInOut')
		doTweenAlpha('fadeOUTTSPOT', 'spotLight', 0, 1 / playbackRate, 'quadInOut')
	end

	if curStep == 1232 and flashingLights then
		cameraFlash('camother', 'FFFFFF', 1 / playbackRate)
	end
end

function updateSpotlight(bfSinging)
	if bfSinging then
		doTweenX('moveSpotLightX', 'spotLight', getGraphicMidpointX('boyfriend') -getCharacterX('boyfriend') * 0.4, 0.66 / playbackRate, 'circOut')
		doTweenY('moveSpotLightY', 'spotLight', getGraphicMidpointY('boyfriend') -getGraphicMidpointY('boyfriend') -175, 0.66 / playbackRate, 'circOut')
	end
	if not bfSinging then
		doTweenX('moveSpotLightX', 'spotLight', getGraphicMidpointX('dad') -getCharacterX('dad') * 1.225, 0.66 / playbackRate, 'circOut')
		doTweenY('moveSpotLightY', 'spotLight', getGraphicMidpointY('dad') -getGraphicMidpointY('dad') -125, 0.66 / playbackRate, 'circOut')
	end
end