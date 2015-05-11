addEvent("onMultistuntReportInsert", true)




addEventHandler("onMultistuntReportInsert", getRootElement(), function(typ, text)
	local result = mysql_query(handler, "INSERT INTO reports (DATUM, TYP, WRITER, REPORT) values ('"..getFormatDate().."', '"..typ.."', '"..getPlayerName(source).."', '"..text.."');")
	if(result) then
		for index, player in pairs(getElementsByType("player")) do
			if(isPlayerEingeloggt(player)) and (tonumber(getElementData(player, "ms.adminlevel")) > 0) then
				sendInfoMessage("New report from "..getPlayerName(source).."! Typ: "..typ, player, "aqua")
			end
		end
	else
		sendInfoMessage("An error occurred!", source, "red")
	end
end)