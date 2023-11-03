function onCreate()
	initLuaShader("glitchEffect")
	makeLuaSprite('redVoidBG', 'backgrounds/void/redsky', -600, -200)
	setScrollFactor("redVoidBG", 1, 1)
	setProperty("redVoidBG.alpha", 0.7)
	addLuaSprite("redVoidBG", false)
	setSpriteShader("redVoidBG", "glitchEffect")
	setShaderFloat('redVoidBG', 'uWaveAmplitude', 0.1)
	setShaderFloat('redVoidBG', 'uFrequency', 5)
	setShaderFloat('redVoidBG', 'uSpeed', 2)
end

local elapsedTotal = 0.0;
function onUpdate(elapsed)
	elapsedTotal = elapsedTotal + elapsed;
	setShaderFloat('redVoidBG', 'uTime', elapsedTotal)
end