-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: MainMenu_Newgame.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

MainMenu_Newgame = {};
MainMenu_Newgame.__index = MainMenu_Newgame;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MainMenu_Newgame:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MainMenu_Newgame:Render()
	if(self.enabled) then
		self.rm:dxDrawRectangle(439, 254, 1102, 356, tocolor(0, 0, 0, 194), falses)
		self.rm:dxDrawText(strings.mainmenu.newgame.lobbyname, 449, 264, 536, 295, tocolor(255, 255, 255, 255), 0.2, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		self.rm:dxDrawRectangle(439, 227, 1102, 27, tocolor(0, 245, 201, 127), true)
		self.rm:dxDrawText(strings.mainmenu.newgame.newlobby, 439, 227, 1540, 254, tocolor(255, 255, 255, 255), 0.2, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		self.rm:dxDrawText(strings.mainmenu.newgame.password, 449, 313, 536, 344, tocolor(255, 255, 255, 255), 0.2, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		self.rm:dxDrawText(strings.mainmenu.newgame.playercount, 797, 264, 884, 295, tocolor(255, 255, 255, 255), 0.2, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		self.rm:dxDrawText(strings.mainmenu.newgame.rounds, 449, 407, 536, 438, tocolor(255, 255, 255, 255), 0.2, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		self.rm:dxDrawText(strings.mainmenu.newgame.roundlenght, 661, 409, 748, 440, tocolor(255, 255, 255, 255), 0.2, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		self.rm:dxDrawText(strings.mainmenu.newgame.seconds, 852, 414, 866, 435, tocolor(255, 255, 255, 255), 0.2, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		self.rm:dxDrawText(strings.mainmenu.newgame.map, 1000, 268, 1069, 295, tocolor(255, 255, 255, 255), 0.2, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		self.rm:dxDrawText(strings.mainmenu.newgame.preview, 894, 305, 976, 473, tocolor(255, 255, 255, 255), 0.2, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		
		local map = guiGetText(self.guiele.combobox4)
		
		if(fileExists("files/images/maps/"..map..".jpg")) then
			self.rm:dxDrawImage(1015, 305, 264, 165, "files/images/maps/"..map..".jpg", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		
		end

		self.rm:dxDrawRectangle(1279, 553, 246, 48, tocolor(255, 255, 255, 73), true)
		self.rm:dxDrawText(strings.mainmenu.newgame.startgame, 1282, 553, 1530, 601, getColorFromBool(getElementData(self.guiele.startgame, "hover"), 255, 255, 255, 255, 255, 255, 255, 150), 0.4, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
	end
end

-- ///////////////////////////////
-- ///// AddEvents	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Newgame:AddEvents()
	self.startGameFunc = function()
		local sLobbyName 	= guiGetText(self.guiele.edit1);
		local sPassword 	= guiGetText(self.guiele.edit2);
		
		local iPlayers		= tonumber(guiGetText(self.guiele.combobox1));
		local iRounds		= tonumber(guiGetText(self.guiele.combobox2));
		local iRoundLenght	= tonumber(guiGetText(self.guiele.combobox3));
	
		local sMap			= guiGetText(self.guiele.combobox4);
		
		local bFriendlyFire	= guiCheckBoxGetSelected(self.guiele.checkbox1);
		
		if(#sLobbyName > 3 and #sPassword > 3 and (iPlayers) and (iRounds) and (iRoundLenght) and #sMap > 1) then
			triggerServerEvent("onPlayerLobbyCreate", getLocalPlayer(), sLobbyName, sha256(sPassword), iPlayers, iRounds, iRoundLenght, sMap, bFriendlyFire);
		else
			messageBox:Show(strings.messagebox.newgame.failTitle, strings.messagebox.newgame.failMessage, strings.messagebox.newgame.failButton, "error", false);
		end
	
	end
	
	
	addEventHandler("onClientGUIClick", self.guiele.startgame, self.startGameFunc)
	
end

-- ///////////////////////////////
-- ///// BuildGui	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Newgame:BuildGui()
	self.guiele.checkbox1 	= self.rm:guiCreateCheckBox(449, 457, 152, 34, "Friendly fire", true, false)
	self.guiele.edit1 		= self.rm:guiCreateEdit(553, 264, 205, 35, "", false)
	self.guiele.edit2		= self.rm:guiCreateEdit(553, 309, 205, 35, "", false)
	
	self.guiele.startgame	= self.rm:guiCreateButton(1279, 553, 1530-1279, 601-553, "", false, nil, true, rstrings.sounds.buttons.hover, rstrings.sounds.buttons.click);
	guiSetAlpha(self.guiele.startgame, 0)
	
	self.guiele.combobox1	= self.rm:guiCreateComboBox(894, 271, 77, 212, "", false)
	for index, val in ipairs(self.players) do guiComboBoxAddItem(self.guiele.combobox1, val) end;
	
	
	self.guiele.combobox2	= self.rm:guiCreateComboBox(553, 413, 79, 211, "", false)
	for index, val in ipairs(self.rounds) do guiComboBoxAddItem(self.guiele.combobox2, val) end;
	
	
	self.guiele.combobox3	= self.rm:guiCreateComboBox(768, 414, 79, 215, "", false)
	
	for index, val in ipairs(self.roundLenght) do guiComboBoxAddItem(self.guiele.combobox3, val) end;
	
	
	self.guiele.combobox4 	= self.rm:guiCreateComboBox(1069, 272, 156, 271, "", false)
	for index, val in ipairs(self.maps) do guiComboBoxAddItem(self.guiele.combobox4, val) end;
	
	self:AddEvents();
	
	for index, ele in pairs(self.guiele) do
		if(self.guitext[index]) then
			guiSetText(ele, self.guitext[index])
		end
	
		guiSetFont(ele, fontManager.guiFonts.agency)
	end
end

-- ///////////////////////////////
-- ///// DestroyGui	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Newgame:DestroyGui()
	for index, ele in pairs(self.guiele) do
		self.guitext[index] = (guiGetText(ele) or false)
		destroyElement(ele);
	end
end
-- ///////////////////////////////
-- ///// Toggle		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Newgame:Toggle()
	if(self.enabled) then
		self.enabled = false;
		self:DestroyGui();
	else
		self.enabled = true;
		self:BuildGui();
	end
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Newgame:Constructor(...)
	-- Instanzen
	self.guiele 		= {};
	self.guitext 		= {};
	self.enabled 		= false;
	self.rm 			= RenderManager:New(g.aesx, g.aesy);
	
	self.players 		= {2, 4, 6, 8, 10, 12, 14, 16, 32, 64, 128, 256};
	self.rounds			= {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 40, 80, 160, 240};
	self.roundLenght	= {30, 60, 90, 120, 240, 480};
	self.maps			= {"prophunt-airport"};

	
	-- Funktionen

	
	-- Events
	
	outputDebugString("[CALLING] MainMenu_Newgame: Constructor");
end

-- EVENT HANDLER --
