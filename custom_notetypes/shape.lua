function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'shape' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/NOTE_assets_Shape'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.0475'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'offset.x', '45'); --offset
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has no penalties
			end
			setDataFromSave("UntitledVsDavePortSettings", "hasShapeNotes", true)
		end
	end
	--debugPrint('Script started!')
end

local colArray = {'purple', 'blue', 'green', 'red'}

function onUpdatePost(elapsed)
	for i = 0, getProperty('notes.length')-1 do
		if getPropertyFromGroup('notes', i, 'mustPress') and not getProperty("cpuControlled") then
			setPropertyFromGroup('notes', i, 'blockHit', true)
			setPropertyFromGroup('notes', i, 'alpha', 0.5)
			if getPropertyFromGroup('notes', i, 'noteType') == 'shape' and getPropertyFromGroup('notes', i, 'isSustainNote') then 
				setPropertyFromGroup('notes', i, 'animation.curAnim.name', colArray[getPropertyFromGroup('notes', i, 'noteData') + 1])
			end
			if keyboardPressed("SHIFT") or keyboardPressed("SPACE") then
				if getPropertyFromGroup('notes', i, 'noteType') == 'shape' then setPropertyFromGroup('notes', i, 'blockHit', false) setPropertyFromGroup('notes', i, 'alpha', 1) end
			else
				if getPropertyFromGroup('notes', i, 'noteType') ~= 'shape' then setPropertyFromGroup('notes', i, 'blockHit', false) setPropertyFromGroup('notes', i, 'alpha', 1) end
			end
		end
	end
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false