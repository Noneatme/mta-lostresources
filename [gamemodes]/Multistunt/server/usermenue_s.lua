local ankuendigungen = "N/A"

addEvent("onUsermenueDataNeed", true)
addEventHandler("onUsermenueDataNeed", getRootElement(), function()
	local result = mysql_query(handler, "SELECT * FROM accounts WHERE NAME = '"..getPlayerName(source).."';")
	local register
	if(result) then
		local row = mysql_fetch_assoc(result)
		register = row['REGISTERDATUM']
		mysql_free_result(result)
	end
	triggerClientEvent(source, "onUsermenueDataNeedBack", source, ankuendigungen, register)
end)

addEventHandler("onResourceStart", getResourceRootElement(), function()
	outputServerLog("Ankuendigungen werden geladen...")
	setTimer( function()
		if(handler) then
			local result = mysql_query(handler, "SELECT * FROM public;")
			if(result and mysql_num_rows(result) > 0) then
				local row = mysql_fetch_assoc(result)
				ankuendigungen = row['ANKUENDIGUNGEN']
				outputServerLog("Ankuendigungen geladen:")
				outputServerLog(ankuendigungen)
				mysql_free_result(result)
			else
				mysql_query(handler, "INSERT INTO public (ANKUENDIGUNGEN) values ('DEFAULT');")
				outputServerLog("Ankuendigungen konnten nicht geladen werden!(MySQL) bitte Server Restarten!!")
			end
		else
			outputServerLog("Ankuendigungen konnten nicht geladen werden!")
		end
	
	end, 1000, 1)
end)

function saveUsermenueAnkuendigungen(thePlayer)
	local result = mysql_query(handler, "UPDATE public SET ANKUENDIGUNGEN = '"..ankuendigungen.."';")
	if(result) then
		outputChatBox("Ankuendigungen Gespeichert!", thePlayer, 0, 255, 0)
		outputServerLog("Ankuendigungen wurden von "..getPlayerName(thePlayer).." gespeichert.")
	else
		outputChatBox("Ankuendigungen konnten nicht gespeichert werden! MySQL Fehler!", thePlayer, 255, 0, 0)
		outputServerLog("Ankuendigungen: Kein Result - Nicht von "..getPlayerName(thePlayer).." gespeichert worden!")
	end
end

addEvent("onUsermenueAnkuendigungenChange", true)
addEventHandler("onUsermenueAnkuendigungenChange", getRootElement(), function(text)
	ankuendigungen = text
	saveUsermenueAnkuendigungen(source)
end)