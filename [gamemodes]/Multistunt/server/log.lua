--

addEventHandler("onPlayerJoin", getRootElement(), function()
	if(source) and (getPlayerName(source)) then else return end
	local result = mysql_query(handler, "INSERT INTO logs ( DATUM, NAME, FUNKTION, IP) VALUES ( '"..getFormatDate().."', '"..getPlayerName(source).."', 'Betrat Server', '"..getPlayerIP(source).."');")
	if(result) then mysql_free_result(result) end
end)

addEventHandler("onPlayerQuit", getRootElement(), function(typ, reason, element)
	if(typ ~= "Kicked") then
		local result = mysql_query(handler, "INSERT INTO logs ( DATUM, NAME, FUNKTION, IP, AKTION) VALUES ( '"..getFormatDate().."', '"..getPlayerName(source).."', 'Verliess Server', '"..getPlayerIP(source).."', '"..tostring(typ).."');")
		if(result) then mysql_free_result(result) end
	else
		local result = mysql_query(handler, "INSERT INTO logs ( DATUM, NAME, FUNKTION, IP, AKTION) VALUES ( '"..getFormatDate().."', '"..getPlayerName(source).."', 'Verliess Server', '"..getPlayerIP(source).."', '"..tostring(typ).."(Kicker: "..getPlayerName(element)..")');")
		if(result) then mysql_free_result(result) end
	end
end)

addEventHandler("onPlayerWasted", getRootElement(), function(ammo, killer)
	local result = mysql_query(handler, "INSERT INTO logs ( DATUM, NAME, FUNKTION, IP, AKTION) VALUES ( '"..getFormatDate().."', '"..getPlayerName(source).."', 'Wurde getoetet.', '"..getPlayerIP(source).."', 'Killer: "..tostring(killer).."');")
	if(result) then mysql_free_result(result) end
end)
