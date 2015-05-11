-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: CPlayer.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Player = {};
Player.__index = Player;

-- Events

addEvent("onPlayerDownloaded", true)

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

function Player:SetDimension(...)
	return setElementDimension(self, ...);
end

-- ///////////////////////////////
-- ///// getDim				//////
-- ///////////////////////////////

function Player:GetDimension()
	return getElementDimension(self);
end

-- ///////////////////////////////
-- ///// getDim				//////
-- ///////////////////////////////

function Player:GetLanguage()
	return strings;
end


-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////
-- ///////////////////////////////
-- ///// FUNKTIONEN        	//////
-- ///////////////////////////////

function Player:ShowMessageBox(...)
	return triggerClientEvent(self, "Player:ShowMessageBox", self, ...)
end


-- ///////////////////////////////
-- ///// LoadMapData       	//////
-- ///////////////////////////////

function Player:LoadMapData(sMap)
	return triggerClientEvent(self, "onClientPlayerMapDataLoad", self, (self.mapData[sMap] or {}))
end

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
-- ///// spawn         		//////
-- ///////////////////////////////


function Player:Spawn(...)
 
	return spawnPlayer(self, ...);
end

-- ///////////////////////////////
-- ///// OnPlayerDownloaded	//////
-- ///////////////////////////////

function Player:OnPlayerDownloaded()
	self:Spawn(0, 0, 3)
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Player:constructor()
	-- Instanzen
	self["ElementTree"] = {};

	-- Funktionen
	self.onPlayerDownloadedFunc = bind(Player.OnPlayerDownloaded, self);
	
	-- Events
	
	addEventHandler("onPlayerDownloaded", self, self.onPlayerDownloadedFunc);
end

-- ///////////////////////////////
-- ///// destructor 		//////
-- ///////////////////////////////

function Player:destructor()

end

-- EVENT HANDLER --
registerElementClass("player", Player);
