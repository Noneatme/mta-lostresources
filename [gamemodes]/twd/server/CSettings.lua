-- #######################################
-- ## Project:MTA:The Walking Death		##
-- ## Name: Settings						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Settings = {};
Settings.__index = Settings;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function Settings:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// License 			//////
-- ///////////////////////////////

function Settings:ShowLicense(player)

end

-- ///////////////////////////////
-- ///// Stop 				//////
-- ///////////////////////////////

function Settings:Stop()
	for index, p in pairs(getElementsByType("player")) do
		p:destructor()
	end
end

-- ///////////////////////////////
-- ///// OverwriteFunctions	//////
-- ///////////////////////////////

function Settings:OverwriteFunctions()

	
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Settings:Constructor(...)
	setFPSLimit(60);
	setGravity(0.0049);
	
	self.stopFunc = function() self:Stop() end;
	logger:OutputInfo("[CALLING] Settings: Constructor");
	
	addCommandHandler("license", function(...) self:ShowLicense(...) end);
	addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), self.stopFunc)
	
	addCommandHandler("giveitem", function(player, id)
		player:GiveItem(id, 1)
	end)
	
	
	self:OverwriteFunctions();
end

-- EVENT HANDLER --

local _outputChatBox = outputChatBox

function outputChatBox(text, player, r, g, b, channel)
	_outputChatBox(text, player, r, g, b)

	if(isElement(player)) then

		return triggerClientEvent(player, "ChatBox:SendTextBack", player, (channel or "System"), text, r, g, b);
	
	end
end
