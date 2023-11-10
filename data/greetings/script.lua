function onCreate()
	addHaxeLibrary("FlxTween", 'flixel.tweens')
	addHaxeLibrary("FlxColor", "flixel.util")
	addHaxeLibrary("Conductor")
end

function onStepHit()
	if curStep == 492 then --kinda broken (100% broken)
		cameraFade("game", "FFFFFF", (stepCrochet / 1000) * 20)
		runTimer("camFade", (stepCrochet / 1000) * 20)
		runHaxeCode([[
			var curZoom = game.defaultCamZoom;
			var time = (Conductor.stepCrochet / 1000) * 20;
			FlxTween.num(curZoom, curZoom + 0.4, time, {onComplete: function(tween)
			{
				game.defaultCamZoom = 0.7;
			}}, function(newValue)
			{
				game.defaultCamZoom = newValue;
			});
		]])
	end
end

function onTimerCompleted(tag)
	if tag == "camFade" then
		cameraFade("game", "FFFFFF", 0, true)
		cameraFlash("game", "FFFFFF", 0.5)
	end
end