function onStepHit()
	if curStep == 128 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
		cameraFlash("hud", "FFFFFF", 0.5)
		makeLuaSprite("black", "", 0, 0)
		makeGraphic("black", screenWidth * 2, screenHeight * 2, '000000')
		setProperty("black.alpha", 0)
		screenCenter("black")
		addLuaSprite("black", true)
		doTweenAlpha("black", "black", 0.6, 1, "")
		callOnLuas("makeInvisibleNotes", {true})
		callOnLuas("createDialogue", {"blocked_sub1", 0.02, 1})
	end
	if curStep == 165 then
		callOnLuas("createDialogue", {"blocked_sub2", 0.02, 1})
	end
	if curStep == 188 then
		callOnLuas("createDialogue", {"blocked_sub3", 0.02, 1})
	end
	if curStep == 224 then
		callOnLuas("createDialogue", {"blocked_sub4", 0.02, 1})
	end
	if curStep == 248 then
		callOnLuas("createDialogue", {"blocked_sub5", 0.02, 0.5, 60})
	end
	if curStep == 256 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.1)
		cameraFlash("hud", "FFFFFF", 1)
		doTweenAlpha("black", "black", 0, 1, "")
		callOnLuas("makeInvisibleNotes", {false})
	end
	if curStep == 640 then
		cameraFlash("hud", "FFFFFF", 1)
		setProperty("black.alpha", 0.6)
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.1)
	end
	if curStep == 768 then
		cameraFlash("hud", "FFFFFF", 1)
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.1)
		setProperty("black.alpha", 0)
	end
	if curStep == 1028 then
		callOnLuas("makeInvisibleNotes", {true})
		callOnLuas("createDialogue", {"blocked_sub6", 0.02, 1.5})
	end
	if curStep == 1056 then
		callOnLuas("createDialogue", {"blocked_sub7", 0.02, 1})
	end
	if curStep == 1084 then
		callOnLuas("createDialogue", {"blocked_sub8", 0.02, 1})
	end
	if curStep == 1104 then
		callOnLuas("createDialogue", {"blocked_sub9", 0.02, 1})
	end
	if curStep == 1118 then
		callOnLuas("createDialogue", {"blocked_sub10", 0.02, 1})
	end
	if curStep == 1143 then
		callOnLuas("createDialogue", {"blocked_sub11", 0.02, 1, 45})
		callOnLuas("makeInvisibleNotes", {false})
	end
	if curStep == 1152 then
		doTweenAlpha("black", "black", 0.4, 1, "")
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.3)
	end
	if curStep == 1200 then
		doTweenAlpha("black", "black", 0.7, (stepCrochet / 1000) * 8, "")
	end
	if curStep == 1216 then
		cameraFlash("hud", "FFFFFF", 0.5)
		removeLuaSprite("black", true)
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.3)
	end
end