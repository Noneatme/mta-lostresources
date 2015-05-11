-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: Inventory						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Inventory = {};
Inventory.__index = Inventory;

--[[
GUIEditor = {
    combobox = {},
}
GUIEditor.combobox[1] = guiCreateComboBox(525, 244, 180, 118, "All Items", false)
guiSetFont(GUIEditor.combobox[1], "default-bold-small")
guiComboBoxAddItem(GUIEditor.combobox[1], "All Items")
guiComboBoxAddItem(GUIEditor.combobox[1], "Building Items")
guiComboBoxAddItem(GUIEditor.combobox[1], "Food")
guiComboBoxAddItem(GUIEditor.combobox[1], "Tools")
guiComboBoxAddItem(GUIEditor.combobox[1], "Weapons")
]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function Inventory:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///////////////////////////////

function Inventory:Render()
	local a = 138

	self.rm:dxDrawText("Inventory", 732, 239, 1003, 275, tocolor(0, 0, 0, 143), 2, "pricedown", "center", "center", false, false, false, false, false)
	self.rm:dxDrawRectangle(505, 232, 595, 378, tocolor(33, 30, 0, 138), false)
	self.rm:dxDrawRectangle(511, 241, 208, 358, tocolor(0, 0, 0, 107), false)
	self.rm:dxDrawRectangle(511, 240, 208, 31, tocolor(0, 0, 0, 107), false)

	if(getElementData(self.gui.btnClose, "hover")) then a = 200 end
	self.rm:dxDrawRectangle(1025, 238, 70, 20, tocolor(0, 0, 0, a), true)
	
	a = 138
	

	
	self.rm:dxDrawText("Close", 1025, 237, 1094, 257, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	
	self.rm:dxDrawText("Inventory", 735, 237, 1006, 273, tocolor(255, 255, 255, 255), 2, "pricedown", "center", "center", false, false, false, false, false)
	
	if(self.item) then
	
		local id, anzahl = self.item[1], self.item[2];
		local name, description = self.table[id][1], self.table[id][3];
		
		if(fileExists("files/images/"..self.table[id][2])) then
				
			self.rm:dxDrawImage(725, 293, 109, 77, "files/images/"..self.table[id][2], 0, 0, 0, tocolor(255, 255, 255, 255), true)
		
		end
		self.rm:dxDrawText(name, 844, 301, 1096, 374, tocolor(0, 0, 0, 255), 1, "bankgothic", "center", "center", false, false, true, false, false)
		self.rm:dxDrawText(name, 840, 298, 1092, 371, tocolor(255, 255, 255, 255), 1, "bankgothic", "center", "center", false, false, true, false, false)


		self.rm:dxDrawText("Description:\n\n"..(description or "-"), 723, 385, 1095, 492, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true, false, false)
		
	end
	
	self.rm:dxDrawLine(724, 378, 1095, 378, tocolor(0, 0, 0, 255), 1, true)
	self.rm:dxDrawLine(723, 285, 1094, 285, tocolor(0, 0, 0, 255), 1, true)
	

	
	
	
	if(getElementData(self.gui.btnUseItem, "hover")) then a = 200 end
	self.rm:dxDrawRectangle(727, 564, 114, 36, tocolor(0, 0, 0, a), true)
	
	a = 138
	if(getElementData(self.gui.btnThrowAway, "hover")) then a = 200 end
	self.rm:dxDrawRectangle(851, 564, 114, 36, tocolor(0, 0, 0, a), true)
	a = 138
	if(getElementData(self.gui.btnGiveToPlayer, "hover")) then a = 200 end
	self.rm:dxDrawRectangle(975, 564, 114, 36, tocolor(0, 0, 0, a), true)
	
	self.rm:dxDrawText("Use Item", 725, 563, 840, 599, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	self.rm:dxDrawText("Throw away", 851, 564, 966, 600, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	self.rm:dxDrawText("Give to player", 975, 563, 1090, 599, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	
	
	-- ITEM RENDERING --
	
	local add = 0;
	
	local increment = 33;
	
	local table = self.allItems
	
	-- Filtere den Table zu dem ausgewaehlten Filter
	
	if(self.filter == "all") then
		table = self.allItems
	elseif(self.filter == "building") then
		table = self.buildingItems
	elseif(self.filter == "food") then
		table = self.foodItems
	elseif(self.filter == "tools") then
		table = self.toolItems
	elseif(self.filter == "weapons") then
		table = self.weaponsItems
	else
		table = {};
	end
	
	local lastData = self.tableData;
	self.tableData = getElementData(localPlayer, "account:inventoryResult");
	
		--[[
		for id, table in pairs(table) do
			if(self.renderTable[id]) then -- If item vorhanden
			
				local anzahl = self.renderTable[id];
				self.rm:dxDrawRectangle(514, 273+add, 201, 30, tocolor(0, 0, 0, 83), false)
			
			--	dxDrawImage(515, 273, 33, 28, "files/images/hp.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			
				
				self.rm:dxDrawText(table[1].."("..anzahl..")", 514, 272+add*2, 714, 302, tocolor(255, 255, 255, 255), 1, "default-bold", "right", "center", false, false, false, false, false)
			
				add = add+increment;
			end
			
		end]]
		
	for i = self.startPos, self.startPos+12, 1 do
	

		if(self.renderTable2[i])then
			local id, anzahl = self.renderTable2[i][1], self.renderTable2[i][2];
		--	outputChatBox(id..", "..anzahl)
		--	outputChatBox(tostring(table[id]))
			if(table) and (table[id]) then
			
			
				local a = 83
				
				if(getElementData(self.selgui[i], "hover")) or (self.selectedGui == i) then
				
					a = 150
				end
			
				self.rm:dxDrawRectangle(514, 273+add, 201, 30, tocolor(0, 0, 0, a), false)
			
			
				self.rm:dxDrawText(table[id][1].."("..anzahl..")", 514, 272+add*2, 714, 302, tocolor(255, 255, 255, 255), 1, "default-bold", "right", "center", false, false, false, false, false)
			
				if(fileExists("files/images/"..table[id][2])) then
				
					local width = 33
				
					if(string.find(table[id][2], "weapons")) then
						width = 50;
					end
					
					self.rm:dxDrawImage(515, 273+add, width, 28, "files/images/"..table[id][2], 0, 0, 0, tocolor(255, 255, 255, 255), false)
			
				end
				
				add = add+increment;
			end
			--self.rm:dxDrawText(id..", "..anzahl, 514, 272+add*2, 714, 302, tocolor(255, 255, 255, 255), 1, "default-bold", "right", "center", false, false, false, false, false)
			
			--self.rm:dxDrawText(name.."("..anzahl..")", 514, 272+add*2, 714, 302, tocolor(255, 255, 255, 255), 1, "default-bold", "right", "center", false, false, false, false, false)
			
			
		end
	end
end

-- ///////////////////////////////
-- ///// BuildGui			//////
-- ///////////////////////////////

function Inventory:BuildGui()
	self.gui.filter = self.rm:guiCreateComboBox(525, 244, 180, 118, (self.filterText or "All Items"), false)
	guiSetFont(self.gui.filter, "default-bold-small")
	guiComboBoxAddItem(self.gui.filter, "All Items")
	guiComboBoxAddItem(self.gui.filter, "Building Items")
	guiComboBoxAddItem(self.gui.filter, "Food")
	guiComboBoxAddItem(self.gui.filter, "Tools")
	guiComboBoxAddItem(self.gui.filter, "Weapons")
	
	self.gui.btnClose = self.rm:guiCreateButton(1025, 238, 70, 20, "Close", false, nil, true, true)
	
	self.gui.btnUseItem = self.rm:guiCreateButton(727, 564, 114, 36, "Use Item", false, nil, true, true)
	
	self.gui.btnThrowAway = self.rm:guiCreateButton(851, 564, 114, 36, "Throw Away", false, nil, true, true)
	
	self.gui.btnGiveToPlayer = self.rm:guiCreateButton(975, 564, 114, 36, "Give to player", false, nil, true, true)
	
	
	guiSetAlpha(self.gui.btnClose, 0);
	guiSetAlpha(self.gui.btnUseItem, 0);
	guiSetAlpha(self.gui.btnThrowAway, 0);
	guiSetAlpha(self.gui.btnGiveToPlayer, 0);
end


-- ///////////////////////////////
-- ///// TriggerItemUse		//////
-- ///////////////////////////////


function Inventory:TriggerItemUse(id, name)
	if(self.ausdauerItems[id]) then
		local prozent = self.ausdauerItems[id][4]
		if(ausdauerManager.ausdauer+prozent <= 100) then
			ausdauerManager.ausdauer = ausdauerManager.ausdauer+prozent;
			triggerServerEvent("Inventory:UseItem", getLocalPlayer(), id, name)
		else
			messageBox:Show("Error", "You have enought stamina.", "Okay", tocolor(255, 0, 0, 255), true);
			return;
		end
	end

end

-- ///////////////////////////////
-- ///// UseItem			//////
-- ///////////////////////////////

function Inventory:UseItem(id, name)

	local perma = false;
	local server = false;
	
	if(self.permaItems[id]) then
		perma = true;
	end
	
	if(self.serverItems[id]) then
		server = true;
		triggerServerEvent("Inventory:UseItem", getLocalPlayer(), id, name, server, perma, self.allItems)
		self:Hide();
	else
		self:TriggerItemUse(id, name);
		self:Hide()
	end

	outputChatBox("Item used.", 255, 255, 255);
end

-- ///////////////////////////////
-- ///// BindGui			//////
-- ///////////////////////////////


function Inventory:BindGui()
	
	self.closeFunc = function()
		self:Hide();
	end
	
	self.comboBoxFunc = function(gui)
		if(source == self.gui.filter) then
			self.item = nil;
		
			if(guiGetText(source) == "All Items") then
				self.filter = "all";
			elseif(guiGetText(source) == "Building Items") then
				self.filter = "building";
			elseif(guiGetText(source) == "Food") then
				self.filter = "food";
			elseif(guiGetText(source) == "Tools") then
				self.filter = "tools";
			elseif(guiGetText(source) == "Weapons") then
				self.filter = "weapons";
			end
			
			self.filterText = guiGetText(source);
			self:LoadItems();
			
			self.startPos = 1;
			
			self:RebuildGui();
		end
	end;
	
	self.useItemFunc = function()
		local i = self.selectedGui;
		
		if(i) then
			local id, anzahl = self.renderTable2[i][1], self.renderTable2[i][2];
			
			local name = self.allItems[id][1];
			
			if(id) and (anzahl) then
				self:UseItem(id, name);
			end
		end
	end
	
	
	-- Button events
	
	addEventHandler("onClientGUIClick", self.gui.btnClose, self.closeFunc);
	addEventHandler("onClientGUIClick", self.gui.btnUseItem, self.useItemFunc);
	addEventHandler("onClientGUIComboBoxAccepted", self.gui.filter, self.comboBoxFunc);
end


-- ///////////////////////////////
-- ///// LoadItems			//////
-- ///////////////////////////////


function Inventory:LoadItems()

	self.renderTable = {};
	self.renderTable2 = {};
	
	for index, lol in pairs(self.tableData) do
		
		if not(self.renderTable[tonumber(lol['ID'])]) then
			self.renderTable[tonumber(lol['ID'])] = 0;
		end
		self.renderTable[tonumber(lol['ID'])] = self.renderTable[tonumber(lol['ID'])]+1;
	end

	local i = 1;
	for index, key in pairs(self.renderTable) do
		self.renderTable2[i] = {index, key};
	--	outputChatBox(i..", "..index..", "..key)
		i = i+1;
	end
end

-- ///////////////////////////////
-- ///// DestroyGui			//////
-- ///////////////////////////////

function Inventory:DestroyGui()
	
	for index, guiele in pairs(self.gui) do
		if(isElement(guiele)) then 
			destroyElement(guiele);
		end
	end
	
	for index, guiele in pairs(self.selgui) do
		if(isElement(guiele)) then 
			destroyElement(guiele);
		end
	end
	
end

-- ///////////////////////////////
-- ///// Show		 		//////
-- ///////////////////////////////

function Inventory:Show()
	if(self.state == false) then
		addEventHandler("onClientRender", getRootElement(), self.renderFunc);
		self.state = true;
		showCursor(true);
		
		self:BuildGui();
		self:BindGui();
		
		self:LoadItems();
		
		self:RebuildGui();
	end
end


-- ///////////////////////////////
-- ///// Hide		 		//////
-- ///////////////////////////////

function Inventory:Hide()
	if(self.state == true) then
		removeEventHandler("onClientRender", getRootElement(), self.renderFunc);
		self.state = false;
		showCursor(false);
		
		self:DestroyGui();
		
		self.tableData = getElementData(localPlayer, "account:inventoryResult");
	end	
end

-- ///////////////////////////////
-- ///// DoClick			//////
-- ///////////////////////////////


function Inventory:DoClick(i)
	playSoundFrontEnd(41)
	self.selectedGui = i;
	
	self.item = self.renderTable2[i];
	
	
end

-- ///////////////////////////////
-- ///// RebuildGui			//////
-- ///////////////////////////////

function Inventory:RebuildGui()

	if(self.state == true) then
		self.tableData = getElementData(localPlayer, "account:inventoryResult");
		
	--	self.item = nil;
	
		for index, ele in pairs(self.selgui) do
			if(isElement(ele)) then
				destroyElement(ele)
			end
		end
			local table = self.allItems
		
		-- Filtere den Table zu dem ausgewaehlten Filter
		
		if(self.filter == "all") then
			table = self.allItems
		elseif(self.filter == "building") then
			table = self.buildingItems
		elseif(self.filter == "food") then
			table = self.foodItems
		elseif(self.filter == "tools") then
			table = self.toolItems
		elseif(self.filter == "weapons") then
			table = self.weaponItems
		else
			table = {};
		end
		
		self:LoadItems()
		self.table = table;
		
			local add = 0;
		
		local increment = 33;
		
		for i = self.startPos, self.startPos+12, 1 do
			if(self.renderTable2[i]) and (self.renderTable2[i][1]) then
				local id, anzahl = self.renderTable2[i][1], self.renderTable2[i][2];
				
	
				if(table) and (table[id]) then
					
					self.selgui[i] = self.rm:guiCreateButton(514, 273+add, 201, 30, i, false, nil, true, true);
					
					addEventHandler("onClientGUIClick", self.selgui[i], function()
						self:DoClick(i);
					end, false)
					
					
					guiSetAlpha(self.selgui[i], 0)
					
					add = add+increment;
				end
	
			end
		end
	
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Inventory:Constructor(...)
	self.renderFunc = function() self:Render() end;
	self.toggleFunc = function()
	
		if(self.state == true) then
			self:Hide()
		else
			self:Show()	
		end
	end;
	
	self.moveUpFunc = function()
		if(self.state == true) then
			if(self.startPos > 1) then
				self.startPos = self.startPos-1;
				
				self:RebuildGui();
			end
		end
	end
	
	self.moveDownFunc = function()
		if(self.state == true) then

			if(self.startPos <= #self.renderTable2) then
				self.startPos = self.startPos+1;
			
				self:RebuildGui();
			end
		end
	end
	
	self.gui = {};
	
	self.state = false;
	
	self.buildingItems = {
		[1] = {"Wood", "icons/wood.png", "Raw material that can be crafted into wood objects like\n\n - Fences\n - Gates\n - Fire place "},
		[2] = {"Torch", "icons/torch.png", "This item can be placed."},
		[3] = {"Barrel", "icons/barrel.png", "Raw material that can be crafted to:\n\n - Camp Fire (1x Torch + 1x Barrel)"},
		[4] = {"Iron", "icons/iron.png", "Raw material that can be crafted into:\n\n - Weapons"},
		
	}
	
	self.hpItems = {
		[100] = {"Beans", "icons/beans.png", "Eatable item.\n\n + 15 HP", 15},
		[101] = {"Burger", "icons/burger.png", "Eatable item.\n\n + 25 HP", 25},
		[102] = {"Chips", "icons/chips.png", "Eatable item.\n\n + 2 HP", 2},

	}
	
	self.ausdauerItems = {
		[150] = {"Water bottle", "icons/water.png", "Drinkable item.\n\n + 25% stamina", 25},
		[151] = {"Soda bottle", "icons/soda.png", "Drinkable item.\n\n + 35% stamina", 35},
	}
	
	self.toolItems = {
		[200] = {"Gasmask", "icons/gasmask.png"},
		[201] = {"Flashlight", "icons/flashlight.png"},
		[202] = {"Medikit", "icons/medikit.png"},
	}
	
	self.weaponItems = {
		[301] = {"Golf Club", "weapons/2.png"},
		[302] = {"Nightstick", "weapons/3.png"},
		[304] = {"Knife", "weapons/4.png"},
		[305] = {"Baseball Bat", "weapons/5.png"},
		[306] = {"Shovel", "weapons/6.png"},
		[307] = {"Pool Cue", "weapons/7.png"},
		[308] = {"Katana", "weapons/8.png"},
		[309] = {"Chainsaw", "weapons/9.png"},
	}
	
	
	-- Permanente Items --
	self.permaItems = {200, 201};
	
	-- Server Items --
	self.serverItems = table.merge(self.hpItems, self.buildingItems);
		
		
	self.foodItems = table.merge(self.hpItems, self.ausdauerItems);
	
	self.allItems = table.merge(self.buildingItems, self.foodItems)
	self.allItems = table.merge(self.allItems, self.toolItems)
	self.allItems = table.merge(self.allItems, self.weaponItems)

	
	--logger:OutputInfo("[CALLING] Inventory: Constructor");
	
	self.renderTable = {};

	self.tableData = getElementData(localPlayer, "account:inventoryResult");
	
	self.startPos = 1;
	
	self.filter = "all";
	
	self.selgui = {};
	
	
	
	self.rm = RenderManagerCenter:New(1600, 900);
	
	bindKey("i", "down", self.toggleFunc);
	
	bindKey("mouse_wheel_up", "down", self.moveUpFunc);
	
	bindKey("mouse_wheel_down", "down", self.moveDownFunc);
end

function Inventory:GetItemName(id)
	return self.allItems[id][1] or "-"
end
-- EVENT HANDLER --


function table.merge(t1, t2)
	local tablenew = {}
	
	for index, key in pairs(t1) do
		tablenew[index] = key;
	end
	
	for index, key in pairs(t2) do
		tablenew[index] = key;
	end
	
	return tablenew
end