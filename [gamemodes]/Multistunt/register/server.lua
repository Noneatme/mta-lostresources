
function savePlayerData(thePlayer)
	local source = thePlayer
	addEventHandler("onElementDataChange", source,
	function(data)
		local player = source
		if(data == "ms.adminlevel") then
			mysql_query(handler,"UPDATE accounts SET ADMINLEVEL = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "ms.money") then
			mysql_query(handler,"UPDATE accounts SET MONEY = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
			setPlayerMoney(source, getElementData(source, data))
		elseif(data == "ms.playtime") then
			mysql_query(handler,"UPDATE accounts SET PLAYTIME = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "ms.skin") then
			mysql_query(handler,"UPDATE accounts SET SKIN = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "ms.aepfel") then
			mysql_query(handler,"UPDATE accounts SET AEPFEL = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "ms.birnen") then
			mysql_query(handler,"UPDATE accounts SET BIRNEN = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "ms.bananen") then
			mysql_query(handler,"UPDATE accounts SET BANANEN = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "ms.kirschen") then
			mysql_query(handler,"UPDATE accounts SET KIRSCHEN = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "ms.tode") then
			mysql_query(handler,"UPDATE accounts SET TODE = '"..tonumber(getElementData(source, data)).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "ms.team") then
			mysql_query(handler,"UPDATE accounts SET TEAM = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
			-- Badges
		elseif(data == "ms.badge") then
			mysql_query(handler,"UPDATE badges SET WEARING = '"..tonumber(getElementData(source, data)).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "ms.badges") then
			mysql_query(handler,"UPDATE badges SET BID = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
			-- Settings
		elseif(data == "mss.godmode") then
			mysql_query(handler,"UPDATE settings SET GODMODE = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.speedboost") then
			mysql_query(handler,"UPDATE settings SET SPEEDBOOST = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.obstbar") then
			mysql_query(handler,"UPDATE settings SET OBSTBAR = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.fgodmode") then
			mysql_query(handler,"UPDATE settings SET FGODMODE = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.radar") then
			mysql_query(handler,"UPDATE settings SET RADAR = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.hud") then
			mysql_query(handler,"UPDATE settings SET HUD = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.chat") then
			mysql_query(handler,"UPDATE settings SET CHAT = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.nametags") then
			mysql_query(handler,"UPDATE settings SET NAMETAGS = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.realtime") then
			mysql_query(handler,"UPDATE settings SET REALTIME = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.speedboostfaktor") then
			mysql_query(handler,"UPDATE settings SET SPEEDBOOSTFAKTOR = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.lmb") then
			mysql_query(handler,"UPDATE settings SET LMB = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.rmb") then
			mysql_query(handler,"UPDATE settings SET RMB = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.scb.legend") then
			mysql_query(handler,"UPDATE settings SET SCB.LEGEND = '"..tonumber(getElementData(source, data)).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		elseif(data == "mss.slogan") then
			mysql_query(handler,"UPDATE settings SET SLOGAN = '"..getElementData(source, data).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
		end
		for i = 1, max_archievements, 1 do
			if(data == "msa."..i) then
				mysql_query(handler,"UPDATE archievements SET A"..i.." = '"..tonumber(getElementData(source, data)).."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."'")
			end
		end
	end)
end

addEvent("onAccountLogin", true)
addEventHandler("onAccountLogin", getRootElement(),
function(pw, autologin)
	local query
	if(autologin == true) then
		query = "SELECT * FROM accounts WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."' AND PASSWORD = '"..pw.."';"
	else
		query = "SELECT * FROM accounts WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."' AND PASSWORD = '"..md5(pw).."';"
	end
	
	local result = mysql_query( handler, query )
	if ( result and mysql_num_rows( result ) > 0) then
		triggerClientEvent(source, "onAccountLoginBack", source, true)
		fadeCamera(source, false, 1.0, 255, 255, 255)
		setTimer(fadeCamera, 1500, 1, source, true)
		setTimer(triggerEvent, 1500, 1, "onMultistuntSpawn", source)
		setTimer(setElementData, 1500, 1, source, "ms.eingeloggt", true)
		if(autologin ~= true) then
			outputChatBox("You sucessfull logged in!", source, 0, 255, 0)
		else
			outputChatBox("You sucessfull logged in! (Autologin)", source, 0, 255, 0)
		end
		local rowAccount = mysql_fetch_assoc(result)
		local rowSettings = mysql_fetch_assoc(mysql_query(handler, "SELECT * FROM settings WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."';"))
		local rowArchievements = mysql_fetch_assoc(mysql_query(handler, "SELECT * FROM archievements WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."';"))
		local rowBadge = mysql_fetch_assoc(mysql_query(handler, "SELECT * FROM badges WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."';"))
		-- 
		-- Account --
		setElementData(source, "ms.adminlevel", rowAccount['ADMINLEVEL'])
		setElementData(source, "ms.money", rowAccount['MONEY'])
		setElementData(source, "ms.playtime", rowAccount['PLAYTIME'])
		setElementData(source, "ms.skin", rowAccount['SKIN'])
		setElementData(source, "ms.aepfel", rowAccount['AEPFEL'])
		setElementData(source, "ms.birnen", rowAccount['BIRNEN'])
		setElementData(source, "ms.bananen", rowAccount['BANANEN'])
		setElementData(source, "ms.kirschen", rowAccount['KIRSCHEN'])
		setElementData(source, "ms.registerdatum", rowAccount['REGISTRIERDATUM'])
		setElementData(source, "ms.tode", rowAccount['TODE'])
		setElementData(source, "ms.team", rowAccount['TEAM'])
		setElementData(source, "ms.country", tonumber(rowAccount['LAND']))
		setElementData(source, "ms.badge", tonumber(rowBadge['WEARING']))
		setElementData(source, "ms.badges", rowBadge['BID'])
		setElementModel(source, getElementData(source, "ms.skin"))
		--
		-- Settings --
		setElementData(source, "mss.godmode", tonumber(rowSettings['GODMODE']))
		setElementData(source, "mss.speedboost", tonumber(rowSettings['SPEEDBOOST']))
		setElementData(source, "mss.obstbar", tonumber(rowSettings['OBSTBAR']))
		setElementData(source, "mss.fgodmode", tonumber(rowSettings['FGODMODE']))
		setElementData(source, "mss.radar", tonumber(rowSettings['RADAR']))
		setElementData(source, "mss.hud", tonumber(rowSettings['HUD']))
		setElementData(source, "mss.chat", tonumber(rowSettings['CHAT']))
		setElementData(source, "mss.nametags", tonumber(rowSettings['NAMETAGS']))
		setElementData(source, "mss.realtime", tonumber(rowSettings['REALTIME']))
		setElementData(source, "mss.speedboostfaktor", tonumber(rowSettings['SPEEDBOOSTFAKTOR']))
		setElementData(source, "mss.lmb", tonumber(rowSettings['LMB']))
		setElementData(source, "mss.rmb", tonumber(rowSettings['RMB']))
		setElementData(source, "mss.scb.legend", tonumber(rowSettings['SCB.LEGEND']))
		setElementData(source, "mss.slogan", rowSettings['SLOGAN'])
		-- Archievements --
		for i = 1, max_archievements, 1 do
			setElementData(source, "msa."..i, tonumber(rowArchievements['A'..i..'']))
		end
		savePlayerData(source)
	else
		triggerClientEvent(source, "onAccountLoginBack", source, false)
		triggerClientEvent(source, "showLoginCursor", source)
		outputChatBox("Error: Your account don't exist or you typed in a wrong password!", source, 255, 0, 0 )
	end
	mysql_free_result(result)
end)

addEvent("onMultistuntRegisterAutologin", true)
addEventHandler("onMultistuntRegisterAutologin", getRootElement(),
function()
	local query = "SELECT * FROM accounts WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."';"
	local result = mysql_query( handler, query )
	if ( result and mysql_num_rows( result ) > 0) then
		local rowAccount = mysql_fetch_assoc(result)
		local ip = rowAccount['IP']
		local ip2 = getPlayerIP(source)
		local serial = rowAccount['SERIAL']
		local serial2 = getPlayerSerial(source)
		
		if(ip == ip2) and (serial == serial2) then
			triggerEvent("onAccountLogin", source, rowAccount['PASSWORD'], true)
		else
			outputChatBox("Auto-login error! Serial/IP mismatcht!", source, 255, 0, 0)
		end
	else
		outputChatBox("Auto-login error! Account don't exist.", source, 255, 0, 0 )
	end
	mysql_free_result(result)
end)

addEvent("onLoginDataNeed", true)
addEventHandler("onLoginDataNeed", getRootElement(),
function()
	fadeCamera(source, true)
	local query = "SELECT * FROM accounts WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."';"
	local result = mysql_query( handler, query )
	if ( result) and (mysql_num_rows( result ) > 0) then
		triggerClientEvent(source, "onLoginDataNeedBack", source, true)
		mysql_free_result(result)
	else
		triggerClientEvent(source, "onLoginDataNeedBack", source, false)
	end
	
end)

addEvent("onAccountRegister", true)
addEventHandler("onAccountRegister", getRootElement(),
function(alter, passwort, geschlecht, land)
	if(alter) and (passwort) and (geschlecht) and (land) then
		local name = getPlayerName(source)
		local ip = getPlayerIP(source)
		local serial = getPlayerSerial(source)
		local newpasswort = md5(passwort)
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		local datum = day.."."..month.."."..year.." "..hour..":"..minute
		local query = "INSERT INTO accounts ( NAME, PASSWORD, IP, SERIAL, AGE, GESCHLECHT, LAND, REGISTERDATUM ) VALUES ( '"..mysql_escape_string(handler, getPlayerName(source)).."', '"..newpasswort.."', '"..ip.."', '"..serial.."', '"..alter.."', '"..geschlecht.."', '"..land.."', '"..datum.."' )"
		local result = mysql_query( handler, query )
		if(result) then
			outputChatBox("You sucessfull registered! Please log-in now.", source, 0, 255, 0, false)
			triggerClientEvent(source, "showLoginCursor", source)
			triggerEvent("onLoginDataNeed", source)
			mysql_free_result(result)
			local query2 = mysql_query(handler, "INSERT INTO settings ( NAME ) VALUES ( '"..mysql_escape_string(handler, getPlayerName(source)).."' )")
			mysql_free_result(query2)
			local query3 = mysql_query(handler, "INSERT INTO archievements ( NAME ) VALUES ( '"..mysql_escape_string(handler, getPlayerName(source)).."' )")
			mysql_free_result(query3)
			local query4 = mysql_query(handler, "INSERT INTO badges ( NAME ) VALUES ( '"..mysql_escape_string(handler, getPlayerName(source)).."' )")
			mysql_free_result(query4)
		else
			outputChatBox("Error!", source, 255, 0, 0, false)
			triggerClientEvent(source, "showLoginCursor", source)
		end
	end
end)
--[[
-- MYSQL SETUP --
local sql = mysql_connect('localhost', 'root', '', 'larsowitsh')
if not sql then outputDebugString('Cant Connect to MYSQL Server!') else outputDebugString('MYSQL: Connected!') end

-- Events
addEvent('onAdminSavePickup', true)

-- Functions
addCommandHandler('createpickup', 
function(thePlayer)
local Acc = getAccountName(getPlayerAccount(thePlayer))
	if isObjectInACLGroup('user.'..Acc, aclGetGroup("Admin")) then
		triggerClientEvent(thePlayer, 'onAdminRequestPanel', thePlayer, thePlayer)
	end
end)

addEventHandler('onAdminSavePickup', getRootElement(),
function( X, Y, Z , ID, GELD, CREATOR, gMe)
local result = mysql_query(sql,"INSERT INTO pickups (CREATOR, X,Y,Z, MODEL, GELD) VALUES ('"..CREATOR.."','"..X.."','"..Y.."','"..Z.."','"..ID.."','"..GELD.."');")
	if result then
		outputChatBox('Das Pickup wird beim naechsten Server Restart benutzbar sein!', gMe,0,125,0,false)
		triggerClientEvent(gMe, 'onAdminPickupSaved', gMe)
	end
end)

addEventHandler('onResourceStart',getResourceRootElement(getThisResource()),
function()
local result = mysql_query ( sql, "SELECT * FROM pickups;" )
local dsatz
local Anzahl = 0
    if (result) then
        dsatz = mysql_fetch_assoc( result )
        while dsatz do
            local x, y, z = dsatz['X'], dsatz['Y'], dsatz['Z']
			local geld = dsatz['GELD']
			local model = dsatz['MODEL']
			local Creator = dsatz['CREATOR']
			local SelfmadeGeldPickUp = createPickup(x,y,z, 3, model)
			setElementData(SelfmadeGeldPickUp, 'GELD', geld)
			setElementData(SelfmadeGeldPickUp, 'CREATOR', Creator)
			Anzahl = tonumber(Anzahl) + 1
            dsatz = mysql_fetch_assoc(result)
			addEventHandler('onPickupHit', SelfMadeGeldPickUp,
				function(thePlayer)
					if(getElementType(thePlayer) ~= "player") then return end
					givePlayerMoney(thePlayer, getElementData(source,'GELD'))
					outputChatBox('Du hast einen versteckten Aktenkoffer gefunden!', thePlayer,125,125,0,false)
					destroyElement(SelfmadeGeldPickUp)
				end)
        end
		outputDebugString("Es wurden "..tonumber(Anzahl).." Pickups erstellt")
    end
end)
--]]