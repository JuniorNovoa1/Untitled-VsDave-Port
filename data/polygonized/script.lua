playDialogue = true;
playEndDialogue = true;

function onStartCountdown()
	if isStoryMode and not seenCutscene then
		if playDialogue then
			startDialogue('dialogue', "DaveDialogue");
			playDialogue = false;
			return Function_Stop;
		end
	end
	return Function_Continue;
end

local madeSprites = false;

function onEndSong()
	if isStoryMode then
		if playEndDialogue then
			if not madeSprites then
				madeSprites = true;
				local image = "";
				local imagePath = "dave/endings/"
				if string.lower(getDataFromSave("UntitledVsDavePortSettings", "lang")) ~= "en-us" then 
					imagePath = "locale/"..getDataFromSave("UntitledVsDavePortSettings", "lang").."/images/dave/endings/";
				end
				if getProperty("health") >= 0.1 then
					image = "goodEnding";
				elseif getProperty("health") < 0.1 then
					image = "vomit_ending";
				else
					image = "badEnding";
				end
				makeLuaSprite("languageEnding", imagePath..image, 0, 0)
				setObjectCamera("languageEnding", "other")
				screenCenter("languageEnding", 'xy')
				addLuaSprite("languageEnding", false)
			end
			
			return Function_Stop;
		end
	end
	return Function_Continue;
end

function onUpdate(elapsed)
	if keyboardJustPressed("ENTER") and madeSprites then
		playEndDialogue = false;
		runHaxeCode([[]])
		runHaxeCode([[game.endSong();]])
	end
end

function onCreate()
	addCharacterToList("dave", "dad")
	addCharacterToList("bf-3d", "bf")
	addCharacterToList("gf-3d", "gf")
	addLuaScript("stages/house", true)
	local backgroundSprtes = getDataFromSave("UntitledVsDavePortSettings", "backgroundSprites")
	setDataFromSave("UntitledVsDavePortSettings", "stageName", "davehouse_night")
	callOnLuas("setBackgroundColor", {false})
	for i = 1, #backgroundSprtes do
		setProperty(backgroundSprtes[i]..".alpha", 0)
	end
end

local pre3dSkin = "";

function onStepHit()
	if curStep == 128 or curStep == 640 or curStep == 704 or curStep == 1535 then
		setProperty("defaultCamZoom", 0.9)
	end
	if curStep == 256 or curStep == 768 or curStep == 1468 or curStep == 1596 or curStep == 2048 or curStep == 2144 or curStep == 2428 then
		setProperty("defaultCamZoom", 0.7)
	end
	if curStep == 688 or curStep == 752 or curStep == 1279 or curStep == 1663 or curStep == 2176 then
		setProperty("defaultCamZoom", 1)
	end
	if curStep == 1019 or curStep == 1471 or curStep == 1599 or curStep == 2064 then
		setProperty("defaultCamZoom", 0.8)
	end
	if curStep == 1920 then
		setProperty("defaultCamZoom", 1.1)
	end
	if curStep == 1024 or curStep == 1312 then
		setProperty("defaultCamZoom", 1.1)
		pre3dSkin = boyfriendName;
		triggerEvent("Change Character", "bf", "bf-3d")
		triggerEvent("Change Character", "gf", "gf-3d")
	end
	if curStep == 1152 or curStep == 1408 then
		setProperty("defaultCamZoom", 0.9)
		triggerEvent("Change Character", "bf", "bf")
		triggerEvent("Change Character", "gf", "gf")
	end
	if curBeat == 608 then
		setProperty("defaultCamZoom", 0.8)
		local backgroundSprtes = getDataFromSave("UntitledVsDavePortSettings", "backgroundSprites")
		triggerEvent("Change Character", "dad", "dave")

		cameraFlash("hud", "FFFFFF", 0.25)
		doTweenColor("dad", "dad", "0xFF878787", 0.6, "")
		doTweenColor("boyfriend", "boyfriend", "0xFF878787", 0.6, "")
		doTweenColor("gf", "gf", "0xFF878787", 0.6, "")

		setDataFromSave("UntitledVsDavePortSettings", "canFloat", false)
		doTweenX("boyfrioedEWS", "boyfriend", 843 + getProperty("boyfriend.positionArray[0]"), 1, "")
		doTweenY("boyfrioedWS", "boyfriend", 270 + getProperty("boyfriend.positionArray[1]"), 1, "")
		doTweenX("dadfEWS", "dad", 50 + getProperty("dad.positionArray[0]"), 1, "")
		doTweenY("dagredWS", "dad", 270 + getProperty("dad.positionArray[1]"), 1, "")
		doTweenX("gfehs", "gf", 300 + getProperty("gf.positionArray[0]"), 1, "")
		doTweenY("gfwdfg", "gf", -60 + getProperty("gf.positionArray[1]"), 1, "")

		setProperty("boyfriend.skipDance", true)
		setProperty("gf.skipDance", true)
		playAnim("boyfriend", "hey", true)
		playAnim("gf", "cheer", true)

		--doTweenX("", "", nil, 0.0, "")
		--startTween("boyfriend", "boyfriend", {"X": 42, "Y": 26}, 1, "")

		doTweenAlpha("redVoidBG", "redVoidBG", 0, 1, "")
		for i = 1, #backgroundSprtes do
			doTweenAlpha(backgroundSprtes[i], backgroundSprtes[i], 1, 1, "")
		end
	end
end