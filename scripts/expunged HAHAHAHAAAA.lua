function onCreate()
	addHaxeLibrary("Process", 'sys.io')
	addHaxeLibrary("File", 'sys.io')
	addHaxeLibrary("Bytes", 'haxe.io')
end

function onGameOver()
	local expungedLines = 
	{
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
	saveFile(currentModDirectory.."/HELLO.txt", expungedLines[getRandomInt(1, #expungedLines)], false)
	if buildTarget == "windows" then
		runHaxeCode([[
			var fileContent = "]]..expungedLines[getRandomInt(1, #expungedLines)]..[[";
			var path = Sys.getEnv("TEMP") + "/HELLO.txt";
			File.saveContent(path, fileContent);
			Sys.command("start " + path);
		]])
	end
end