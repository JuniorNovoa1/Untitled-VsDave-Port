function onCreate()
	addHaxeLibrary("Process", 'sys.io')
	addHaxeLibrary("File", 'sys.io')
	addHaxeLibrary("Bytes", 'haxe.io')
	addHaxeLibrary("Sys")
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