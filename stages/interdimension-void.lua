local char = {'ball', 'bimpe', 'maldo', 'memes kids', 'muko', 'ruby man', 'tristan', 'bambi'}
local direction = {}
local angleChangeAmount = {}
local posOffset = {}
local leftPosCheck = {}
local rightPosCheck = {}
local randomSpeed = {}
--flyingCharProps = {}

function onCreate()
	initLuaShader("glitchEffect")
	makeLuaSprite("void", "backgrounds/void/interdimensions/interdimensionVoid", -700, -350)
	setScrollFactor("void", 1, 1)
	setGraphicSize("void", math.ceil(getProperty("void.width") * 1.75))
	addLuaSprite("void")
	setSpriteShader("void", "glitchEffect")
	setShaderFloat('void', 'uWaveAmplitude', 0.1)
	setShaderFloat('void', 'uFrequency', 5)
	setShaderFloat('void', 'uSpeed', 2)
	for i = 1, #char do
		makeLuaSprite(char[i], "backgrounds/festival/scaredCrowd/"..char[i])
		setScrollFactor(char[i], 1, 1)
		addLuaSprite(char[i], false)
		local directionsRandom = {"left", "right"};
		direction[i] = directionsRandom[getRandomInt(1, 2)];
		angleChangeAmount[i] = getRandomInt(100, 200);
		posOffset[i] = 800;
		leftPosCheck[i] = (-getProperty(char[i]..".width") * (1 / getProperty("defaultCamZoom"))) - posOffset[i];
		rightPosCheck[i] = (screenWidth * (1 / getProperty("defaultCamZoom"))) + getProperty(char[i]..".width") + posOffset[i];
		randomSpeed[i] = getRandomInt(1, 6);
	end
end

local elapsedTime = 0.0;
function onUpdate(elapsed)
	elapsedTime = elapsedTime + elapsed;
	setShaderFloat('void', 'uTime', elapsedTime)
	local speed = 300;
	for i = 1, #char do
		local moveDir = -1;
		if direction[i] == "right" then moveDir = 1; end
		setProperty(char[i]..".x", getProperty(char[i]..".x") + (speed * elapsed * moveDir * randomSpeed[i]))
		setProperty(char[i]..".y", getProperty(char[i]..".y") + (math.sin(elapsedTime) * 5))
		setProperty(char[i]..".angle", getProperty(char[i]..".angle") + (angleChangeAmount[i] * elapsed))

		if direction[i] == "left" then
			if getProperty(char[i]..".x") < leftPosCheck[i] then
				switchDirection(i)
			end
		elseif direction[i] == "right" then
			if getProperty(char[i]..".x") > rightPosCheck[i] then
				switchDirection(i)
			end
		end
	end
end

function switchDirection(charID)
	setProperty(char[charID]..".y", (screenHeight / 2) - getProperty(char[charID]..".height") / 2)
	angleChangeAmount[charID] = getRandomInt(100, 200)
	if direction[charID] == "left" then direction[charID] = "right" else direction[charID] = "left" end
end