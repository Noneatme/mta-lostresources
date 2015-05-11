addEvent("onMultistuntBizCreate", true)
addEvent("onMultistuntBizDelete", true)
addEvent("onMultistuntBizBuy", true)
addEvent("onMultistuntBizSell", true)

local bizPaydayTime = 5
local bizWaitTime = 86400

local function saveBizData(biz)
	addEventHandler("onColShapeHit", biz, function(hitElement)
		if(getElementType(hitElement) == "player") then
			triggerClientEvent(hitElement, "onMultistuntBizEnter", hitElement, biz)
		end
	end)
	addEventHandler("onElementDataChange", biz, function(name, oldvalue)
		local newvalue = getElementData(source, name)
		local bizname = getElementData(source, "biz.name")
		if(name == "biz.einkommen") then
			mysql_query(handler, "UPDATE biz SET EINKOMMEN = '"..newvalue.."' WHERE NAME = '"..bizname.."';")
		elseif(name == "biz.besitzer") then
			mysql_query(handler, "UPDATE biz SET BESITZER = '"..newvalue.."' WHERE NAME = '"..bizname.."';")
		elseif(name == "biz.gekauft") then
			mysql_query(handler, "UPDATE biz SET GEKAUFT = '"..newvalue.."' WHERE NAME = '"..bizname.."';")
		end
	end)
end

local function biz_giveUserPayday()
	for index, biz in pairs(getElementsByType("colshape")) do
		if(getElementData(biz, "biz.state") == true) then
			local besitzer = getElementData(biz, "biz.besitzer")
			if(besitzer ~= "niemand") then
				if(getPlayerFromName(besitzer)) then
					local einkommen = tonumber(getElementData(biz, "biz.einkommen"))
					givePlayerItem(getPlayerFromName(besitzer), "ms.birnen", einkommen)
					outputChatBox("#FFFFFF[#00FFFFBIZ#FFFFFF] You got #00FFFF"..einkommen.." pears #FFFFFFfrom your business #00FF00"..getElementData(biz, "biz.name").."#FFFFFF!", getPlayerFromName(besitzer), 0, 0, 0, true)
				end
			end
		end
	end
end

addCommandHandler("checkbiz", biz_giveUserPayday)

local function createBizes()
	local result = mysql_query ( handler, "SELECT * FROM biz;" )
	local dsatz
	local bizes = 0
	if (result) then
	
		dsatz = mysql_fetch_assoc( result )
		while dsatz do
			bizes = bizes+1
			local x, y, z = dsatz['X'], dsatz['Y'], dsatz['Z']
			local biz = createColSphere(x, y, z+0.2, 1)
			local pickup = createPickup(x, y, z-0.6, 3, 1239, 1000)
			local blip = createBlip(x, y, z, 32, 2, 255, 0, 0, 255, 0, 500, getRootElement())
			setElementData(biz, "biz.pickup", pickup)
			setElementData(biz, "biz.blip", blip)
			setElementData(biz, "biz.state", true)
			setElementData(biz, "biz.name", dsatz['NAME'])
			setElementData(biz, "biz.id", dsatz['ID'])
			setElementData(biz, "biz.einkommen", dsatz['EINKOMMEN'])
			setElementData(biz, "biz.besitzer", dsatz['BESITZER'])
			setElementData(biz, "biz.gekauft", dsatz['GEKAUFT']) -- Timestamp unterschied: 86 400
			setElementData(biz, "biz.preis", dsatz['PREIS'])
			saveBizData(biz)
			dsatz = mysql_fetch_assoc ( result )
		end
		
		outputServerLog(bizes.." Business wurden erstellt.")
		setTimer(biz_giveUserPayday, bizPaydayTime*60*1000, 0)
	end
end

setTimer(createBizes, 1500, 1)
outputServerLog("Business werden Erstellt...")


addEventHandler("onMultistuntBizDelete", getRootElement(), function(id)
	local sucess = false
	for index, biz in pairs(getElementsByType("colshape")) do
		if(getElementData(biz, "biz.state") == true) then
			if(tonumber(getElementData(biz, "biz.id")) == id) then
				--DELETE FROM `dbs_multistunt`.`biz` WHERE `ID`='1';
				sucess = true
				local result = mysql_query(handler, "DELETE FROM biz WHERE ID = '"..id.."';")
				if(result) then
					destroyElement(getElementData(biz, "biz.pickup"))
					destroyElement(getElementData(biz, "biz.blip"))
					destroyElement(biz)
					outputChatBox("Biz sucessful deleted!", source, 0, 255, 0)
				else
					outputChatBox("Error!", source, 0, 255, 0)
				end
			end
		end
	end
	if(sucess == false) then
		outputChatBox("There is no business with the ID "..id.." !", source, 255, 0, 0)
	end
end)



addEventHandler("onMultistuntBizCreate", getRootElement(), function(x, y, z, einkommen, preis, name)
	local gekauft = getRealTime().timestamp
	local result = mysql_query(handler, "INSERT INTO biz ( X, Y, Z, NAME, EINKOMMEN, PREIS, GEKAUFT ) VALUES ( '"..x.."', '"..y.."', '"..z.."', '"..name.."', '"..einkommen.."', '"..preis.."', '"..gekauft.."' );")
	if(result) then
		outputChatBox("Biz sucessful created!.", source, 0, 255, 0)
	else
		outputChatBox("Error!", source, 255, 0, 0)
	end
end)

addEventHandler("onMultistuntBizBuy", getRootElement(), function(theBiz, preis)
	if(tonumber(getPlayerItem(source, "ms.birnen")) < preis) then sendInfoMessage("You need more pears!", source, "red") return end
	setElementData(theBiz, "biz.besitzer", getPlayerName(source))
	local suc = setElementData(theBiz, "biz.gekauft", getRealTime().timestamp)
	if(suc) then outputChatBox("You sucessfull purchased this business!", source, 0, 255, 0)
		givePlayerItem(source, "ms.birnen", -preis)
		triggerClientEvent(source, "onMultistuntBizGuiRefresh", source, theBiz)
		triggerClientEvent(source, "onMultistuntArchievementCheck", source, 1)
		givePlayerBadge(source, 3)
	else
		outputChatBox("Error!", source, 255, 0, 0)
	end
end)

addEventHandler("onMultistuntBizSell", getRootElement(), function(theBiz, preis)
	setElementData(theBiz, "biz.besitzer", "niemand")
	local suc = setElementData(theBiz, "biz.gekauft", getRealTime().timestamp-bizWaitTime)
	if(suc) then outputChatBox("You sucessfull sold your business!", source, 0, 255, 0)
		givePlayerItem(source, "ms.birnen", preis)
		triggerClientEvent(source, "onMultistuntBizGuiRefresh", source, theBiz)
	else
		outputChatBox("Error!", source, 255, 0, 0)
	end
end)


