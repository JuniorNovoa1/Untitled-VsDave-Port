function onStepHit()
	if curStep == 15 then
		playAnim("dad", "hey", true)
	end
	if curStep == 16 or curStep == 719 or curStep == 1167 then
		setProperty("defaultCamZoom", 1)
	end
	if curStep == 80 or curStep == 335 or curStep == 588 or curStep == 1103 then
		setProperty("defaultCamZoom", 0.8)
	end
	if curStep == 584 or curStep == 1039 then
		setProperty("defaultCamZoom", 1.2)
	end
	if curStep == 272 or curStep == 975 then
		setProperty("defaultCamZoom", 1.1)
	end
	if curStep == 464 then
		setProperty("defaultCamZoom", 1)
		doTweenX("dadLinearX", "dad", 25, 20 / playbackRate, "")
		doTweenY("dadLinearY", "dad", 50, 20 / playbackRate, "")
	end
	if curStep == 848 then
		--epliepsy off
		setProperty("defaultCamZoom", 1)
	end
	if curStep == 132 or curStep == 612 or curStep == 740 or curStep == 771 or curStep == 836 then
		--epliepsy on
		setProperty("defaultCamZoom", 1.2)
	end
	if curStep == 144 or curStep == 624 or curStep == 752 or curStep == 784 then
		--epliepsy off
		setProperty("defaultCamZoom", 0.8)
	end
	if curStep == 1231 then
		setProperty("defaultCamZoom", 0.8)
		doTweenX("dadLinearX", "dad", 50, 1 / playbackRate, "")
		doTweenY("dadLinearY", "dad", 280, 1 / playbackRate, "")
	end
end

local hasSeenCutscene = false;
local hasGeneratedSrs = false;

function onEndSong()
	if not hasSeenCutscene then
		if not hasGeneratedSrs then
			hasGeneratedSrs = true;
			makeAnimatedLuaSprite("marcello", 'joke/cutscene', getProperty("dad.x"), getProperty("dad.y"))
			addAnimationByPrefix("marcello", "throw_phone", "bambi0", 24, false)
			addAnimationByPrefix("marcello", "throw_phone2", "bambi0", 0, false)
			playAnim("marcello", "throw_phone2", false)
			addLuaSprite("marcello", true)
			setProperty("marcello.antialiasing", true)
			setProperty("marcello.flipX", true)
			setProperty("dad.visible", false)
			setProperty("boyfriend.stunned", true)
			setProperty("marcello.color", getProperty("dad.color"))
			playSound("break_phone", 1)
			playAnim("boyfriend", "hit", true)
			runTimer("THROWPHONEMARCELLO", 5.5 / playbackRate)
		end
		return Function_Stop;
	else
		return Function_Continue;
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "THROWPHONEMARCELLO" then playAnim("marcello", "throw_phone", true) runTimer("THROWPHONEMARCELLO2", 5.5 / playbackRate) end
	if tag == "THROWPHONEMARCELLO2" then hasSeenCutscene = true; runHaxeCode([[game.endSong();]]) end
end