local doneWithStrum = false;

function onCreatePost()
	addHaxeLibrary("ClientPrefs")
	addHaxeLibrary("StrumNote")
	addHaxeLibrary("FlxG", 'flixel')
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'guitar' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/NOTE_gh_middle'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.0475'); --Default value is: 0.0475, health lost on miss
			--setPropertyFromGroup('unspawnNotes', i, 'offset.x', '-25'); --offset
			setPropertyFromGroup('unspawnNotes', i, 'noteData', 2)
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			setPropertyFromGroup('unspawnNotes', i, 'mustPress', false)
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)

			if not doneWithStrum then
				doneWithStrum = true;
				runHaxeCode([[
					var babyArrow = new StrumNote(ClientPrefs.middleScroll ? game.STRUM_X_MIDDLESCROLL : game.STRUM_X, game.strumLine.y, 4, 0);
					babyArrow.downScroll = ClientPrefs.downScroll;
					babyArrow.alpha = 0;
					babyArrow.x += 310;
					game.opponentStrums.add(babyArrow);
					game.strumLineNotes.add(babyArrow);
					babyArrow.postAddedToGroup();
					babyArrow.set_texture("notes/NOTE_gh_middle");
				]])
			end
		end
	end
end

function onUpdatePost(elapsed)
	for i = 0, getProperty('notes.length')-1 do
		if getPropertyFromGroup("notes", i, "noteType") == "guitar" then
			setPropertyFromGroup("notes", i, "x", getPropertyFromGroup("opponentStrums", 4, "x"))
			setPropertyFromGroup("notes", i, "alpha", getPropertyFromGroup("opponentStrums", 4, "alpha"))
			local earlyHitMult = 0.01;
            if getPropertyFromGroup('notes', i, 'strumTime') > getPropertyFromClass('Conductor', 'songPosition') - (getPropertyFromClass('Conductor', 'safeZoneOffset') * getPropertyFromGroup('notes', i, 'lateHitMult')) and getPropertyFromGroup('notes', i, 'strumTime') < getPropertyFromClass('Conductor', 'songPosition') + (getPropertyFromClass('Conductor', 'safeZoneOffset') * earlyHitMult) then
				setPropertyFromGroup('notes', i, 'canBeHit', true);
			else
				setPropertyFromGroup('notes', i, 'canBeHit', false);
			end
            if getPropertyFromGroup('notes', i, 'canBeHit') then
				setPropertyFromGroup('notes', i, 'visible', false)
				setPropertyFromGroup('notes', i, 'alpha', 0)
                setProperty('vocals.volume', 1)
                strumAnim(0, 'confirm', 0.15);
				setProperty('dad.holdTimer', 0)
                runHaxeCode([[game.dad.playAnim("singMIDDLE", true);]])
				setProperty('dad.holdTimer', 0)
				callOnLuas("goodNoteHit", {i, getPropertyFromGroup("notes", i, "noteData"), getPropertyFromGroup("notes", i, "noteType"), getPropertyFromGroup("notes", i, "isSustainNote")})
                removeFromGroup('notes', i, false)
            end
		end
	end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
	if getPropertyFromGroup("opponentStrums", noteData, "texture") == "notes/NOTE_gh" then
		runHaxeCode([[
			var directionStrum = ]]..noteData..[[;
			var strum = game.strumLineNotes.members[directionStrum];
			strum.offset.x -= 12.5;
			strum.offset.y -= 15;
		]])
	end
end

function strumAnim(direction, fool, timer)
	runHaxeCode([[
		var directionStrum = ]]..direction..[[;
		var animAtion = ']]..fool..[[';
		var time = ']]..timer..[[';
		var strum = game.strumLineNotes.members[8 + directionStrum];
		strum.playAnim(animAtion, true);
		strum.resetAnim = time;
		strum.offset.x -= 12.5;
		strum.offset.y -= 15;
	]])
end