-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: Lobby.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Lobby = {};
Lobby.__index = Lobby;

--[[

]]



-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Lobby:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// PlayerLeave		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Lobby:PlayerLeave(player)
	if(self.players[player]) then
		self.players[player] = nil;
		table.remove(self.players, player);
		
		logger:OutputMySQL("prophunt-playerleave", "Player "..getPlayerName(player).. " leaved lobby: "..self.name);
	else
		error("Player not in lobby: "..getPlayerName(player));
	end
end

-- ///////////////////////////////
-- ///// PlayerJoin 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Lobby:PlayerJoin(player, password)
	-- Abfragen
	if(self.players[player]) then
		return false;
	end
	
	if(#self.players >= self.playerCount) then
		return 1;
	end
	
	if(self.password) then
		if not(sha256(password) == self.password) then
			return 2;
		end
	end
	player:SetDimension(self.dimension);
	player:LoadMapData(self.map);
	
	self.players[player] = {};
	logger:OutputMySQL("prophunt-playerjoin", "Player "..getPlayerName(player).. " joined lobby: "..self.name);
	return true;
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Lobby:Constructor(player, sName, sPassword, iPlayerCount, iRounds, iRoundLenght, sMap, bFriendlyFire)
	-- Instanzen
	self.name			= sName;
	
	self.password 		= sPassword;
	self.playerCount	= iPlayerCount;
	self.rounds			= iRounds;
	self.roundLenght	= iRoundLenght;
	self.map			= sMap;
	self.owner			= player;
	self.dimension 		= lobbyManager:GetFreeDimension();
	self.friendlyFire	= (bFriendlyFire or false)

	self.players 		= {};
	
	-- Funktionen
	
	-- Events
	logger:OutputMySQL("prophunt-lobbycreate", "Lobby "..self.name.." created by user "..(getPlayerName(self.owner) or "console"));
	
end

-- ///////////////////////////////
-- ///// Destructor	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Lobby:Destructor()
	logger:OutputMySQL("prophunt-lobbydelete", "Lobby "..self.name.." deleted");

	for player, data in pairs(self.players) do
		self:PlayerLeave(player)
	end
	
	lobbyManager:RemoveLobby(self);
end

-- EVENT HANDLER --
