function onCreate()
	initLuaShader("glitchEffect")
	makeLuaSprite('glitchyVoidBG', 'backgrounds/void/scarybg', -500, -400)
	setGraphicSize("glitchyVoidBG", math.ceil(getProperty("glitchyVoidBG.width") * 3))
	setScrollFactor("glitchyVoidBG", 1, 1)
	addLuaSprite("glitchyVoidBG", false)
	setSpriteShader("glitchyVoidBG", "glitchEffect")
	setShaderFloat('glitchyVoidBG', 'uWaveAmplitude', 0.1)
	setShaderFloat('glitchyVoidBG', 'uFrequency', 5)
	setShaderFloat('glitchyVoidBG', 'uSpeed', 2)
	setDataFromSave("UntitledVsDavePortSettings", "stageName", "unfairness")
end

local elapsedTotal = 0.0;
function onUpdate(elapsed)
	elapsedTotal = elapsedTotal + elapsed;
	setShaderFloat('glitchyVoidBG', 'uTime', elapsedTotal)
end