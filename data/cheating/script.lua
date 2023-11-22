local elapsedtime = 0.0;
function onUpdate(elapsed)
	elapsedtime = elapsedtime + elapsed;
	for i = 0, getProperty("playerStrums.length") do
		if i % 2 == 0 then 
			setPropertyFromGroup("playerStrums", i, "x", getPropertyFromGroup("playerStrums", i, "x") + ((math.sin(elapsedtime) * 1))) 
		else
			setPropertyFromGroup("playerStrums", i, "x", getPropertyFromGroup("playerStrums", i, "x") + ((math.sin(elapsedtime) * -1)))
		end
		setPropertyFromGroup("playerStrums", i, "x", getPropertyFromGroup("playerStrums", i, "x") - ((math.sin(elapsedtime) * 1.5)))
	end
end
function onUpdatePost(elapsed)
	for i = 0, getProperty("opponentStrums.length") do
		if i % 2 == 0 then 
			setPropertyFromGroup("opponentStrums", i, "x", getPropertyFromGroup("opponentStrums", i, "x") - ((math.sin(elapsedtime) * 1))) 
		else
			setPropertyFromGroup("opponentStrums", i, "x", getPropertyFromGroup("opponentStrums", i, "x") - ((math.sin(elapsedtime) * -1)))
		end
		setPropertyFromGroup("opponentStrums", i, "x", getPropertyFromGroup("opponentStrums", i, "x") + ((math.sin(elapsedtime) * 1.5)))
	end
end