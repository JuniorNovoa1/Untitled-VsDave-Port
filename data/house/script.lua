playVideo = true;
playDialogue = true;

function onStartCountdown() --token from psychengine wiki, don't really know how to use function shit
	if isStoryMode and not seenCutscene then
		if playVideo then --Video cutscene plays first
			startVideo('daveCutscene'); --Play video file from "videos/" folder
			playVideo = false;
			return Function_Stop; --Prevents the song from starting naturally
		elseif playDialogue then --Once the video ends it calls onStartCountdown again. Play dialogue this time
			startDialogue('dialogue', "DaveDialogue"); --"DaveDialogue" is the dialogue music file from "music/" folder
			playDialogue = false;
			return Function_Stop; --Prevents the song from starting naturally
		end
	end
	return Function_Continue; --Played video and dialogue, now the song can start normally
end