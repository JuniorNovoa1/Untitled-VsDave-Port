local greetingsCutscene = true;
local hasViewed = false;
local daveFlying = true;
local flyingBgChars = {}

function onStartCountdown()
	if greetingsCutscene and not hasViewed then
		setProperty("canPause", false)
		setProperty("boyfriend.skipDance", true)
		setProperty("dad.skipDance", true)
		playAnim("dad", "scared", true)
		setProperty("gf.skipDance", true)

		playAnim("boyfriend", "scared", true)
		playAnim("gf", "scared", true)
		doTweenAlpha("camHUD", "camHUD", 0, 1 / playbackRate, "")
		
		playSound("rumble", 0.8, "rumble")
		runTimer("rumbling", 2 / playbackRate)
		return Function_Stop;
	elseif not greetingsCutscene or greetingsCutscene == nil then
		return Function_Continue;
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "rumbling" then
		runTimer("rumbling2", 3 / playbackRate)
	end
	if tag == "rumbling2" then
		playSound("transition", 1)
		cameraFade("game", "FFFFFF", 3 / playbackRate)
		runTimer("faderd", 3 / playbackRate)

		daveFlying = false;
		isGreetingsCutscene = false;
	end
	if tag == "faderd" then
		runHaxeCode([[game.camGame.stopFX();]])
		cameraFade("game", "000000", 0 / playbackRate)
		soundFadeOut("rumble", 1.9, 0)
		--startDialogue("") --to do then do it
		runTimer("startSong", 2 / playbackRate)
	end
	if tag == "startSong" then 
		runHaxeCode([[game.camGame.stopFX();]]); 
		hasViewed = true; 
		isGreetingsCutscene = false; 
		runHaxeCode([[game.startCountdown();]])
		setProperty("canPause", true)
		setProperty("boyfriend.skipDance", false)
		setProperty("dad.skipDance", false)
		setProperty("gf.skipDance", false)
		setProperty("camHUD.alpha", 1)

		--festival into interdimensional
		triggerEvent("Change Character", "dad", "dave-festival-3d")
		addLuaScript("characters/dave-festival-3d", false)
		callScript("characters/dave-festival-3d", "onCreatePost")
		addLuaScript("stages/interdimension-void", false)
		callScript("stages/interdimension-void", "onCreate")
		flyingBgChars = getDataFromSave("UntitledVsDavePortSettings", "flyingBgChars")
		setProperty("boyfriend.x", getProperty("boyfriend.x") + 250)
		setProperty("gf.x", getProperty("gf.x") + 250)
		local backgroundSprites = getDataFromSave("UntitledVsDavePortSettings", "backgroundSprites")
		for i = 1, #backgroundSprites do
			setProperty(backgroundSprites[i]..".alpha", 0)
		end
	end
end

function onUpdate(elapsed)
	if greetingsCutscene then cameraShake("game", 0.0175, 0.001) end
	if daveFlying then
		setProperty("dad.y", getProperty("dad.y") - (elapsed * 50))
		setProperty("dad.angle", getProperty("dad.angle") - (elapsed * 6))
	end
end

function onStepHit()
	if curStep == 378 then
		cameraFade("game", "FFFFFF", 0.3 / playbackRate)
	end
	if curStep == 384 then
		runHaxeCode([[game.camGame.stopFX();]])
		makeLuaSprite("black", "", 0, 0)
		makeGraphic("black", 2560, 1440, '000000')
		setProperty("black.alpha", 0.4)
		screenCenter("black")
		setScrollFactor("black", 0.0, 0.0)
		addLuaSprite("black", true)
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
		--cameraFade("game", "FFFFFF", 0.5)
		--runHaxeCode([[game.camGame.stopFX();]])
	end
	if curStep == 392 then
		runHaxeCode([[game.camGame.stopFX();]])
	end
	if curStep == 512 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.1)
	end
	if curStep == 639 then
		cameraFlash("game", "FFFFFF", 0.3 / playbackRate)
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.1)
		doTweenAlpha("black", "black", 0, 0.5 / playbackRate, "")
		callScript("stages/interdimension-void", "changeInterdimensionBg", {"spike-void"})
	end
	if curStep == 1152 then
		cameraFlash("game", "FFFFFF", 0.3 / playbackRate)
		callScript("stages/interdimension-void", "changeInterdimensionBg", {"darkSpace"})
	
		doTweenColor("dad", "dad", "0xFF0000FF", 1 / playbackRate)
		doTweenColor("gf", "gf", "0xFF0000FF", 1 / playbackRate)
		doTweenColor("boyfriend", "boyfriend", "0xFF0000FF", 1 / playbackRate)

		for i = 1, #flyingBgChars do
			doTweenColor(flyingBgChars[i], flyingBgChars[i], "0xFF0000FF", 1 / playbackRate)
		end
	end
	if curStep == 1408 then
		cameraFlash("game", "FFFFFF", 0.3 / playbackRate)
		callScript("stages/interdimension-void", "changeInterdimensionBg", {"hexagon-void"})

		doTweenColor("dad", "dad", "FFFFFF", 1 / playbackRate)
		doTweenColor("gf", "gf", "FFFFFF", 1 / playbackRate)
		doTweenColor("boyfriend", "boyfriend", "FFFFFF", 1 / playbackRate)

		for i = 1, #flyingBgChars do
			doTweenColor(flyingBgChars[i], flyingBgChars[i], "FFFFFF", 1 / playbackRate)
		end
	end
	if curStep == 1792 then
		cameraFlash("game", "FFFFFF", 0.3 / playbackRate)
		callScript("stages/interdimension-void", "changeInterdimensionBg", {"nimbi-void"})
	end
	if curStep == 2176 then
		cameraFlash("game", "FFFFFF", 0.3 / playbackRate)
		callScript("stages/interdimension-void", "changeInterdimensionBg", {"interdimension-void"})
	end
	if curStep == 2688 then
		setProperty("defaultCamZoom", 0.7)
		local backgroundSprites = getDataFromSave("UntitledVsDavePortSettings", "backgroundSprites")
		for i = 1, #backgroundSprites do
			doTweenAlpha(backgroundSprites[i], backgroundSprites[i], 1, 1 / playbackRate)
		end
		for i = 1, #flyingBgChars do
			doTweenAlpha(flyingBgChars[i], flyingBgChars[i], 0, 1 / playbackRate)
		end
		doTweenAlpha("void", "interdimensionBG", 0, 1 / playbackRate, "")
		setDataFromSave("UntitledVsDavePortSettings", "canFloat", false)
		cameraFlash("game", "FFFFFF", 0.25 / playbackRate)
		triggerEvent("Change Character", "dad", "dave-festival")
	
		local color = getBackgroundColor(curStage);
		doTweenColor("dad", "dad", color, 0.6 / playbackRate)
		if boyfriendName ~= "tristan-golden-glowing" then doTweenColor("boyfriend", "boyfriend", color, 0.6 / playbackRate) end
		doTweenColor("gf", "gf", color, 0.6 / playbackRate)

		doTweenX("boyfriendXPos", "boyfriend", getProperty("boyfriend.x") - 250, 0.6 / playbackRate, "")
		doTweenX("gfXPos", "gf", getProperty("gf.x") - 250, 0.6 / playbackRate, "")
	
		playAnim("boyfriend", "hey", true)
		playAnim("gf", "cheer", true)
		setProperty("boyfriend.skipDance", true)
		setProperty("gf.skipDance", true)
	end
end

function getBackgroundColor(stage)
	local stageColor = "FFFFFF";
	stage = string.lower(stage)
	if stage == "bambifarmnight" or stage == "davehouse_night" or stage == "backyard" or stage == "bedroomnight" then stageColor = "0xFF878787" end
	if stage == "bambifarmsunset" or stage == "davehouse_sunset" then stageColor = "FF8FB2" end
	return stageColor;
end