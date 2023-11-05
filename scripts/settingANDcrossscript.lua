local textOptionsArray = {};
local textInLanguages = {};

function onCreate()
	local textOptions = getTextFromFile("defaultOptions.txt", false)
	local curCharacters = "";
	if checkFileExists(currentModDirectory.."/options.txt", false) then
		textOptions = getTextFromFile("options.txt", false)
		for i = 1, #textOptions do
			if textOptions:sub(i, i) == "," then
				curCharacters = string.gsub(curCharacters, "", "")
				textOptionsArray[#textOptionsArray + 1] = curCharacters;
				curCharacters = "";
			else
				local currentCharacertsy = textOptions:sub(i, i);
				curCharacters = curCharacters..currentCharacertsy;
			end
		end
	else
		for i = 1, #textOptions do
			if textOptions:sub(i, i) == "," then
				curCharacters = string.gsub(curCharacters, "", "")
				textOptionsArray[#textOptionsArray + 1] = curCharacters;
				curCharacters = "";
			else
				local currentCharacertsy = textOptions:sub(i, i);
				curCharacters = curCharacters..currentCharacertsy;
			end
		end
	end

	setLanguages()
	initSaveData("UntitledVsDavePortSettings", 'UntitledVsDavePort')
	--settings
	setDataFromSave("UntitledVsDavePortSettings", "lang", textOptionsArray[1])
	setDataFromSave("UntitledVsDavePortSettings", "compatMode", convertStringToType(textOptionsArray[2], "bool"))
	setDataFromSave("UntitledVsDavePortSettings", "eyesores", convertStringToType(textOptionsArray[3], "bool"))
	setDataFromSave("UntitledVsDavePortSettings", "screenShake", convertStringToType(textOptionsArray[4], "bool"))
	--dont mess with this shit below
	setDataFromSave("UntitledVsDavePortSettings", "textInLanguages", textInLanguages)
	setDataFromSave("UntitledVsDavePortSettings", "defaultSettings", defaultSettings)
	setDataFromSave("UntitledVsDavePortSettings", "hasShapeNotes", false)
	setDataFromSave("UntitledVsDavePortSettings", "canFloat", true)
	setDataFromSave("UntitledVsDavePortSettings", "stageName", "")
end

function convertStringToType(str, convertType)
	local stringButLowered = string.lower(str)
	local convertTypeButLowered = string.lower(convertType)

	if convertTypeButLowered == "bool" then
		if stringButLowered == "true" then return true; end
		if stringButLowered == "false" then return false; end
	end
	return "";
end

function setLanguages()
	textInLanguages = { --cool shit!
	["en-us"] = {
		["play_score"] = "Score:",
		["play_miss"] = "Misses:",
		["play_accuracy"] = "Accuracy:",
		-- blocked
		["blocked_sub1"] = "I block you...",
		["blocked_sub2"] = "You are monster...",
		["blocked_sub3"] = "You ruined my life!",
		["blocked_sub4"] = "Moldy I swear to god I'll block you",
		["blocked_sub5"] = "FOREVER.",
		["blocked_sub6"] = "I'm trying to...",
		["blocked_sub7"] = "No I'm not trying help you...",
		["blocked_sub8"] = "Because you go watch me...",
		["blocked_sub9"] = "Because...",
		["blocked_sub10"] = "go watch me scribe me",
		["blocked_sub11"] = "Whatever.",
		-- corntheft
		["ctheft_sub1"] = "Because he add me...",
		["ctheft_sub2"] = "Why you add me...",
		["ctheft_sub3"] = "I-",
		["ctheft_sub4"] = "I don't care...",
		["ctheft_sub5"] = "You want to",
		["ctheft_sub6"] = "I'll block you",
		["ctheft_sub7"] = "I'm never coming back again.",
		-- maze
		["maze_sub1"] = "I mean...",
		["maze_sub2"] = "You can",
		["maze_sub3"] = "Play me...",
		["maze_sub4"] = "You don't?",
		["maze_sub5"] = "Never come back again.",
		["maze_sub6"] = "Fine!",
		["maze_sub7"] = "Anything you want",
		["maze_sub8"] = "You play me?",
		["maze_sub9"] = "Sure.",
		["maze_sub10"] = "What you want to play?",
		["maze_sub11"] = "You are bully me?",
		["maze_sub12"] = "Never come back again."
	},
	["es-us"] = {
		["play_score"] = "Puntuación:",
		["play_miss"] = "Fallos:",
		["play_accuracy"] = "Precisión:",
		-- blocked
		["blocked_sub1"] = "Te bloqueo.",
		["blocked_sub2"] = "Eres un monstruo.",
		["blocked_sub3"] = "Arruinas mi vida!",
		["blocked_sub4"] = "Moldy por dios te voy a bloquear para siempre.",
		["blocked_sub5"] = "POR SIEMPRE.",
		["blocked_sub6"] = "Intento...",
		["blocked_sub7"] = "No, no intento ayudarte...",
		["blocked_sub8"] = "Porque me sigues...",
		["blocked_sub9"] = "Porque...",
		["blocked_sub10"] = "sigueme suscribete",
		["blocked_sub11"] = "Como sea.",
		-- corntheft
		["ctheft_sub1"] = "Porque me añade...",
		["ctheft_sub2"] = "¿Por qué me quieres añadir?",
		["ctheft_sub3"] = "No-",
		["ctheft_sub4"] = "No me importa...",
		["ctheft_sub5"] = "Tu quieres",
		["ctheft_sub6"] = "Te voy a bloquear",
		["ctheft_sub7"] = "No volveré nunca más.",
		-- maze
		["maze_sub1"] = "Digo...",
		["maze_sub2"] = "Tu puedes",
		["maze_sub3"] = "Jugarme...",
		["maze_sub4"] = "¿No puedes?",
		["maze_sub5"] = "No vuelvas nunca más.",
		["maze_sub6"] = "¡Bien!",
		["maze_sub7"] = "Lo que quieras.",
		["maze_sub8"] = "¿Me juegas?",
		["maze_sub9"] = "Bien.",
		["maze_sub10"] = "¿Que quieres jugar?",
		["maze_sub11"] = "¿Tu me acosas?",
		["maze_sub12"] = "No vuelvas nunca más."
	},
	["pt-br"] = {
		["play_score"] = "Pontuação:",
		["play_miss"] = "Erros:",
		["play_accuracy"] = "Precisão:",
		-- blocked
		["blocked_sub1"] = "Eu te bloquear...",
		["blocked_sub2"] = "Você é um monstro...",
		["blocked_sub3"] = "Você arruinou minha vida!",
		["blocked_sub4"] = "Moldy eu juro por deus eu vou te bloquear",
		["blocked_sub5"] = "PRA SEMPRE.",
		["blocked_sub6"] = "Eu tô tentando...",
		["blocked_sub7"] = "Não eu não tô tentando te ajudar...",
		["blocked_sub8"] = "Porque cê vai ver...",
		["blocked_sub9"] = "Porque...",
		["blocked_sub10"] = "me assista vá se inscrever a mim",
		["blocked_sub11"] = "Que seja.",
		-- corntheft
		["ctheft_sub1"] = "Por causa que ele me banir...",
		["ctheft_sub2"] = "Por que você me banir...",
		["ctheft_sub3"] = "Eu-",
		["ctheft_sub4"] = "Eu não ligo...",
		["ctheft_sub5"] = "Você quer",
		["ctheft_sub6"] = "Eu vou te bloquear",
		["ctheft_sub7"] = "Eu nunca vou voltar.",
		-- maze
		["maze_sub1"] = "Quer dizer...",
		["maze_sub2"] = "Você pode...",
		["maze_sub3"] = "Joga comigo...",
		["maze_sub4"] = "Você não?",
		["maze_sub5"] = "Nunca mais volte.",
		["maze_sub6"] = "Tá bom!",
		["maze_sub7"] = "O que quiser",
		["maze_sub8"] = "Você joga comigo?",
		["maze_sub9"] = "Claro.",
		["maze_sub10"] = "O que você quer jogar?",
		["maze_sub11"] = "Você me bullying?",
		["maze_sub12"] = "Nunca mais volte."
	}}
end