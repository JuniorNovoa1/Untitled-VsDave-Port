function onCreate()
	initLuaShader("glitchEffect")
	makeLuaSprite('greenVoidBG', 'backgrounds/void/cheater', -700, -350)
	setGraphicSize("greenVoidBG", math.ceil(getProperty("greenVoidBG.width") * 2))
	setScrollFactor("greenVoidBG", 1, 1)
	addLuaSprite("greenVoidBG", false)
	setSpriteShader("greenVoidBG", "glitchEffect")
	setShaderFloat('greenVoidBG', 'uWaveAmplitude', 0.1)
	setShaderFloat('greenVoidBG', 'uFrequency', 5)
	setShaderFloat('greenVoidBG', 'uSpeed', 2)
end

local elapsedTotal = 0.0;
function onUpdate(elapsed)
	elapsedTotal = elapsedTotal + elapsed;
	setShaderFloat('greenVoidBG', 'uTime', elapsedTotal)
end