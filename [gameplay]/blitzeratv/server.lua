-- Script [C] by MuLTi -- For ATV Reallife --

local handler = mysql_connect("127.0.0.1", "root", "", "dbs_test") -- Mit Vio Verbindung ersetzen
local anzahl = 0
local blitzerobs = {}

local bussgeldfaktor = 1.8

addEvent("onBlitzerCreate", true)
addEvent("onBlitzerDelete", true)
addEvent("onBlitzerSpeedSet", true)
addEvent("onBlitzerObDelete", true)

local function giveBlitzerFunktion(blitzer)
	local col = getElementData(blitzer, "blitzer.col")
	addEventHandler("onColShapeHit", col, function(hitElement)
		if(getElementData(col, "enabled") ~= true) then return end
		if(getElementType(hitElement) == "vehicle") and (getVehicleOccupant(hitElement)) then
			local vx, vy, vz = getElementVelocity(hitElement)
			local speed = math.ceil((vx^2 + vy^2 + vz^2) ^ 0.5 * 1.51 * 100)
			if(speed > tonumber(getElementData(col, "blitzer.maxspeed"))+5) then
				ueberschritten = speed-tonumber(getElementData(col, "blitzer.maxspeed"))
				local geld = math.floor(ueberschritten*bussgeldfaktor)
				local playa = getVehicleOccupant(hitElement)
				local stvos = math.ceil(ueberschritten/ueberschritten*geld/20)
				fadeCamera(playa, false, 0, 255, 255, 255)
				setTimer(fadeCamera, 50, 1, playa, true)
				outputChatBox("Du wurdest mit "..speed.." KM/H geblitzt, und musst "..geld.."$ Strafe zahlen!", playa, 255, 0, 0)
				outputChatBox("STVO Punkte bekommen: "..stvos, playa, 255, 0, 0)
				outputChatBox("Ueberschreitung: "..ueberschritten.." KM/H, Erlaubt: "..tonumber(getElementData(col, "blitzer.maxspeed")).." KM/H.", playa, 255, 0, 0)
				vioSetElementData ( playa, "stvo_punkte", vioGetElementData ( playa, "stvo_punkte" )+stvos)
				vioSetElementData ( playa, "money", vioGetElementData ( playa, "money" ) - geld )
			end
		end
	end)
end


-- Create Blitzers --
local function createBlitzers()
	if not(handler) then outputServerLog("Keine MySQL Verbindung!!") return end
	local result = mysql_query(handler, "SELECT * FROM blitzer;")
	if(result) then
		local dsatz
		dsatz = mysql_fetch_assoc(result)
		while (dsatz) do
			local id = dsatz['ID']
			blitzerobs[id] = createObject(1215, dsatz['X'], dsatz['Y'], dsatz['Z'])
			local col = createColSphere(dsatz['CX'], dsatz['CY'], dsatz['CZ'], 10)
			setElementData(blitzerobs[id], "blitzer.maxspeed", tonumber(dsatz['SPEED']))
			setElementData(blitzerobs[id], "blitzer.id", dsatz['ID'])
			setElementData(blitzerobs[id], "blitzer.col", col)
			setElementData(col, "blitzer.maxspeed", tonumber(dsatz['SPEED']))
			setElementData(col, "enabled", true)
			setObjectScale(blitzerobs[id], 1.7)
			setElementFrozen(blitzerobs[id], true)
			anzahl = anzahl+1
			giveBlitzerFunktion(blitzerobs[id])
			dsatz = mysql_fetch_assoc(result)
		end
		outputServerLog(anzahl.." Blitzer wurden erstellt!")
		mysql_free_result(result)
	end

end

outputServerLog("Blizer werden erstellt...")
setTimer(createBlitzers, 1000, 1)

-- Blitzer Create Funktion --

addEventHandler("onBlitzerCreate", getRootElement(), function(x1, y1, z1, x2, y2, z2, speed)
	local result = mysql_query(handler, "INSERT INTO blitzer (X, Y, Z, SPEED, CX, CY, CZ) VALUES ('"..x2.."', '"..y2.."', '"..z2.."', '"..speed.."', '"..x1.."', '"..y1.."', '"..z1.."');")
	if(result) then
		for index, blitze in pairs(blitzerobs) do
			destroyElement(getElementData(blitze, "blitzer.col"))
			destroyElement(blitze)
			blitze = nil
		end
		outputChatBox("Blitzer erfolgreich erstellt!", source, 0, 255, 0)
		createBlitzers()
		mysql_free_result(result)
	else
		outputChatBox("Fehler beim erstellen des Bltizers(MySQL Result: nil)!", source, 255, 0, 0)
	end
end)

addEventHandler("onBlitzerSpeedSet", getRootElement(), function(id, speed)
	outputChatBox("Uebernommen!", source, 0, 255, 0)
	mysql_query(handler, "UPDATE blitzer SET SPEED = '"..speed.."' WHERE ID = '"..id.."';")
end)

addEventHandler("onBlitzerObDelete", getRootElement(), function(lol)
	destroyElement(getElementData(blitzerobs[lol], "blitzer.col"))
	destroyElement(blitzerobs[lol])
end)
addEventHandler("onBlitzerDelete", getRootElement(), function(id)
	local result = mysql_query(handler, "DELETE FROM blitzer WHERE ID = '"..id.."';")
	if(result) then
		triggerEvent("onBliterObDelete", getRootElement(), id)
		outputChatBox("Blitzer wird beim serverneustart nicht mehr Vorhanden sein! Er wurde Deaktivert.", source, 0, 255, 0)
		mysql_free_result(result)
	end
end)


addCommandHandler("blitzer", function(thePlayer, cmd)
	if(isArmy(thePlayer)) or (isCop(thePlayer)) or (isFBI(thePlayer)) then
		triggerClientEvent(thePlayer, "onBlitzerCommand", thePlayer)
	else
		outputChatBox("Du hast keine Berechtigung!", thePlayer, 255, 0, 0)
	end
end)
