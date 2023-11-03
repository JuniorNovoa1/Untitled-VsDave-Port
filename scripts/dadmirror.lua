local dadMirrorSongs = {
	["insanity"] = 'dave-angey'
}

function onCreatePost()
	if dadMirrorSongs[string.lower(songName)] ~= nil then
		runHaxeCode([[
			var dadmirror = new Character(0, 0, ']]..dadMirrorSongs[string.lower(songName)]..[[');
			game.add(dadmirror);
			game.modchartSprites.set('dadmirror', dadmirror);
		]])
		runHaxeCode([[game.startCharacterLua(']]..dadMirrorSongs[string.lower(songName)]..[[');]])
		callOnLuas("ondadmirrorCreate")
	end
end

function dadmirrorPlayAnim(anim)
	runHaxeCode([[game.getLuaObject("dadmirror", false).playAnim("]]..anim..[[", true);]])
end

function onEvent(eventName, value1, value2, strumTime)
	if eventName == 'Change Character' then
		changeNoteSkinsOnChange()
		if string.lower(value1) == 'dadmirror' then
			runHaxeCode([[
				game.getLuaObject('dadmirror', false).destroy();
				var dadmirror = new Character(0, 0, ']]..value2..[[');
				game.add(dadmirror);
				game.startCharacterLua(']]..value2..[[');
				game.modchartSprites.set('dadmirror', dadmirror);
			]])
		end
	end
end

local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

function onBeatHit()
	if curBeat % 2 == 0 then
		if dadMirrorSongs[string.lower(songName)] ~= nil or luaSpriteExists("dadmirror") then
			if getProperty("dadmirror.animation.curAnim.name") == 'idle' and not getProperty("dadmirror.skipDance") then dadmirrorPlayAnim('idle') end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	removeFromGroup('grpNoteSplashes', getProperty('grpNoteSplashes.length') -1, false); --insta killed
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
	setProperty("dadmirror.holdTimer", 0)
	dadmirrorPlayAnim(singAnims[noteData + 1])
end
