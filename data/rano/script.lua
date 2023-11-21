local backgroundSAprites = {};
local tweenTime = 0.0;
function onSongStart()
	tweenTime = sectionStartTime(56);
	backgroundSAprites = getDataFromSave("UntitledVsDavePortSettings", "backgroundSprites")
	for i = 1, #backgroundSAprites do
		if i == 1 then
			doTweenAlpha(backgroundSAprites[i].."StartTween", backgroundSAprites[i], 0, (tweenTime / 1000) / playbackRate, "")
		elseif i == 2 then
			doTweenAlpha(backgroundSAprites[i].."StartTween", backgroundSAprites[i], 1, (tweenTime / 1000) / playbackRate, "")
		elseif i == 3 then
			doTweenAlpha(backgroundSAprites[i].."StartTween", backgroundSAprites[i], 0, (tweenTime / 1000) / playbackRate, "")
		else
			doTweenColor(backgroundSAprites[i].."StartTween", backgroundSAprites[i], getDataFromSave("UntitledVsDavePortSettings", "nightColor"), (tweenTime / 1000) / playbackRate, "")
		end
	end
	doTweenColor("dadStartTween", "dad", getDataFromSave("UntitledVsDavePortSettings", "nightColor"), (tweenTime / 1000) / playbackRate, "")
	doTweenColor("gfStartTween", "gf", getDataFromSave("UntitledVsDavePortSettings", "nightColor"), (tweenTime / 1000) / playbackRate, "")
	doTweenColor("bfStartTween", "boyfriend", getDataFromSave("UntitledVsDavePortSettings", "nightColor"), (tweenTime / 1000) / playbackRate, "")
end

function onTweenCompleted(tag)
	for i = 1, #backgroundSAprites do
		if i == 2 and tag == backgroundSAprites[i].."StartTween"then
			doTweenAlpha(backgroundSAprites[i].."EndTween", backgroundSAprites[i], 0, (tweenTime / 1000) / playbackRate, "")
		elseif i == 3 and tag == backgroundSAprites[i].."StartTween" then
			doTweenAlpha(backgroundSAprites[i].."EndTween", backgroundSAprites[i], 1, (tweenTime / 1000) / playbackRate, "")
		elseif tag == backgroundSAprites[i].."StartTween" then
			doTweenColor(backgroundSAprites[i].."EndTween", backgroundSAprites[i], getDataFromSave("UntitledVsDavePortSettings", "sunsetColor"), (tweenTime / 1000) / playbackRate, "")
		end
	end
	if tag == "dadStartTween" then doTweenColor("dadEndTween", "dad", getDataFromSave("UntitledVsDavePortSettings", "sunsetColor"), (tweenTime / 1000) / playbackRate, "") end
	if tag == "gfStartTween" then doTweenColor("gfEndTween", "gf", getDataFromSave("UntitledVsDavePortSettings", "sunsetColor"), (tweenTime / 1000) / playbackRate, "") end
	if tag == "bfStartTween" then doTweenColor("bfEndTween", "boyfriend", getDataFromSave("UntitledVsDavePortSettings", "sunsetColor"), (tweenTime / 1000) / playbackRate, "") end
end

function onStepHit()
	if curStep == 512 then
		setProperty("defaultCamZoom", 0.9)
	end
	if curStep == 640 then
		setProperty("defaultCamZoom", 0.7)
	end
	if curStep == 1792 then
		setProperty("dad.skipDance", true)
		playAnim("dad", "sleepIdle", true)
		setProperty("dad.specialAnim", true)
		runHaxeCode([[
			game.dad.animation.finishCallback = function(anim)
			{
				game.dad.playAnim('sleeping', true);
				game.dad.specialAnim = true;
			}
		]])
	end
end

function sectionStartTime(section)
	local daBPM = bpm;
	local daPos = 0;
	for i = 0, section do
		daPos = daPos + (4 * (1000 * 60 / bpm));
	end
	return daPos;
end