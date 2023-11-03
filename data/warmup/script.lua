function onCreate() 
	addHaxeLibrary("FlxTween", 'flixel.tweens')
	addHaxeLibrary("FlxEase", 'flixel.tweens')
end

function onUpdate(elapsed) setProperty("camZooming", false) end

function onBeatHit()
	if not mustHitSection then doTweenZoom("zoom", "camGame", 1.3, (getPropertyFromClass("Conductor", stepCrochet) * 4 / 1000), "sineInOut") end
	if mustHitSection then doTweenZoom("zoom", "camGame", 1, (getPropertyFromClass("Conductor", stepCrochet) * 4 / 1000), "sineInOut") end
end