function onCreate()
	addHaxeLibrary("Process", 'sys.io')
	addHaxeLibrary("File", 'sys.io')
	addHaxeLibrary("Bytes", 'haxe.io')
	addHaxeLibrary("Sys")
end

function onCreatePost()
	for i = 0, getProperty("unspawnNotes.length") do
		if getPropertyFromGroup("unspawnNotes", i, "noteType") == "phone" or getPropertyFromGroup("unspawnNotes", i, "noteType") == "phone-alt" then
			setPropertyFromGroup("unspawnNotes", i, "multSpeed", returnScrollSpeed(1.08))
		end
		if string.lower(songName) == "unfairness" then
			if getRandomInt(0, 120) == 1 then
				setPropertyFromGroup("unspawnNotes", i, "multSpeed", returnScrollSpeed(0.1))
			else 
				setPropertyFromGroup("unspawnNotes", i, "multSpeed", returnScrollSpeed(getRandomFloat(1, 3)))
			end
		end
		if string.lower(songName) == "exploitation" then
			if getRandomInt(0, 484) == 1 then
				setPropertyFromGroup("unspawnNotes", i, "multSpeed", returnScrollSpeed(0.1))
			else 
				setPropertyFromGroup("unspawnNotes", i, "multSpeed", returnScrollSpeed(getRandomFloat(2.9, 3.6)))
			end
		end
		--setPropertyFromGroup("unspawnNotes", i, "multSpeed", returnScrollSpeed(getPropertyFromGroup("unspawnNotes", i, "multSpeed") + getRandomFloat(-0.3, 0)))
		--setPropertyFromGroup("unspawnNotes", i, "multSpeed", returnScrollSpeed(getPropertyFromGroup("unspawnNotes", i, "multSpeed") + getRandomFloat(-0.3, 0.3)))
		--setPropertyFromGroup("unspawnNotes", i, "multSpeed", returnScrollSpeed(1 * getRandomFloat(0.7, 1.01)))
	end
end
function onUpdate(elapsed)
	--[[setPropertyFromClass("ClientPrefs", "downScroll", true)
	for i = 0, getProperty("notes.length") do
		setPropertyFromGroup("notes", i, "downScroll", true)
	end--]]
end
function returnScrollSpeed(newScrollSpeed)
	local change = 1; if downscroll then change = -1; end
	return newScrollSpeed; --cancels shit after
	--return change * 0.45 * (getProperty("songSpeed") * newScrollSpeed);
	--return change * 0.45 * math.floor((getProperty("songSpeed") * newScrollSpeed));
end

function onGameOver()
	if string.lower(songName) ~= "exploitation" then return; end
	local expungedLines = {
		'[I FOUND YOU]', 
		"[I CAN SEE YOU]", 
		'[HAHAHHAHAHA]', 
		"[PUNISHMENT DAY IS HERE, THIS ONE IS REMOVING YOU]",
		"[GOT YOU]",
		"[TRY AGAIN, IF YOU DARE]",
		"[NICE TRY]",
		"[I COULD DO THIS ALL DAY]",
		"[DO THAT AGAIN, I LIKE WATCHING YOU FAIL]"
	};
	if buildTarget == "windows" then
		runHaxeCode([[
			var fileContent = "]]..expungedLines[getRandomInt(1, #expungedLines)]..[[";
			var path = Sys.getEnv("TEMP") + "/HELLO.txt";
			File.saveContent(path, fileContent);
			Sys.command("start " + path);
		]])
	end
	if buildTarget == "mac" then
		runHaxeCode([[
			var fileContent = "]]..expungedLines[getRandomInt(1, #expungedLines)]..[[";
			var path = Sys.getEnv("HOME") + "/HELLO.txt";
			File.saveContent(path, fileContent);
			Sys.command("open " + path);
		]])
	end
	if buildTarget == "linux" then
		runHaxeCode([[
			var fileContent = "]]..expungedLines[getRandomInt(1, #expungedLines)]..[[";
			var path = Sys.getEnv("HOME") + "/HELLO.txt";
			File.saveContent(path, fileContent);
			Sys.command("xdg-open " + path);
		]])
	end
end