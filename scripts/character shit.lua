local CharactersWith3D = {"dave-angey", "bf-3d", "gf-3d"}
local funnyFloatyBoys = {'dave-angey', 'bambi-3d', 'expunged', 'bambi-unfair', 'exbungo', 'dave-festival-3d', 'dave-3d-recursed', 'bf-3d'}
local canFloat = true;

function onCreatePost()
    changeNoteSkinsOnChange()
end

local elapsedtime = 0.0;
function onUpdate(elapsed)
	elapsedtime = elapsedtime + elapsed;
	canFloat = getDataFromSave("UntitledVsDavePortSettings", "canFloat")

	if not canFloat then return; end
	if dadName == "dave-angey" then setProperty("dad.y", getProperty("dad.y") + ((math.sin(elapsedtime) * 0.2))) end
	if boyfriendName == "bf-3d" then setProperty("boyfriend.y", getProperty("boyfriend.y") + ((math.sin(elapsedtime) * 0.2))) end
	--[[for i = 1, #funnyFloatyBoys do
		if not canFloat then break; end
		if string.match(funnyFloatyBoys[i], dadName) then
			if dadName == "expunged" then
				--dad.x += (tox - dad.x) / 12;
				--dad.y += (toy - dad.y) / 12;
			else
				setProperty("dad.y", getProperty("dad.y") + ((math.sin(elapsedtime) * 0.2)))
			end
		end
		if string.match(funnyFloatyBoys[i], boyfriendName) then
			setProperty("boyfriend.y", getProperty("boyfriend.y") + ((math.sin(elapsedtime) * 0.2)))
		end
		if string.match(funnyFloatyBoys[i], gfName) then
			setProperty("gf.y", getProperty("gf.y") + ((math.sin(elapsedtime) * 0.2)))
		end
	end--]]
end

function changeNoteSkinsOnChange()
	local chars3D = {false, false}

	for i = 1, #CharactersWith3D do
		if string.lower(CharactersWith3D[i]) == string.lower(getProperty("boyfriend.curCharacter")) then
			setProperty("boyfriend.antialiasing", false)
			changeNoteSkin(true, 'NOTE_assets_3D')
			for i = 0, 3 do
				setPropertyFromGroup("playerStrums", i, "antialiasing", false)
			end
			chars3D[1] = true;
			break;
		else
			changeNoteSkin(true, 'NOTE_assets')
			for i = 0, 3 do
				setPropertyFromGroup("playerStrums", i, "antialiasing", true)
			end
		end
	end
	for i = 1, #CharactersWith3D do
		if string.lower(CharactersWith3D[i]) == string.lower(getProperty("dad.curCharacter")) then
			setProperty("dad.antialiasing", false)
			changeNoteSkin(false, 'NOTE_assets_3D')
			for i = 0, 3 do
				setPropertyFromGroup("opponentStrums", i, "antialiasing", false)
			end
			chars3D[2] = true;
			break;
		else
			changeNoteSkin(false, 'NOTE_assets')
			for i = 0, 3 do
				setPropertyFromGroup("opponentStrums", i, "antialiasing", true)
			end
		end
	end
end

function changeNoteSkin(player, skin)
	if player == true then
		for i = 0, 3, 1 do
			setPropertyFromGroup('playerStrums', i, 'texture', 'notes/'..skin)
		end
	end
    if not player then
		for i = 0, 3, 1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/'..skin)
		end
	end
end

local cached = false;

function onEventPushed(eventName, value1, value2, strumTime)
	if eventName == 'Change Character' and not cached then
		precacheImage("notes/NOTE_assets")
		precacheImage("notes/NOTE_assets_3D")
		cached = true;
	end
end

function onEvent(eventName, value1, value2, strumTime)
	if eventName == 'Change Character' then
		changeNoteSkinsOnChange()
	end
end