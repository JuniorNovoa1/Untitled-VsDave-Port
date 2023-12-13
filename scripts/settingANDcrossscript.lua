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
	setDataFromSave("UntitledVsDavePortSettings", "charSelect", convertStringToType(textOptionsArray[5], "bool"))
	setDataFromSave("UntitledVsDavePortSettings", "selfAwareness", convertStringToType(textOptionsArray[6], "bool"))
	setDataFromSave("UntitledVsDavePortSettings", "antiPsychEngine", convertStringToType(textOptionsArray[7], "bool"))
	--dont mess with this shit below
	setDataFromSave("UntitledVsDavePortSettings", "textInLanguages", textInLanguages)
	setDataFromSave("UntitledVsDavePortSettings", "defaultSettings", defaultSettings)
	setDataFromSave("UntitledVsDavePortSettings", "hasShapeNotes", false)
	setDataFromSave("UntitledVsDavePortSettings", "canFloat", true)
	setDataFromSave("UntitledVsDavePortSettings", "stageName", "")
	setDataFromSave("UntitledVsDavePortSettings", "nightColor", "0xFF878787")
	setDataFromSave("UntitledVsDavePortSettings", "sunsetColor", "D48ECD")
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
		["supernovae_credit"] = "Original Song made by ArchWk!",
		["glitch_credit"] = "Original Song made by DeadShadow and PixelGH!",
		["mealie_credit"] = "Original Song made by Alexander Cooper 19!",
		["overdrive_credit"] = "Original Song made by Top 10 Awesome!",
		["unfairness_credit"] = "Ghost Tapping is forced off! FUCK YOU!",
		["cheating_credit"] = "Notes are scrambled! FUCK YOU!",
		["exploitation_credit"] = "You won't survive ",
		["kabunga_credit"] = "OH MY GOD I JUST DEFLATED",

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
		["maze_sub12"] = "Never come back again.",
		--shredder
		["shred_sub1"] = "Oh my god...",
		["shred_sub2"] = "I fucking hate you",
		["shred_sub3"] = "Fuck ahh, I hate you so much...",
		["shred_sub4"] = "Check your closet!",
		["shred_sub5"] = "Check your closet!",
		["shred_sub6"] = "Or else",
		["shred_sub7"] = "Imma kill you like rodeo",
		["shred_sub8"] = "Trash.",
		["shred_sub9"] = "Like this",
		["shred_sub10"] = "Grrrrr!",
		["shred_sub11"] = "Check your closet motherfuckers",
		["shred_sub12"] = "Check your closet mothafuckas!",
		["shred_sub13"] = "That's it!",
		["shred_sub14"] = "That's it!",
		--exploitation!
		["exploit_sub1"] = "The fuck?",
		["exploit_sub2"] = "Ehhhhhhhhhhhhhhhhhhhhh!!!",
		["exploit_sub3"] = "Wahahauahahahuehehe!",
		["exploit_sub4"] = "Fucking phone...",
		["exploit_sub5"] = "Eoooooooooooooooooo",
		["exploit_sub6"] = "Seeeiuuuuuuuuuuuuuu",
		["exploit_sub7"] = "Naaaaaaaaaaaaaaaaaaaaa",
		["exploit_sub8"] = "Aehehehe...",
		["exploit_sub9"] = "Oh he...",
		["exploit_sub10"] = "You are so",
		["exploit_sub11"] = "get trolled!",
		["exploit_sub12"] = "Whoopsies...",
		["exploit_sub13"] = "You lying!",
		["exploit_sub14"] = "YOU LYING!",
		["exploit_sub15"] = "A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€",
		--cjeatomng
		["cheating_sub1"] = "I block you.",
		["cheating_sub2"] = "You are monster.",
		["cheating_sub3"] = "You ruin my life!",
		["cheating_sub4"] = "Moldy I swear to god I block you forever.",
		["cheating_sub5"] = "I am block you.",
		["cheating_sub6"] = "Do you stop click to friend...",
		["cheating_sub7"] = "Jumpman12 I block you Moldy! ",
		["cheating_sub8"] = "Auugh auugh",
		["cheating_sub9"] = "*gibberish*",
		["cheating_sub10"] = "Ok, *gibberish*",
		["cheating_sub11"] = "You stupid.",
		["cheating_sub12"] = "Uhhh, *gibberish*",
		["cheating_sub13"] = "What's your, umm...",
		["cheating_sub14"] = "What's your fun games?",
		["cheating_sub15"] = "Wh-",
		["cheating_sub16"] = "What your favorite games?",
		["cheating_sub17"] = "What your favorite?",
		["cheating_sub18"] = "His name-",
		["cheating_sub19"] = "He said...",
		["cheating_sub20"] = "Dead games.",
		["cheating_sub21"] = "Dick!",
		["cheating_sub22"] = "Jumpman...",
		["cheating_sub23"] = "No...",
		["cheating_sub24"] = "Dick, heh!",
		["cheating_sub25"] = "Oh my god so...",
		["cheating_sub26"] = "It's not funny this is stupid.",
		["cheating_sub27"] = "Ohoh!!!",
		["cheating_sub28"] = "Hehehe! Huhuhuhuh...",
		["cheating_sub29"] = "Hehehehe...",
		["cheating_sub30"] = "Huhuhuhuhuhu, hehe!",
		--unfairness
		["unfairness_sub1"] = "Kidding!",
		["unfairness_sub2"] = "I...",
		["unfairness_sub3"] = "Paint...",
		["unfairness_sub4"] = "This one two hours I painting.",
		["unfairness_sub5"] = "Look!",
		["unfairness_sub6"] = "I'm not kidding this is...",
		["unfairness_sub7"] = "Fucking real!"
	},
	["es-us"] = {
		["supernovae_credit"] = "¡La canción original fue creada por ArchWk!",
		["glitch_credit"] = "¡La canción original fue creada por DeadShadow y PixelGH!",
		["mealie_credit"] = "¡La canción original fue creada por Alexander Cooper 19!",
		["overdrive_credit"] = "¡La canción original fue creada por Top 10 Awesome!",
		["unfairness_credit"] = "¡Ghost Tapping esta desactivado! JODETE!",
		["cheating_credit"] = "¡Las notas estan revueltas! JODETE!",
		["exploitation_credit"] = "¡No sobrevivirás ",
		["kabunga_credit"] = "OH DIOS MIO ACABO DE DESINFLARME",

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
		["maze_sub12"] = "No vuelvas nunca más.",
		--shredder
		["shred_sub1"] = "Oh dios mio...",
		["shred_sub2"] = "Joder, cómo te odio.",
		["shred_sub3"] = "Ese puto, te odio demasiado...",
		["shred_sub4"] = "¡Revisa tu closet!",
		["shred_sub5"] = "¡Revisa tu closet!",
		["shred_sub6"] = "O si no",
		["shred_sub7"] = "Te mataré y tiraré toda tu",
		["shred_sub8"] = "Basura.",
		["shred_sub9"] = "Así",
		["shred_sub10"] = "¡Grrrrr!",
		["shred_sub11"] = "Revisen sus closets concha de su madre",
		["shred_sub12"] = "Revisen sus closets concha de su madre",
		["shred_sub13"] = "¡Eso es todo!",
		["shred_sub14"] = "¡Eso es todo!",
		--exploitation
		["exploit_sub1"] = "¿Que mierda?",
		["exploit_sub2"] = "¡¡¡Ehhhhhhhhhhhhhhhhhhhhh!!!",
		["exploit_sub3"] = "Wajajauajajajuejeje!",
		["exploit_sub4"] = "Puto teléfono...",
		["exploit_sub5"] = "Eoooooooooooooooooo",
		["exploit_sub6"] = "Seeeiuuuuuuuuuuuuuu",
		["exploit_sub7"] = "Naaaaaaaaaaaaaaaaaaaaa",
		["exploit_sub8"] = "Aejejeje...",
		["exploit_sub9"] = "Oh je...",
		["exploit_sub10"] = "Eres tan ..",
		["exploit_sub11"] = "¡se troleado!",
		["exploit_sub12"] = "Whoopsies...",
		["exploit_sub13"] = "¡Me mientes!",
		["exploit_sub14"] = "¡ME MIENTES!",
		["exploit_sub15"] = "A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€A€",
		--cheating
		["cheating_sub1"] = "Te bloqueo.",
		["cheating_sub2"] = "Eres un monstruo.",
		["cheating_sub3"] = "Arruinas mi vida!",
		["cheating_sub4"] = "Moldy por dios te voy a bloquear para siempre.",
		["cheating_sub5"] = "Te estoy bloqueado.",
		["cheating_sub6"] = "Deja presionar click para añadir",
		["cheating_sub7"] = "¡Jumpman12 te bloqueo Moldy!",
		["cheating_sub8"] = "Auugh auugh",
		["cheating_sub9"] = "*sin sentido*",
		["cheating_sub10"] = "Ok, *sin sentido*",
		["cheating_sub11"] = "Tonto.",
		["cheating_sub12"] = "Uhhh, *sin sentido*",
		["cheating_sub13"] = "Cual es eehhhh...",
		["cheating_sub14"] = "¿Cual es tus juegos divertidos?",
		["cheating_sub15"] = "Qué-",
		["cheating_sub16"] = "¿Qué es tu juego favorito?",
		["cheating_sub17"] = "¿Cual es tu favorito?",
		["cheating_sub18"] = "Su nombre...",
		["cheating_sub19"] = "El dijo...",
		["cheating_sub20"] = "juegos muertos.",
		["cheating_sub21"] = "¡Pendejo!",
		["cheating_sub22"] = "Jumpman...",
		["cheating_sub23"] = "No...",
		["cheating_sub24"] = "Pendejo, jeje!",
		["cheating_sub25"] = "Dios mio tan...",
		["cheating_sub26"] = "Esto no es gracioso, es estupido",
		["cheating_sub27"] = "¡¡¡Ojojo!!!",
		["cheating_sub28"] = "¡Jejeje! Jujujuju...",
		["cheating_sub29"] = "Jejejeje...",
		["cheating_sub30"] = "¡Jujujujujuju, jeje!",
		--unfairness
		["unfairness_sub1"] = "¡Bromeaba!",
		["unfairness_sub2"] = "Yo...",
		["unfairness_sub3"] = "Pinté...",
		["unfairness_sub4"] = "Esto lo pinté por dos horas.",
		["unfairness_sub5"] = "¡Mira!",
		["unfairness_sub6"] = "No les miento esto es...",
		["unfairness_sub7"] = "Jodidamente cierto!"
	},
	["pt-br"] = {
		["supernovae_credit"] = "Música original feita por ArchWk!",
		["glitch_credit"] = "Música original feita por DeadShadow e PixelGH!",
		["mealie_credit"] = "Música original feita por Alexander Cooper 19!",
		["overdrive_credit"] = "Música original feita por Top 10 Awesome!",
		["unfairness_credit"] = "Ghost Tapping foi desligado! SE FODEU!",
		["cheating_credit"] = "Notas embaralhadas! SE FODEU!",
		["exploitation_credit"] = "Você não sobreviverá ",
		["kabunga_credit"] = "CARALHO EU MURCHEI",

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
		["maze_sub12"] = "Nunca mais volte.",
		--shredder
		["shred_sub1"] = "Ai meu deus...",
		["shred_sub2"] = "Eu te odeio tanto",
		["shred_sub3"] = "Aquele cara, eu te odeio tanto...",
		["shred_sub4"] = "Olha seu armário!",
		["shred_sub5"] = "Olha seu armário!",
		["shred_sub6"] = "Se não",
		["shred_sub7"] = "Eu vou te matar seu forasteiro de uma",
		["shred_sub8"] = "Figa.",
		["shred_sub9"] = "E isso",
		["shred_sub10"] = "Durrrr!",
		["shred_sub11"] = "Olha seu armário filhos da puta",
		["shred_sub12"] = "Olha seu armário filhos da puta",
		["shred_sub13"] = "Isso aí!",
		["shred_sub14"] = "Isso aí!",

		["cheating_sub1"] = "Eu bloquear você.",
		["cheating_sub2"] = "Você é monstro.",
		["cheating_sub3"] = "Você arruinar minha vida!",
		["cheating_sub4"] = "Moldy eu juro por deus eu bloqueio você pra sempre.",
		["cheating_sub5"] = "Eu vou bloquear.",
		["cheating_sub6"] = "Você para clicar em amizade...",
		["cheating_sub7"] = "Jumpman12 eu bloquear você Moldy!",
		["cheating_sub8"] = "Auugh auugh",
		["cheating_sub9"] = "*tagarelice*",
		["cheating_sub10"] = "Ok, *tagarelice*",
		["cheating_sub11"] = "Você estúpido.",
		["cheating_sub12"] = "Uhhh, *tagarelice*",
		["cheating_sub13"] = "Qual o seu, uhh...",
		["cheating_sub14"] = "Qual o seu jogo divertidos?",
		["cheating_sub15"] = "Wh-",
		["cheating_sub16"] = "Qual seu jogo favoritos?",
		["cheating_sub17"] = "Qual seu favorito?",
		["cheating_sub18"] = "Nome dele-",
		["cheating_sub19"] = "Ele disse...",
		["cheating_sub20"] = "Jogos mortos.",
		["cheating_sub21"] = "Pinto!",
		["cheating_sub22"] = "Jumpman...",
		["cheating_sub23"] = "Não...",
		["cheating_sub24"] = "Pinto, heh!",
		["cheating_sub25"] = "Ô meu deus tá...",
		["cheating_sub26"] = "Não é engraçado isso é estúpido.",
		["cheating_sub27"] = "Ohoh!!!",
		["cheating_sub28"] = "Hehehe! Huhuhuhuh...",
		["cheating_sub29"] = "Hehehehe...",
		["cheating_sub30"] = "Huhuhuhuhuhu, hehe!",
		
		["unfairness_sub1"] = "Zoando!",
		["unfairness_sub2"] = "Eu...",
		["unfairness_sub3"] = "Desenhei...",
		["unfairness_sub4"] = "Esse aqui duas horas eu desenhando.",
		["unfairness_sub5"] = "Olha!",
		["unfairness_sub6"] = "Eu não tô zoando isso é...",
		["unfairness_sub7"] = "Verdade porra!",
		
		["exploit_sub1"] = "Mai que porra?",
		["exploit_sub2"] = "Ehhhhhhhhhhhhhhhhhhhhh!!!",
		["exploit_sub3"] = "Wahahauahahahuehehe!",
		["exploit_sub4"] = "Porra de celular...",
		["exploit_sub5"] = "Eoooooooooooooooooo",
		["exploit_sub6"] = "Seeeiuuuuuuuuuuuuuu",
		["exploit_sub7"] = "Naaaaaaaaaaaaaaaaaaaaa",
		["exploit_sub8"] = "Aehehehe...",
		["exploit_sub9"] = "Oh he...",
		["exploit_sub10"] = "Você tá tão",
		["exploit_sub11"] = "foi trollado!",
		["exploit_sub12"] = "Oops...",
		["exploit_sub13"] = "Você mentindo!",
		["exploit_sub14"] = "VOCÊ MENTINDO!"
	}}
end