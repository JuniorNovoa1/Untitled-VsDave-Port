local camMovementType = '';
local bfCamIdle = {};
local dadCamIdle = {};

local offsets = 30;
local posBFX = {}
local posBFY = {}

local yoffset = 0;

local curNoteData = 0;
local camMovement = true;

function onUpdate() --camera now follows characters!!!!
	bfCamIdle[1] = getMidpointX('boyfriend') - 100 - getProperty('boyfriend.cameraPosition[0]') - getProperty('boyfriendCameraOffset[0]')
	bfCamIdle[2] = getMidpointY('boyfriend') - 100 + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]')
	dadCamIdle[1] = getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]')
	dadCamIdle[2] = getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]')

	if boyfriendName == "dave-angey" or boyfriendName == "dave-festival-3d" then
		bfCamIdle[2] = getMidpointY('boyfriend')
	end
	if dadName == "dave-angey" or dadName == "dave-festival-3d" then
		dadCamIdle[2] = getMidpointY('dad')
	end

	if mustHitSection == true and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		callCamMovemt(bfCamIdle[1] -(yoffset * 2.5), bfCamIdle[2] -yoffset);
	elseif mustHitSection == true then
		if camMovementType == 'charSize' then
			offsets = 30 + (0.000025 * getProperty('boyfriend.width') * getProperty('boyfriend.height'));
		elseif camMovementType == 'camZoom' then
			offsets = 30 / getProperty('defaultCamZoom');
		end
		if curNoteData == 0 then
			callCamMovemt(bfCamIdle[1] -offsets -(yoffset * 2.5), bfCamIdle[2] -yoffset);
		end
		if curNoteData == 1 then
			callCamMovemt(bfCamIdle[1] -(yoffset * 2.5), bfCamIdle[2] +offsets -yoffset);
		end
		if curNoteData == 2 then
			callCamMovemt(bfCamIdle[1] -(yoffset * 2.5), bfCamIdle[2] -offsets -yoffset);
		end
		if curNoteData == 3 then
			callCamMovemt(bfCamIdle[1] +offsets -(yoffset * 2.5), bfCamIdle[2] -yoffset);
		end
	end
	if mustHitSection == false and getProperty('dad.animation.curAnim.name') == 'idle' then
		callCamMovemt(dadCamIdle[1] -yoffset, dadCamIdle[2] -yoffset);
	elseif mustHitSection == false then
		if camMovementType == 'charSize' then
			offsets = 30 + (0.000025 * getProperty('dad.width') * getProperty('dad.height'));
		elseif camMovementType == 'camZoom' then
			offsets = 30 / (getProperty('defaultCamZoom') * 0.8);
		end
		if curNoteData == 0 then
			callCamMovemt(dadCamIdle[1] -offsets -yoffset, dadCamIdle[2] -yoffset);
		end
		if curNoteData == 1 then
			callCamMovemt(dadCamIdle[1] -yoffset, dadCamIdle[2] +offsets -yoffset);
		end
		if curNoteData == 2 then
			callCamMovemt(dadCamIdle[1] -yoffset, dadCamIdle[2] -offsets -yoffset);
		end
		if curNoteData == 3 then
			callCamMovemt(dadCamIdle[1] +offsets -yoffset, dadCamIdle[2] -yoffset);
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if mustHitSection then curNoteData = direction; end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if not mustHitSection then curNoteData = direction; end
end

function callCamMovemt(x, y)
	if not camMovement then return; end
	triggerEvent("Camera Follow Pos", ""..x, ""..y)
end