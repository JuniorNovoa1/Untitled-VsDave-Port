local hasTriggeredDumbshit = true;

function onCreate()
	addHaxeLibrary("FlxTimer", 'flixel.util')
	addHaxeLibrary("FlxEase", 'flixel.tweens')
	addHaxeLibrary("FlxTween", 'flixel.tweens')
	addHaxeLibrary("HealthIcon")
end

local splitCharExpress = "";

function onStepHit()
	if curStep == 4750 then
		setProperty("dad.skipDance", true)
		playAnim("dad", "scared", true)
		cameraShake("hud", 0.015, (stepCrochet / 1000) * 50)
	end
	if curStep == 4800 then
		cameraFlash("game", "FFFFFF", 1)
		splitathonExpression('dave', 'what');
		addSplitathonChar("bambi-splitathon");
		if not hasTriggeredDumbshit then throwThatBitchInThere('bambi-splitathon', 'dave-splitathon'); end
	end
	if curStep == 5824 then
		cameraFlash("game", "FFFFFF", 1)
		splitathonExpression('bambi', 'umWhatIsHappening');
		addSplitathonChar("dave-splitathon");
	end
	if curStep == 6080 then
		cameraFlash("game", "FFFFFF", 1)
		splitathonExpression('dave', 'happy'); 
		addSplitathonChar("bambi-splitathon");
	end
	if curStep == 8384 then
		cameraFlash("game", "FFFFFF", 1)
		splitathonExpression('bambi', 'yummyCornLol');
		addSplitathonChar("dave-splitathon");
	end
	if curStep == 4799 or curStep == 5823 or curStep == 6079 or curStep == 8383 then
		hasTriggeredDumbshit = false;
	end

	if curBeat % 4 == 0 then
		runHaxeCode([[game.getLuaObject("splitathonCharacterExpression", false).playAnim("]]..splitCharExpress..[[", false);]])
	end
end

function getBackgroundColor(stage)
	local stageColor = "FFFFFF";
	stage = string.lower(stage)
	if stage == "bambifarmnight" or stage == "davehouse_night" or stage == "backyard" or stage == "bedroomnight" then stageColor = "0xFF878787" end
	if stage == "bambifarmsunset" or stage == "davehouse_sunset" then stageColor = "FF8FB2" end
	return stageColor;
end
function splitathonExpression(character, expression)
	runHaxeCode([[
		game.boyfriend.stunned = true;
		if(game.getLuaObject("splitathonCharacterExpression", false) != null)
		{
			game.getLuaObject("splitathonCharacterExpression", false).visible = false;
			//game.dadGroup.remove(game.getLuaObject("splitathonCharacterExpression", false));
		}
		var splitathonCharacterExpression = new Character(0, 0, 'dad');
		switch ("]]..character..[[")
		{
			case 'dave':
				splitathonCharacterExpression = new Character(-305, -game.dad.y + 20, 'dave-splitathon');
			case 'bambi':
				splitathonCharacterExpression = new Character(-300, game.dad.y - 375, 'bambi-splitathon');
		}
		game.dadGroup.insert(game.dadGroup.members.indexOf(game.dad), splitathonCharacterExpression);
		game.modchartSprites.set("splitathonCharacterExpression", splitathonCharacterExpression);

		splitathonCharacterExpression.skipDance = true;
		splitathonCharacterExpression.playAnim("]]..expression..[[", true);
		game.boyfriend.stunned = false;
	]])
	if character == "bambi" then setObjectOrder("splitathonCharacterExpression", getObjectOrder("dadGroup") + 1) else setObjectOrder("dadGroup", getObjectOrder("splitathonCharacterExpression") + 1) end 
	splitCharExpress = expression;
	setProperty("splitathonCharacterExpression.color", getColorFromHex(getBackgroundColor(getDataFromSave("UntitledVsDavePortSettings", "stageName"))))
end
function addSplitathonChar(character)
	setProperty("boyfriend.stunned", true)
	callOnLuas("switchDad", {character, --[[300, 450--]]0, 0, false})
	setProperty("dad.color", getColorFromHex(getBackgroundColor(getDataFromSave("UntitledVsDavePortSettings", "stageName"))))
	callOnLuas("repositionChar", {"dad"})
	setProperty("boyfriend.stunned", false)
end
function throwThatBitchInThere(guyWhoComesIn, guyWhoFliesOut)
	hasTriggeredDumbshit = true;
	runHaxeCode([[
		var guyWhoComesIn = "]]..guyWhoComesIn..[[";
		var guyWhoFliesOut = "]]..guyWhoFliesOut..[[";
		if (game.getLuaObject("BAMBICUTSCENEICONHURHURHUR", false) != null)
		{
			game.getLuaObject("BAMBICUTSCENEICONHURHURHUR", false).visible = false;
		}
		var BAMBICUTSCENEICONHURHURHUR = new HealthIcon(guyWhoComesIn, false);
		BAMBICUTSCENEICONHURHURHUR.changeState(game.iconP2.getState());
		BAMBICUTSCENEICONHURHURHUR.y = game.healthBar.y - (BAMBICUTSCENEICONHURHURHUR.height / 2);
		game.add(BAMBICUTSCENEICONHURHURHUR);
		BAMBICUTSCENEICONHURHURHUR.cameras = [game.camHUD];
		BAMBICUTSCENEICONHURHURHUR.x = -100;
		FlxTween.linearMotion(BAMBICUTSCENEICONHURHURHUR, -100, BAMBICUTSCENEICONHURHURHUR.y, game.iconP2.x, BAMBICUTSCENEICONHURHURHUR.y, 0.3, true, {ease: FlxEase.expoInOut});
		new FlxTimer().start(0.3, function(timer)
		{
			game.iconP2.changeIcon(guyWhoComesIn);
			BAMBICUTSCENEICONHURHURHUR.changeIcon(guyWhoFliesOut);
			BAMBICUTSCENEICONHURHURHUR.changeState(game.iconP2.getState());
		});
	]])
end