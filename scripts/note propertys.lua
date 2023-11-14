--[[function onUpdate()
	for i = 0, getProperty('notes.length') do --why doesn't psych do this already??? (memory going crazy)
        for iStrum = 0, 3 do
            if getPropertyFromGroup('notes', i, 'mustPress') and not noteType(i, "phone") and not noteType(i, "phone-alt") and not noteType(i, "shape") then
                setPropertyFromGroup('notes', i, 'texture', getPropertyFromGroup('playerStrums', getPropertyFromGroup('notes', i, 'noteData'), 'texture'))
                if getPropertyFromGroup('opponentStrums', getPropertyFromGroup('notes', i, 'noteData'), 'texture') == "notes/NOTE_assets_3D" and (getPropertyFromGroup('notes', i, 'strumTime') / 50) % 20 > 10 then setPropertyFromGroup('notes', i, 'texture', 'notes/NOTE_assets_3D') end
			elseif not noteType(i, "phone") and not noteType(i, "phone-alt") and not noteType(i, "shape") then
                setPropertyFromGroup('notes', i, 'texture', getPropertyFromGroup('opponentStrums', getPropertyFromGroup('notes', i, 'noteData'), 'texture'))
                if getPropertyFromGroup('playerStrums', getPropertyFromGroup('notes', i, 'noteData'), 'texture') == "notes/NOTE_assets_3D" and (getPropertyFromGroup('notes', i, 'strumTime') / 50) % 20 > 10 then setPropertyFromGroup('notes', i, 'texture', 'notes/NOTE_assets_3D') end
            end
        end
    end
end--]]

function onStepHit()
	for i = 0, getProperty('notes.length') do --why doesn't psych do this already??? (heavy af memory usage im pretty sure)
        for iStrum = 0, 3 do
            if getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'scale.x', getPropertyFromGroup('playerStrums', getPropertyFromGroup('notes', i, 'noteData'), 'scale.x'))
				if getPropertyFromGroup('notes', i, 'isSustainNote') ~= true then
                	setPropertyFromGroup('notes', i, 'scale.y', getPropertyFromGroup('playerStrums', getPropertyFromGroup('notes', i, 'noteData'), 'scale.y'))
				end
            else
                setPropertyFromGroup('notes', i, 'scale.x', getPropertyFromGroup('opponentStrums', getPropertyFromGroup('notes', i, 'noteData'), 'scale.x'))
				if getPropertyFromGroup('notes', i, 'isSustainNote') ~= true then
                	setPropertyFromGroup('notes', i, 'scale.y', getPropertyFromGroup('opponentStrums', getPropertyFromGroup('notes', i, 'noteData'), 'scale.y'))
				end
            end
        end
    end
end


function noteType(i, noteType)
	if getPropertyFromGroup('notes', i, 'noteType') == noteType then return true; else return false; end
	return nil;
end