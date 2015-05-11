-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: RenderVersion.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RenderVersion = {};
RenderVersion.__index = RenderVersion;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function RenderVersion:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function RenderVersion:Render()
	dxDrawText("Prophunt "..self.version, 1414/g.aesx*g.sx, 865/g.aesy*g.sy, 1594/g.aesx*g.sx, 890/g.aesy*g.sy, tocolor(255, 255, 255, 122), (1/(g.aesx+g.aesy))*(g.sx+g.sy), "default", "right", "center", false, false, true, false, false)
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function RenderVersion:Constructor(...)
	-- Instanzen
	self.version = "0.1 Alpha";
	
	-- Funktionen
	self.renderFunc = bind(self.Render, self);
	
	-- Events
	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	outputDebugString("[CALLING] RenderVersion: Constructor");
end

-- EVENT HANDLER --
