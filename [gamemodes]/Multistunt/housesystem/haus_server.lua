--local handler = mysql_connect ( "176.9.44.136", "styla_rl", "PcnGCJC3MNVBCHL8", "styla_rl" )
local index = 1
function createHaeuser ( )

		local query = "SELECT * FROM haus ;"
		local result = mysql_query( handler, query )
		
	if ( result ) then
	
		hsatz = mysql_fetch_assoc( result )
	while hsatz do

		local mieter = hsatz['MIETER']
		local x, y, z = hsatz['X'], hsatz['Y'], hsatz['Z']
		local intx, inty, intz = hsatz['INTX'], hsatz['INTY'], hsatz['INTZ']
		local int = hsatz['INTERIOR']
		local besitzer = hsatz['BESITZER']
		local preis = hsatz['PREIS']
		local id = hsatz['ID']
		local locked = hsatz['LOCKED']
		local kasse = hsatz['KASSE']
		local mietend = hsatz['VERMIETEN']
		local mietpreis = hsatz['MIETPREIS']
		local haus
		local intcol
		local pickup
		local blip
		if(besitzer ~= "staat") then
			pickup = createPickup ( x, y, z-0.5, 3, 1272, 500 )
			haus = createColSphere(x, y, z, 2)
			setElementDimension(haus, id)
		else
			pickup = createPickup ( x, y, z-0.5, 3, 1273, 500 )
			haus = createColSphere(x, y, z, 2)
			setElementDimension(haus, id)
		end
		blip = createBlip(x, y, z, 31, 2, 255, 0, 0, 255, 0, 500, getRootElement())
		setElementData(haus, "HBLIP", blip)
		intcol = createColSphere(intx, inty, intz, 3)
		setElementInterior(intcol, int)
		setElementDimension(intcol, id)
		local wtf = createPickup(intx, inty, intz, 3, 1318, 500)
		setElementInterior(wtf, int)
		setElementDimension(wtf, id)
		
		--createBlip( x, y, z, 31, 2, 255, 0, 0, 255, 0, 50)
		
		setElementData ( intcol, "HBESITZER", besitzer )
		setElementData ( intcol, "HMIETER", mieter )
		setElementData ( intcol, "HID", id )
		setElementData ( intcol, "HX", x )
		setElementData ( intcol, "HY", y )
		setElementData ( intcol, "HZ", z )
		setElementData ( intcol, "HAUSCOL", true)
		setElementData ( intcol, "HKASSE", kasse)
		
		setElementData ( haus, "HBESITZER", besitzer )
		setElementData ( haus, "HMIETER", mieter )
		setElementData ( haus, "HPREIS", preis)
		setElementData ( haus, "HINT", int )
		setElementData ( haus, "HINTX", intx )
		setElementData ( haus, "HINTY", inty )
		setElementData ( haus, "HINTZ", intz )
		setElementData ( haus, "HID", id )
		setElementData ( haus, "HLOCKED", locked)
		setElementData ( haus, "HMIETEND", mietend)
		setElementData ( haus, "HAUS", true)
		setElementData ( haus, "HPICKUP", pickup)
		setElementData ( haus, "HMIETPREIS", mietpreis)
		addEventHandler ( "onColShapeHit", haus,
		function(player)
			setElementData ( player, "lastHausVisit", source )
			local besitzer = getElementData(source, "HBESITZER")
			if(besitzer == "staat") then
				outputChatBox("Dieses Haus ist zu verkaufen. Tippe /buyhouse, wenn du es kaufen moechtest.", player, 0, 200, 0, false)
			end
		end)
		
		
		hsatz = mysql_fetch_assoc ( result )
		index = index + 1
		end
		
		mysql_free_result ( result )
		totalHaeuser = index - 1
		outputDebugString ( ( index - 1 ).." Haeuser erstellt!" )
	end
end
setTimer ( createHaeuser, 1500, 1 )

addEvent("onHouseSysAuszahl", true)
addEventHandler("onHouseSysAuszahl", getRootElement(),
function(id, text)
	if not(id) then return end
	local result = mysql_query(handler, "SELECT * FROM haus WHERE ID = \'"..id.."\';")
	local dollar = 0
	if(result) and (mysql_num_rows( result ) > 0) then
		local row = mysql_fetch_assoc(result)
		local geld = row['KASSE']
		if(tonumber(text) > tonumber(geld)) then outputChatBox("Es ist nicht soviel Vorhanden!", source, 200, 0, 0, false) return end
		local shit = mysql_query(handler,"UPDATE haus SET KASSE = '"..(geld-text).."' WHERE ID = '"..id.."'")
		if(shit) then
			setElementData(source, "ms.birnen", tonumber(getElementData(source, "ms.birnen"))+text)
			outputChatBox("Du hast Erfolgreich "..text.." Birnen Ausgezahlt!", source, 0, 200, 0, false)
			triggerEvent("onHouseDataNeed", source, id)

		else
			outputChatBox("Fehler beim Auszahlen!", source, 200, 0, 0, false)
		end
	end
end)

addEvent("onHouseSysEinzahl", true)
addEventHandler("onHouseSysEinzahl", getRootElement(),
function(id, text)
	local result = mysql_query(handler, "SELECT * FROM haus WHERE ID = \'"..id.."\';")
	local dollar = 0
	if(result) and (mysql_num_rows( result ) > 0) then
		local row = mysql_fetch_assoc(result)
		local shit = mysql_query(handler,"UPDATE haus SET KASSE = '"..(text+row['KASSE']).."' WHERE ID = '"..id.."'")
		if(shit) then
			setElementData(source, "ms.birnen", tonumber(getElementData(source, "ms.birnen"))-text)
			outputChatBox("Du hast Erfolgreich "..text.." Birnen Eingezahlt!", source, 0, 200, 0, false)
			triggerEvent("onHouseDataNeed", source, id)
		else
			outputChatBox("Fehler beim Einzahlen!", source, 200, 0, 0, false)
		end
	end
end)

addEvent("onHouseDataNeed", true)
addEventHandler("onHouseDataNeed", getRootElement(),
function(id)
	local result = mysql_query(handler, "SELECT * FROM haus WHERE ID = \'"..id.."\';")
	local dollar = 0
	if(result) and (mysql_num_rows( result ) > 0) then
		local row = mysql_fetch_assoc(result)
		triggerClientEvent(source, "onHouseDataNeedBack", source, row['KASSE'])
	end
end)

addEvent("onHausSystemCreateHaus", true)
addEventHandler("onHausSystemCreateHaus", getRootElement(),
function(x, y, z, int, intx, inty, intz, preis, typ)
outputChatBox(x..", "..y..", "..z..", "..int..", "..intx..", "..inty..", "..intz..", "..preis..", "..typ)
	local query = "INSERT INTO haus ( PREIS, X, Y, Z, INTERIOR, INTX, INTY, INTZ, TYP, LOCKED, KASSE ) VALUES ( '"..preis.."', '"..x.."', '"..y.."', '"..z.."', '"..int.."', '"..intx.."', '"..inty.."', '"..intz.."', '"..typ.."', '0', '0')"
	local result = mysql_query( handler, query )
	if(result) then	
		outputChatBox("Haus Erfolgreich erstellt!", source, 0, 200, 0, false)
		local pickup = createPickup(x, y, z, 3, 1273, 1000)
		addEventHandler("onPickupUse", pickup, function(hitElement) outputChatBox("Dieses Haus wird nach einem Serverrestart vorhanden sein.", hitElement, 0, 255, 0, false) end)
	else
		outputChatBox("Fehler beim Erstellen des Hauses!", source, 0, 200, 0, false)
	end

end)
addCommandHandler("sellhouse", 
function(thePlayer)
	local query = "SELECT * FROM haus WHERE BESITZER = \'"..getPlayerName(thePlayer).."\';"
	local result = mysql_query( handler, query )
	if(result ) and (mysql_num_rows( result ) > 0)	then
		local row = mysql_fetch_assoc(result)
		local shit = mysql_query(handler,"UPDATE haus SET BESITZER = 'staat' WHERE ID = '"..row['ID'].."'")
		if(shit) then
			outputChatBox("Du hast dein Haus erfolgreich verkauft. Das Geld wurde dir auf dein Konto ueberwiesen.", thePlayer, 0, 200, 0, false)
			for index, col in pairs(getElementsByType("colshape")) do
				if(getElementData(col, "HAUS") == true) and (getElementData(col, "HBESITZER") == getPlayerName(thePlayer)) then
					setElementData(col, "HBESITZER", "staat")
					setElementData(col, "HLOCKED", 0)
					setElementData(col, "HMIETEND", 0)
					mysql_query(handler,"UPDATE haus SET LOCKED = '0' WHERE ID = '"..row['ID'].."'")
					mysql_query(handler,"UPDATE haus SET VERMIETEN = '0' WHERE ID = '"..row['ID'].."'")
					givePlayerItem(thePlayer, "ms.birnen", getElementData(col, "HPREIS"))

				end
			end
		else
			outputChatBox("Fehler beim Verkaufen des Hauses!", thePlayer, 200, 0, 0, false)
		end
	else
		outputChatBox("Du hast kein Haus!", thePlayer, 200, 0, 0, false)
	end
end)

addCommandHandler("destroyhouse", 
function(thePlayer)
	if(tonumber(getElementData(thePlayer, "ms.adminlevel")) < 4) then outputChatBox("Du bist nicht Befugt.", thePlayer, 200, 0, 0, false) return end
	for index, col in pairs(getElementsByType("colshape")) do
			if(isElementWithinColShape(thePlayer, col) == true) then
				if(getElementData(col, "HAUS") == true) then
					local id = getElementData(col, "HID")
					local result = mysql_query(handler, "DELETE FROM haus WHERE ID = '"..id.."';")
					if(result) then
						setElementData(col, "HAUS", false)
						removeElementData(col, "HID")
						removeElementData(col, "HLOCKED")
						removeElementData(col, "HBESITZER")
						removeElementData(col, "HMIETER")
						removeElementData(col, "HINTX")
						removeElementData(col, "HINTY")
						removeElementData(col, "HINTZ")
						removeElementData(col, "HMIETEND")
						removeElementData(col, "HPREIS")
						destroyElement(getElementData(col, "HPICKUP"))
						destroyElement(getElementData(col, "HBLIP"))
						destroyElement(col)
						outputChatBox("Haus '"..id.."' wurde erfolgreich entfernt.", thePlayer, 0, 200, 0, false)
					else
						outputChatBox("Fehler beim Loeschen des Hauses!", thePlayer, 200, 0, 0, false)
					end
				end
			end
	end
end)

addCommandHandler("buyhouse", 
function(thePlayer)
	local query = "SELECT * FROM haus WHERE BESITZER = \'"..getPlayerName(thePlayer).."\';"
	local result = mysql_query( handler, query )
	if(result ) and (mysql_num_rows( result ) > 0)then outputChatBox("Du hast bereits ein Haus.", thePlayer, 200, 0, 0, false) return end
	if(isPlayerEingemietet(thePlayer) == false) then else outputChatBox("Du bist bei jemanden eingemietet!", thePlayer, 200, 0, 0, false) return end
		for index, col in pairs(getElementsByType("colshape")) do
			if(isElementWithinColShape(thePlayer, col) == true) then
				if(getElementData(col, "HAUS") == true) then
					local owner = getElementData(col, "HBESITZER")
					if(owner ~= "staat") then outputChatBox("Dieses Haus ist bereits gekauft!", thePlayer, 200, 0, 0, false) return end
					local preis = tonumber(getElementData(col, "HPREIS"))
					local hgeld = tonumber(getElementData(thePlayer, "ms.birnen"))
					if(hgeld < preis) then outputChatBox("Du kannst dir dieses Haus nicht leisten. Es fehlen dir "..preis-hgeld.." Birnen.", thePlayer, 200, 0, 0, false) return end
					local shit = mysql_query(handler,"UPDATE haus SET BESITZER = '"..getPlayerName(thePlayer).."' WHERE ID = '"..getElementData(col, "HID").."'")
					if(shit) then
						outputChatBox("Du hast dir das Haus erfolgreich gekauft!", thePlayer, 0, 200, 0, false)
						outputChatBox("Du kannst es mit /enter Betreten, mit /leave verlassen. Nutze 'F5' Fuer das Hausmenue!(Du musst in dem Pfeil stehen.)", thePlayer, 0, 200, 0, false)
						setElementData(col, "HBESITZER", getPlayerName(thePlayer))
						setElementData(thePlayer, "ms.birnen", tonumber(getElementData(thePlayer, "ms.birnen")-preis))
						triggerClientEvent(thePlayer, "onMultistuntArchievementCheck", thePlayer, 2)
						givePlayerBadge(thePlayer, 2)
						local pickup = getElementData(col, "HPICKUP")
						local x, y, z = getElementPosition(pickup)
						destroyElement(pickup)
						local new = createPickup(x, y, z, 3, 1272, 500)
						setElementData(col, "HPICKUP", new)
					else
						outputChatBox("Fehler beim Kaufen des Hauses!", thePlayer, 200, 0, 0, false)
					end
				end
			end
		end
end)


addCommandHandler("mietable", 
function(thePlayer)
		for index, col in pairs(getElementsByType("colshape")) do
			if(isElementWithinColShape(thePlayer, col) == true) then
				if(getElementData(col, "HAUS") == true) then
					if(getElementData(col, "HBESITZER") ~= getPlayerName(thePlayer)) then outputChatBox("Dies ist nicht dein Haus!", thePlayer, 200, 0, 0, false) return end
					if(tonumber(getElementData(col, "HMIETEND")) == 0) then
						local shit = mysql_query(handler,"UPDATE haus SET VERMIETEN = '1' WHERE ID = '"..getElementData(col, "HID").."'")
						if(shit) then
							setElementData(col, "HMIETEND", 1)
							outputChatBox("Du hast dein Haus Zum Vermieten bestimmt.", thePlayer, 0, 200, 0, false)
						end
					else
						local shit = mysql_query(handler,"UPDATE haus SET VERMIETEN = '0' WHERE ID = '"..getElementData(col, "HID").."'")
						if(shit) then
							setElementData(col, "HMIETEND", 0)
							outputChatBox("Du hast dein Haus nicht mehr zum Vermieten bestimmt.", thePlayer, 0, 200, 0, false)
						end
					end
				end
			end
		end
end)

addCommandHandler("lock", 
function(thePlayer)
		for index, col in pairs(getElementsByType("colshape")) do
			if(isElementWithinColShape(thePlayer, col) == true) then
				if(getElementData(col, "HAUS") == true) then
					if(getElementData(col, "HBESITZER") ~= getPlayerName(thePlayer)) then outputChatBox("Dies ist nicht dein Haus!", thePlayer, 200, 0, 0, false) return end
					if(tonumber(getElementData(col, "HLOCKED")) == 0) then
						local shit = mysql_query(handler,"UPDATE haus SET LOCKED = '1' WHERE ID = '"..getElementData(col, "HID").."'")
						if(shit) then
							setElementData(col, "HLOCKED", 1)
							outputChatBox("Du hast dein Haus Abgeschlossen.", thePlayer, 0, 200, 0, false)
						end
					else
						local shit = mysql_query(handler,"UPDATE haus SET LOCKED = '0' WHERE ID = '"..getElementData(col, "HID").."'")
						if(shit) then
							setElementData(col, "HLOCKED", 0)
							outputChatBox("Du hast dein Haus Aufgeschlossen.", thePlayer, 0, 200, 0, false)
						end
					end
				end
			end
		end
end)

addCommandHandler("leave", 
function(thePlayer)
		for index, col in pairs(getElementsByType("colshape")) do
			if(isElementWithinColShape(thePlayer, col) == true) then
				if(getElementData(col, "HAUSCOL") == true) then
					if(getElementDimension(col) == getElementDimension(thePlayer)) then
					local x, y, z  = getElementData(col, "HX"), getElementData(col, "HY"), getElementData(col, "HZ") 
					setInPosition(thePlayer, x, y, z, 0)
					setElementDimension(thePlayer, 0)
					end
				end
			end
		end
end)

addCommandHandler("entmieten", 
function(thePlayer)
	local query = "SELECT * FROM haus WHERE BESITZER = \'"..getPlayerName(thePlayer).."\';"
	local result = mysql_query( handler, query )
	if(result ) and (mysql_num_rows( result ) > 0) then outputChatBox("Du hast ein Haus! Du kannst dich nicht Entmieten.", thePlayer, 200, 0, 0, false) return end
		for index, col in pairs(getElementsByType("colshape")) do
		if(isElementWithinColShape(thePlayer, col) == true) then
				
				local mieter = getElementData(col, "HMIETER")
				local me = getPlayerName(thePlayer)
				local mieter1 = gettok(mieter, 1, "|")
				local mieter2 = gettok(mieter, 2, "|")
				local mieter3 = gettok(mieter, 3, "|")
				local mieter4 = gettok(mieter, 4, "|")
				local mieter5 = gettok(mieter, 5, "|")
				
				
				if(mieter1 == me) or (mieter2 == me) or (mieter3 == me) or (mieter4 == me) or (mieter5 == me) then
					if(mieter1 == me) then mieter = "|-|"..mieter2.."|"..mieter3.."|"..mieter4.."|"..mieter5.."|"
					elseif(mieter2 == me) then mieter = "|"..mieter1.."|-|"..mieter3.."|"..mieter4.."|"..mieter5.."|"
					elseif(mieter3 == me) then mieter = "|"..mieter1.."|"..mieter2.."|-|"..mieter4.."|"..mieter5.."|"
					elseif(mieter4 == me) then mieter = "|"..mieter1.."|"..mieter2.."|"..mieter3.."|-|"..mieter5.."|"
					elseif(mieter5 == me) then mieter = "|"..mieter1.."|"..mieter2.."|"..mieter3.."|"..mieter4.."|-|" end
					local shit = mysql_query(handler,"UPDATE haus SET MIETER = '"..mieter.."' WHERE ID = '"..getElementData(col, "HID").."'")
					if(shit) then
						setElementData(col, "HMIETER", mieter)
						outputChatBox("Du hast dich erfolgreich ausgemietet.", thePlayer, 0, 200, 0, false)
					end
				else
					outputChatBox("Du bist hier nicht eingemietet!", thePlayer, 200, 0, 0, false)
				end
			end
				
			end
end
)

addCommandHandler("mieten", 
function(thePlayer)
	local query = "SELECT * FROM haus WHERE BESITZER = \'"..getPlayerName(thePlayer).."\';"
	local result = mysql_query( handler, query )
	if(result ) and (mysql_num_rows( result ) > 0)then outputChatBox("Du hast bereits ein Haus.", thePlayer, 200, 0, 0, false) return end
		for index, col in pairs(getElementsByType("colshape")) do
		if(getElementData(col, "HAUS") == true) then
			
			if(isElementWithinColShape(thePlayer, col) == true) then
				if(getElementData(col, "HBESITZER") == "staat") then outputChatBox("Du kannst dich hier nicht einmieten.", thePlayer, 200, 0, 0, false) return end
				if(getElementData(col, "HMIETEND") == 0) then outputChatBox("Dieses Haus ist nicht zu Vermieten.", thePlayer, 200, 0, 0, false) return end		
				for index, cola in pairs(getElementsByType("colshape")) do
				if(getElementData(cola, "HAUS") == true) then
						local mieter = getElementData(cola, "HMIETER")
						local me = getPlayerName(thePlayer)
						local mieter1 = gettok(mieter, 1, "|")
						local mieter2 = gettok(mieter, 2, "|")
						local mieter3 = gettok(mieter, 3, "|")
						local mieter4 = gettok(mieter, 4, "|")
						local mieter5 = gettok(mieter, 5, "|")
						if(mieter1 == me) or (mieter2 == me) or (mieter3 == me) or (mieter4 == me) or (mieter5 == me) then outputChatBox("Du bist Bereits in einem Haus eingemietet.", thePlayer, 200, 0, 0, false) return end
					end	
				end
				
				local mieter = getElementData(col, "HMIETER")
				local me = getPlayerName(thePlayer)
				local mieter1 = gettok(mieter, 1, "|")
				local mieter2 = gettok(mieter, 2, "|")
				local mieter3 = gettok(mieter, 3, "|")
				local mieter4 = gettok(mieter, 4, "|")
				local mieter5 = gettok(mieter, 5, "|")
				if(mieter1 ~= "-") then 
					if(mieter2 ~= "-") then
						if(mieter3 ~= "-") then
							if(mieter4 ~= "-") then
								if(mieter5 ~= "-") then
								outputChatBox("Dieses Haus ist Bereits voll besetzt.", thePlayer, 200, 0, 0, false) return end
							end
						end
					end
				end
	
				if(mieter5 == "-") then mieter5 = me
				elseif(mieter4 == "-") then mieter4 = me
				elseif(mieter3 == "-") then mieter3 = me
				elseif(mieter2 == "-") then mieter2 = me
				elseif(mieter1 == "-") then mieter1 = me end
				mieter = "|"..mieter1.."|"..mieter2.."|"..mieter3.."|"..mieter4.."|"..mieter5.."|"
				local shit = mysql_query(handler,"UPDATE haus SET MIETER = '"..mieter.."' WHERE ID = '"..getElementData(col, "HID").."'")
				if(shit) then
					outputChatBox("Du hast dich Erfolgreich eingemietet!", thePlayer, 0, 200, 0, false)
					setElementData(col, "HMIETER", mieter)
				else
					outputChatBox("Fehler beim Einmieten!", thePlayer, 0, 200, 0, false)
				end
				end
		
			end
		end
end)

addEvent("onMultistuntHouseBack", true)
addEventHandler("onMultistuntHouseBack", getRootElement(),
function(x, y, z)
	setElementInterior(source, 0)
	setElementPosition(source, x, y, z)
end)

addEvent("onHouseCreatePos", true)
addEventHandler("onHouseCreatePos", getRootElement(),
function(x, y, z, int)
setElementInterior(source, int)
setElementPosition(source, x, y, z)
end)

addCommandHandler("enter", 
function(thePlayer)
		for index, col in pairs(getElementsByType("colshape")) do
			if(isElementWithinColShape(thePlayer, col) == true) then
				if(getElementData(col, "HAUS") == true) then
					if(isPedInVehicle(thePlayer) == true) then return end
					if(getElementData(col, "HLOCKED") == 1) then
						
						if(getElementData(col, "HBESITZER") ~= getPlayerName(thePlayer)) then
								
								local mieter = getElementData(col, "HMIETER")
								local me = getPlayerName(thePlayer)
								local mieter1 = gettok(mieter, 1, "|")
								local mieter2 = gettok(mieter, 2, "|")
								local mieter3 = gettok(mieter, 3, "|")
								local mieter4 = gettok(mieter, 4, "|")
								local mieter5 = gettok(mieter, 5, "|")
								if(mieter1 == me) or (mieter2 == me) or (mieter3 == me) or (mieter4 == me) or (mieter5 == me) then outputChatBox("3")
								else
									
									outputChatBox("Dieses Haus ist abgeschlossen!", thePlayer, 200, 0, 0, false) 
								return end
	
						end 
					
					end
					
					local intx, inty, intz, int, dim = getElementData(col, "HINTX"), getElementData(col, "HINTY"), getElementData(col, "HINTZ"), getElementData(col, "HINT"), getElementData(col, "HID") 
					setInPosition(thePlayer, intx, inty, intz, int)
					setElementDimension(thePlayer, dim)
				end
			end
		end
end)


local fadeP = {}
function setInPosition(thePlayer, x, y, z, interior)
	if not(thePlayer) then return end
	if (getElementType(thePlayer) == "vehicle") then return end
	if not(x) or not(y) or not(z) then return end
	if not(interior) then interior = 0 end
	if(fadeP[thePlayer] == 1) then return end
	fadeP[thePlayer] = 1
	fadeCamera(thePlayer, false)
	setTimer(
		function()
		fadeP[thePlayer] = 0
		setElementPosition(thePlayer, x, y, z)
		setElementInterior(thePlayer, interior)
		fadeCamera(thePlayer, true)
		end, 1000, 1)
end

function isPlayerEingemietet(thePlayer, col)
	if not(col) then
	for index, cola in pairs(getElementsByType("colshape")) do
		if(getElementData(cola, "HAUS") == true) then
				local mieter = getElementData(cola, "HMIETER")
				local me = getPlayerName(thePlayer)
				local mieter1 = gettok(mieter, 1, "|")
				local mieter2 = gettok(mieter, 2, "|")
				local mieter3 = gettok(mieter, 3, "|")
				local mieter4 = gettok(mieter, 4, "|")
				local mieter5 = gettok(mieter, 5, "|")
				if(mieter1 == me) or (mieter2 == me) or (mieter3 == me) or (mieter4 == me) or (mieter5 == me) then return true else return false end
			end	
		end

	else
		
		if(getElementData(col, "HAUS") == true) then
				local mieter = getElementData(col, "HMIETER")
				local me = getPlayerName(thePlayer)
				local mieter1 = gettok(mieter, 1, "|")
				local mieter2 = gettok(mieter, 2, "|")
				local mieter3 = gettok(mieter, 3, "|")
				local mieter4 = gettok(mieter, 4, "|")
				local mieter5 = gettok(mieter, 5, "|")
				if(mieter1 == me) or (mieter2 == me) or (mieter3 == me) or (mieter4 == me) or (mieter5 == me) then return true else return false end
			end	
		end


return true end

addCommandHandler("hhelp",
function(thePlayer)
	outputChatBox("Hauscommands:", thePlayer, 0, 200, 200, false)
	outputChatBox("/enter -> Betreten, /leave -> Verlassen", thePlayer, 0, 200,0, false)
	outputChatBox("/lock -> Aufschliessen, /mieten -> Einmieten", thePlayer, 0, 200,0, false)
	outputChatBox("/entmieten -> Entmieten, /mietable -> Mietbar machen", thePlayer, 0, 200,0, false)
	outputChatBox("/buyhouse -> Haus kaufen, /sellhouse -> Haus verlassen", thePlayer, 0, 200,0, false)
end)