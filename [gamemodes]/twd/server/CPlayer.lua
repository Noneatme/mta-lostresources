-- #######################################
-- ## Project:MTA:The Walking Death		##
-- ## Name: CPlayer						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################
-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Player = {};
Player.__index = Player;

-- ///////////////////////////////
-- ///// GETTERS & SETTERS  //////
-- ///////////////////////////////
-- ///////////////////////////////
-- ///// GETTERS & SETTERS  //////
-- ///////////////////////////////



-- ///////////////////////////////
-- ///// getIP          	//////
-- ///////////////////////////////

function Player:GetIP()
	return getPlayerIP(self);
end


-- ///////////////////////////////
-- ///// getSerial         	//////
-- ///////////////////////////////

function Player:GetSerial()
	return getPlayerSerial(self);
end

-- ///////////////////////////////
-- ///// getName         	//////
-- ///////////////////////////////

function Player:GetName()
	return (self:GetData("account", "Callsign") or getPlayerName(self));
end

-- ///////////////////////////////
-- ///// getPing         	//////
-- ///////////////////////////////

function Player:GetPing()
	return getPlayerPing(self);
end

-- ///////////////////////////////
-- ///// getVehicle         //////
-- ///////////////////////////////

function Player:GetVehicle()
	return getPedOccupiedVehicle(self);
end

-- ///////////////////////////////
-- ///// getEXP         	//////
-- ///////////////////////////////

function Player:GetEXP()
	return tonumber(self:GetData("account", "EXP"));
end

-- ///////////////////////////////
-- ///// GivePatronen      	//////
-- ///////////////////////////////

function Player:GivePatronen(anzahl)
	return self:SetData("account", "Patronen", tonumber(self:GetData("account", "Patronen"))+(anzahl or 0))
end


-- ///////////////////////////////
-- ///// RemovePatronen     //////
-- ///////////////////////////////

function Player:RemovePatronen(anzahl)
	local pat = tonumber(self:GetData("account", "Patronen"))
	
	if(pat-anzahl >= 0) then
		return self:SetData("account", "Patronen", 0)		
		
	else
		return self:SetData("account", "Patronen", tonumber(self:GetData("account", "Patronen"))-(anzahl or 0))		
	end
end

-- ///////////////////////////////
-- ///// getLevel        	//////
-- ///////////////////////////////

function Player:GetLevel()
	return tonumber(self:GetData("account", "Level"));
end

-- ///////////////////////////////
-- ///// addEXP	        	//////
-- ///////////////////////////////

function Player:AddEXP(exp)
	return expManager:AddPlayerEXP(self, exp);
end

-- ///////////////////////////////
-- ///// addHealth	        //////
-- ///////////////////////////////


function Player:AddHealth(health)
	local leben = getElementHealth(self)
	local newleben;
	
	if(leben+health > 100) then
		newleben = 100;
	else
		newleben = leben+health;
	end

	return setElementHealth(self, newleben);
end


-- ///////////////////////////////
-- ///// LevelUp        	//////
-- ///////////////////////////////

function Player:LevelUp()
	local level = self:GetLevel()
	return self:SetData("account", "Level", level+1);
end

-- ///////////////////////////////
-- ///// getPos				//////
-- ///////////////////////////////

function Player:GetPos()
	return gtElementPosition(self);
end

-- ///////////////////////////////
-- ///// setPos				//////
-- ///////////////////////////////

function Player:SetPos(...)
	return setElementPosition(self, ...);
end

-- ///////////////////////////////
-- ///// setInt				//////
-- ///////////////////////////////

function Player:SetInt(...)
	return setElementInterior(self, ...);
end

-- ///////////////////////////////
-- ///// getInt				//////
-- ///////////////////////////////

function Player:GetInt()
	return getElementInterior(self);
end

-- ///////////////////////////////
-- ///// setDim				//////
-- ///////////////////////////////

function Player:SetDim(...)
	return setElementDimension(self, ...);
end

-- ///////////////////////////////
-- ///// getDim				//////
-- ///////////////////////////////

function Player:GetDim()
	return getElementDimension(self);
end

-- ///////////////////////////////
-- ///// getEMail	    	//////
-- ///////////////////////////////

function Player:GetEMail()
	assert(self["ElementTree"] ~= nil);
	return self:GetData("account", "EMail");
end

-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////
-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////



-- ///////////////////////////////
-- ///// WarpInto         	//////
-- ///////////////////////////////

function Player:WarpInto(vehicle, ...)
	self.vehicle = vehicle
	return warpPedIntoVehicle(self, vehicle, ...);
end

-- ///////////////////////////////
-- ///// TriggerEvent       //////
-- ///////////////////////////////

function Player:TriggerEvent(eventname, ...)
	return triggerClientEvent(self, eventname, self, ...);
end

-- ///////////////////////////////
-- ///// ShowMessageBox 	//////
-- ///////////////////////////////

function Player:ShowMessageBox(...)
	return self:TriggerEvent("Player:ShowMessageBox", ...);
end

-- ///////////////////////////////
-- ///// spawn         	//////
-- ///////////////////////////////

function Player:Spawn(...)
	return spawnPlayer(self, ...);
end


-- ///////////////////////////////
-- ///// UpdateInv         	//////
-- ///////////////////////////////

function Player:UpdateInv()
	local tblInventarResult = connectionManager:Query("SELECT * FROM tblinventory WHERE EMail = '"..self:GetEMail().."';", true);
	
	self:SetData("account", "inventoryResult", tblInventarResult, true)

end

-- ///////////////////////////////
-- ///// GiveItem         	//////
-- ///////////////////////////////

function Player:GiveItem(id, anzahl)
	if(id and anzahl) then
		for i = 1, anzahl, 1 do
			connectionManager:Query("INSERT INTO tblinventory(EMail, ID) VALUES ('"..self:GetEMail().."', "..id..");", true);
		end
		
		self:UpdateInv()
	end
end


-- ///////////////////////////////
-- ///// RemoveItem        	//////
-- ///////////////////////////////

function Player:RemoveItem(id, anzahl)
	if not(anzahl) then
		anzahl = 1
	end

	if(id) then
		connectionManager:Query("DELETE FROM tblinventory WHERE EMail = '"..self:GetEMail().."' AND ID = "..id.." LIMIT "..anzahl..";", true);
	end
	self:UpdateInv();
end


-- ///////////////////////////////
-- ///// ElementTree    	//////
-- ///////////////////////////////

function Player:NewElementTree()
	if(self["ElementTree"]) then
		for index, data in pairs(self["ElementTree"]) do
			setElementData(self, index, nil);
		end
	end
	self["ElementTree"] = {};
	logger:OutputInfo("Element Tree for player: "..self:GetName().." deleted");
end


-- ///////////////////////////////
-- ///// SaveData	    	//////
-- ///////////////////////////////

function Player:SaveData(typ, index, key)
	if(typ == "account") then
		connectionManager:Query("UPDATE tblaccounts SET "..index.." = '"..key.."' WHERE EMail = '"..self:GetEMail().."';", true)
	elseif(typ == "savedthings") then
		connectionManager:Query("UPDATE tblsavedthings SET "..index.." = '"..key.."' WHERE EMail = '"..self:GetEMail().."';", true)
	end
end

-- ///////////////////////////////
-- ///// SetData	    	//////
-- ///////////////////////////////

function Player:SetData(typ, index, key, doNotSave)
	assert(self["ElementTree"] ~= nil);
	if(typ) then
		typ = string.lower(typ);
		if not(self["ElementTree"][typ]) then
			self["ElementTree"][typ] = {};
		end
		self["ElementTree"][typ][index] = key;
		setElementData(self, typ..":"..index, key);
		if(doNotSave ~= true) then
			self:SaveData(typ, index, key);
		end
	else
		self["ElementTree"][index] = key;
		setElementData(self, index, key);
	end
end

-- ///////////////////////////////
-- ///// GetData	    	//////
-- ///////////////////////////////

function Player:GetData(typ, index)
	if not(self["ElementTree"]) then
		return false;
	end
	if(typ) then
		typ = string.lower(typ);
		if not(self["ElementTree"][typ]) then
			self["ElementTree"][typ] = {};
		end
		return self["ElementTree"][typ][index];
	else
		return self["ElementTree"][index];
	end
end

-- ///////////////////////////////
-- ///// IsLoggedIn     	//////
-- ///////////////////////////////

function Player:IsLoggedIn()
	if(self:GetData(nil, "loggedIn") == true) then
		return true;
	else
		return false;
	end
end

-- ///////////////////////////////
-- ///// LogIn		     	//////
-- ///////////////////////////////

function Player:LogIn(accountResult, savedResult, inventoryResult)
	-- RESULT SET --
	for key, value in pairs(accountResult) do
		if(key ~= 'Password') then
			self:SetData("account", key, value, true);
		end
	end	
	
	for key, value in pairs(savedResult) do
		self:SetData("savedthings", key, value, true);
	end	
	
	self:SetData(nil, "loggedIn", true)
	self:SetData("account", "inventoryResult", inventoryResult, true);
	
	setPlayerName(self, self:GetData("account", "Callsign"));
	
	setTimer(function()
		spawnManager:SpawnPlayerLogin(self);
	end, 1000, 1)
	return true;
end

-- ///////////////////////////////
-- ///// ShowLicense		//////
-- ///////////////////////////////

function Player:ShowLicense()
	return self:ShowMessageBox("Information", "Server license:\n\n"..(fromJSON(_G["g_serverLicense"]) or "not available(!)"), "Okay");
end


-- ///////////////////////////////
-- ///// onWasted			//////
-- ///////////////////////////////

function Player:OnWasted()
	setTimer(function()
		spawnManager:SpawnPlayerLogin(self);
	end, 5000, 1)
end

-- ///////////////////////////////
-- ///// UseInvItem			//////
-- ///////////////////////////////

function Player:UseInvItem(id, name, serveritem, permanent, table)
	if not(permanent) then
		self:RemoveItem(id, 1);
	end
	

	if(serveritem) then
		if(name == "Beans") or (name == "Burger") or (name == "Chips") then
			self:AddHealth(table[id][4]);
		end
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Player:constructor()
	self["ElementTree"] = {};
	logger:OutputInfo("[CALLING] Player: Constructor");

	self.showLicenseFunc = function(...) self:ShowLicense(...); end
	self.kickMeFunc = function(...) kickPlayer(self, "Your resolution is too low for this server.\n\nPlease buy a flatscreen or die."); end
	self.wastedFunc = function() self:OnWasted() end;
	self.useInvFunc = function(...) self:UseInvItem(...) end;

	addEvent("Player:ShowLicense", true);
	addEvent("Player:KickMeResolution", true);
	addEvent("Inventory:UseItem", true);
	
	addEventHandler("Player:ShowLicense", self, self.showLicenseFunc);
	addEventHandler("Player:KickMeResolution", self, self.kickMeFunc);
	addEventHandler("Inventory:UseItem", self, self.useInvFunc);
	
	addEventHandler("onPlayerWasted", self, self.wastedFunc);

end

-- ///////////////////////////////
-- ///// destructor 		//////
-- ///////////////////////////////

function Player:destructor()

	if(self:IsLoggedIn()) then
		local x, y, z = getElementPosition(self);
		local int = getElementInterior(self);
		
		self:SetData("savedthings", "X", x);
		self:SetData("savedthings", "Y", y);
		self:SetData("savedthings", "Z", z);
		self:SetData("savedthings", "INTERIOR", int);
		
		self:SetData("savedthings", "HEALTH", math.floor(getElementHealth(self)));
		self:SetData("savedthings", "ARMOR", math.floor(getPedArmor(self)));
		
		local savedString = ""
		for i = 1, 12, 1 do
			local wep = getPedWeapon(self, i);
			
			savedString = savedString.."|"..wep..":"..getPedTotalAmmo(self, i)
			
		end
		
		savedString = savedString.."|"
		
	
		self:SetData("savedthings", "WEAPONS", savedString);
	end
end

-- EVENT HANDLER --
registerElementClass("player", Player);
