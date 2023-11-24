isEnabled = false
function onCreatePost()
	 initLuaShader("PulseShader")

	 makeLuaSprite("PulseShaderSpr")
	 makeGraphic("PulseShaderSpr", screenWidth, screenHeight)

	 setSpriteShader("PulseShaderSpr", "PulseShader")
    setShaderFloat("PulseShaderSpr", "uSpeed", 1)
    setShaderFloat("PulseShaderSpr", "uFrequency", 2)
    setShaderFloat("PulseShaderSpr", "uWaveAmplitude", 1)

	 addHaxeLibrary("ShaderFilter", "openfl.filters")
	 runHaxeCode([[
	 	 game.camGame.setFilters([new ShaderFilter(game.getLuaObject("PulseShaderSpr").shader)]);
	 ]])
end
function enableEyeSores(thing)
   setShaderBool("PulseShaderSpr", "uEnabled", thing)
end
function onEvent(n)
   if n == 'eyesores' then
      isEnabled = not isEnabled
      if getDataFromSave("UntitledVsDavePortSettings", "eyesores") and shadersEnabled then enableEyeSores(isEnabled) end
   end
end
function onUpdate()
    songPos = getSongPosition()
    currentBeat = (songPos/5000)*(curBpm/60)
	 setShaderFloat("PulseShaderSpr", "uTime", currentBeat)

   if getDataFromSave('UntitledVsDavePortSettings', 'screenShake', true) and isEnabled then runHaxeCode([[FlxG.camera.shake(0.010, 0.010);]]) end
   if getShaderBool("PulseShaderSpr", "uEnabled") then
      setShaderFloat("PulseShaderSpr", "uampmul", 0.5)
      playAnim('gf', 'scared', false)
   else
      setShaderFloat("PulseShaderSpr", "uampmul", getShaderFloat("PulseShaderSpr", "uampmul") - 0.01)
   end
end
