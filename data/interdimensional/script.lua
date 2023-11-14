local greetingsCutscene = true;
local hasViewed = false;
local daveFlying = true;

function onStartCountdown()
	if greetingsCutscene and not hasViewed then
		setProperty("canPause", false)
		setProperty("boyfriend.skipDance", true)
		setProperty("dad.skipDance", true)
		playAnim("dad", "scared", true)
		setProperty("gf.skipDance", true)

		playAnim("boyfriend", "scared", true)
		playAnim("gf", "scared", true)
		doTweenAlpha("camHUD", "camHUD", 0, 1, "")
		
		playSound("rumble", 0.8, "rumble")
		runTimer("rumbling", 2)
		return Function_Stop;
	elseif not greetingsCutscene or greetingsCutscene == nil then
		return Function_Continue;
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "rumbling" then
		runTimer("rumbling2", 3)
	end
	if tag == "rumbling2" then
		playSound("transition", 1)
		cameraFade("game", "FFFFFF", 3)
		runTimer("faderd", 3)

		daveFlying = false;
		isGreetingsCutscene = false;
	end
	if tag == "faderd" then
		runHaxeCode([[game.camGame.stopFX();]])
		cameraFade("game", "000000", 0)
		soundFadeOut("rumble", 1.9, 0)
		--startDialogue("") --to do: do it
		runTimer("startSong", 2)
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
		setProperty("boyfriend.x", getProperty("boyfriend.x") + 250)
		setProperty("gf.x", getProperty("gf.x") + 250)
		local backgroundSprites = getDataFromSave("UntitledVsDavePortSettings", "backgroundSprites")
		for i = 1, #backgroundSprites do
			setProeprty(backgroundSprites[i]..".alpha", 0)
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