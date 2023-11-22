function onStepHit()
    if curStep == 128 then
		setProperty("defaultCamZoom", 0.7)
	end
    if curStep == 252 or curStep == 512 then --eyesores off
		setProperty("defaultCamZoom", 0.4)
	end
    if curStep == 256 then
		setProperty("defaultCamZoom", 0.8)
	end
    if curStep == 380 then
		setProperty("defaultCamZoom", 0.5)
	end
    if curStep == 384 then --eyesores
		setProperty("defaultCamZoom", 1)
	end
    if curStep == 508 then
		setProperty("defaultCamZoom", 1.2)
	end
    if curStep == 560 then
		setProperty("dad.skipDance", true)
		playAnim("dad", "die", true)
        playSound("dead", 1)
	end
end