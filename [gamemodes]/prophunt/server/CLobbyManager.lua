-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: LobbyManager.lua			##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

LobbyManager = {};
LobbyManager.__index = LobbyManager;

addEvent("onPlayerLobbyCreate", true)

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function LobbyManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// AddLobby	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function LobbyManager:AddLobby(lobby)
	if(self.lobbys[lobby]) then
		error("Lobby "..lobby.name.." already in the manager")
	else
		self.lobbys[lobby] = lobby;
	end
	return true;
end

-- ///////////////////////////////
-- ///// RemoveLobby 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function LobbyManager:RemoveLobby(lobby)
	if(self.lobbys[lobby]) then
		table.remove(self.lobbys, lobby);
		self.lobbys[lobby] = nil;
	end
end

-- ///////////////////////////////
-- ///// DeleteAllLobbys 	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function LobbyManager:DeleteAllLobbys()
	for index, lobby in pairs(self.lobbys) do
		if(lobby) then
			lobby:Destructor();
			self:RemoveLobby(lobby);
		end
	end
end

-- ///////////////////////////////
-- ///// GetFreeDimension 	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function LobbyManager:GetFreeDimension()
	self.lastDimension = self.lastDimension+1;
	
	return self.lastDimension;
end

-- ///////////////////////////////
-- ///// DoCreateLobby	 	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function LobbyManager:DoCreateLobby(player, ...)
	local bool = self:AddLobby(Lobby:New(player, ...));
	
	if(bool) then
		player:ShowMessageBox(player:GetLanguage().messagebox.newgame.sucessTitle, player:GetLanguage().messagebox.newgame.sucessMessage, strings.messagebox.newgame.sucessButton, "sucess", false)
	end
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function LobbyManager:Constructor(...)
	-- Instanzen
	self.lobbys = {};
	
	self.lastDimension = 0;
	-- Funktionen
	
	self.lobbyCreateEvent = function(...) self:DoCreateLobby(source, ...) end;
	-- Events
	
	addEventHandler("onPlayerLobbyCreate", getRootElement(), self.lobbyCreateEvent)
	outputDebugString("[CALLING] LobbyManager: Constructor");
end

-- EVENT HANDLER --
