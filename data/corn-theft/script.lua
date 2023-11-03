function onCreate()
	addHaxeLibrary("FlxTween", 'flixel.tweens')
end

function onStepHit()
	if curStep == 668 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
	end
	if curStep == 784 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
	end
	if curStep == 848 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
	end
	if curStep == 916 then
		cameraFlash("hud", "FFFFFF", 1)
	end
	if curStep == 935 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
		makeLuaSprite("black", "", 0, 0)
		makeGraphic("black", screenWidth * 2, screenHeight * 2, '000000')
		setProperty("black.alpha", 0)
		screenCenter("black")
		addLuaSprite("black", true)
		doTweenAlpha("black", "black", 0.6, 1, "")
		callOnLuas("makeInvisibleNotes", {true})
		callOnLuas("createDialogue", {"ctheft_sub1", 0.02, 1})
	end
	if curStep == 945 then
		callOnLuas("createDialogue", {"ctheft_sub2", 0.02, 1})
	end
	if curStep == 976 then
		callOnLuas("createDialogue", {"ctheft_sub3", 0.02, 0.5})
	end
	if curStep == 982 then
		callOnLuas("createDialogue", {"ctheft_sub4", 0.02, 1})
	end
	if curStep == 992 then
		callOnLuas("createDialogue", {"ctheft_sub5", 0.02, 1})
	end
	if curStep == 1002 then
		callOnLuas("createDialogue", {"ctheft_sub6", 0.02, 0.3})
	end
	if curStep == 1007 then
		callOnLuas("createDialogue", {"ctheft_sub7", 0.02, 0.3})
	end
	if curStep == 1033 then
		callOnLuas("createDialogue", {"Bye Baa!", 0.02, 0.3, 45, false})
		doTweenAlpha("dad", "dad", 0, (crochet / 1000) * 6, "")
		doTweenAlpha("black", "black", 0, (crochet / 1000) * 6, "")
		runHaxeCode([[
			FlxTween.num(game.defaultCamZoom, game.defaultCamZoom + 0.2, (Conductor.stepCrochet / 1000) * 6, {}, function(newValue)
			{
				game.defaultCamZoom = newValue;
			});
		]])
		callOnLuas("makeInvisibleNotes", {false})
	end
	if curStep == 1040 then
		setProperty("defaultCamZoom", 0.8)
		cancelTween("dad")
		setProperty("dad.alpha", 1)
		removeLuaSprite("black", true)
		cameraFlash("hud", "FFFFFF", 1)
	end
end