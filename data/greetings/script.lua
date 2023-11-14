function onCreate()
	addHaxeLibrary("FlxTween", 'flixel.tweens')
	addHaxeLibrary("FlxColor", "flixel.util")
	addHaxeLibrary("Conductor")
end

function onStepHit()
	if curStep == 492 then --kinda broken (100% broken)
		cameraFade("game", "FFFFFF", (stepCrochet / 1000) * 20)
		runTimer("camFade", (stepCrochet / 1000) * 20 + 0.1)
		runHaxeCode([[
			var time = (Conductor.stepCrochet / 1000) * 20;
			FlxTween.num(game.defaultCamZoom, game.defaultCamZoom + 0.4, time, {}, function(newValue)
			{
				game.defaultCamZoom = newValue;
			});
		]])
	end
end

function onTimerCompleted(tag)
	if tag == "camFade" then
		runHaxeCode([[game.camGame.stopFX();]])
		--cameraFade("game", "FFFFFF", 0, true)
		cameraFlash("game", "FFFFFF", 0.5)
		setProperty("defaultCamZoom", 0.7)
	end
end