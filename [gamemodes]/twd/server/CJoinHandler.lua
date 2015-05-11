-- #######################################
-- ## Project:MTA:The Walking Death		##
-- ## Name: JoinHandler					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

JoinHandler = {};
JoinHandler.__index = JoinHandler;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function JoinHandler:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// JoinPlayer	 		//////
-- ///////////////////////////////

function JoinHandler:JoinPlayer(player)
	if(isElement(player)) then
		if(antiInjection:CheckString(getPlayerName(player)) == true) then
			cancelEvent(true, "This name is blocked.\n(Injection warning)\nPlease use another name.");
			if (isElement(player)) then
				kickPlayer(player);
			end
			return
		end
		enew(player, Player);
	end
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function JoinHandler:Constructor(...)
	self.joinFunc = function(...) self:JoinPlayer(...) end;

	for index, player in pairs(getElementsByType("player")) do
		self:JoinPlayer(player);
	end

	addEventHandler("onPlayerJoin", getRootElement(), self.joinFunc);
	
	logger:OutputInfo("[CALLING] JoinHandler: Constructor");
end

-- EVENT HANDLER --
