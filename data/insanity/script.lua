function ondadmirrorCreate()
	setProperty("dadmirror.x", getProperty("dad.x") -175)
	setProperty("dadmirror.y", getProperty("dad.y") -215)
	setProperty("dadmirror.visible", false)
end

function onStepHit()
	if curStep == 384 or curStep == 1040 then
		setProperty("defaultCamZoom", 0.9)
	end
	if curStep == 448 or curStep == 1056 then
		setProperty("defaultCamZoom", 0.8)
	end
	if curStep == 512 or curStep == 768 then
		setProperty("defaultCamZoom", 1)
	end
	if curStep == 640 then
		setProperty("defaultCamZoom", 1.1)
	end
	if curStep == 660 or curStep == 680 then
		playSound("static")
		setProperty("dad.visible", false)
		setProperty("dadmirror.visible", true)
		setProperty("blackBG.visible", true)
		setProperty("bg2.visible", true)
		runHaxeCode([[game.iconP2.changeIcon(game.getLuaObject("dadmirror", false).healthIcon);]])
	end
	if curStep == 664 or curStep == 684 then
		setProperty("dad.visible", true)
		setProperty("dadmirror.visible", false)
		setProperty("blackBG.visible", false)
		setProperty("bg2.visible", false)
		runHaxeCode([[game.iconP2.changeIcon(game.dad.healthIcon);]])
	end
	if curStep == 708 then
		setProperty("defaultCamZoom", 0.8)
		playAnim("dad", "um", true)
		setProperty("dad.specialAnim", true)
	end
	if curStep == 1176 then
		playSound("static")
		setProperty("dad.visible", false)
		setProperty("dadmirror.visible", true)
		setProperty("blackBG.visible", true)
		setProperty("bg2.visible", true)
		makeLuaSprite('bg2', 'backgrounds/void/redsky', -600, -200);
		setProperty("bg2.alpha", 0.7)
		addLuaSprite("bg2", false)
		setSpriteShader("bg2", "GlitchEffect")
		setShaderFloat('bg2', 'uWaveAmplitude', 0.1)
		setShaderFloat('bg2', 'uFrequency', 5)
		setShaderFloat('bg2', 'uSpeed', 2)
		runHaxeCode([[game.iconP2.changeIcon(game.getLuaObject("dadmirror", false).healthIcon);]])
	end
	if curStep == 1180 then
		setProperty("dad.visible", true)
		setProperty("dadmirror.visible", false)
		runHaxeCode([[game.iconP2.changeIcon(game.dad.curCharacter);]])
		playAnim("dad", "um", true)
		setProperty("dad.specialAnim", true)
	end
end