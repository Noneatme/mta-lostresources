-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: Importer						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Importer = {};
Importer.__index = Importer;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function Importer:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// ImportRock	 		//////
-- ///////////////////////////////

function Importer:ImportRock()
	local top = self:dxCreateTextureShader();
	self:dxSetShaderTex(top, "files/textures/rock.png", "unnamed");
	self:dxSetShaderTex(top, "files/textures/rock.png", "unnamed");
	
	local dff = engineLoadDFF ( "files/models/d_rock01.dff", 0 )
	engineReplaceModel ( dff, 1252 )
end


-- ///////////////////////////////
-- ///// ImportMap	 		//////
-- ///////////////////////////////

function Importer:ImportMap(id)
	

	local txd = engineLoadTXD ( "files/models/Endor.txd" )
	engineImportTXD ( txd, id )

	local dff = engineLoadDFF ( "files/models/Endor.dff", 0 )
	engineReplaceModel ( dff, id )


	local col = engineLoadCOL ( "files/models/Endor.col" )
	engineReplaceCOL ( col, id )
	

	engineSetModelLODDistance ( id, 1000 )
	
	local object = createObject(id, 0, 0, 3);
end


-- ///////////////////////////////
-- ///// ImportBarrels	 	//////
-- ///////////////////////////////

function Importer:ImportBarrels()
	-- redmetal
	-- hotcoals_64hv
	
	local background = self:dxCreateTextureShader();
	local top = self:dxCreateTextureShader();
	
	
	self:dxSetShaderTex(background, "files/textures/barrel_back.png", "redmetal");
	self:dxSetShaderTex(top, "files/textures/barrel_top.png", "hotcoals_64hv");
	
	
	local dff = engineLoadDFF ( "files/models/spraycan_object.dff", 0 )
	engineReplaceModel ( dff, 2052 )
	
end

-- ///////////////////////////////
-- ///// ImportCrosshair	//////
-- ///////////////////////////////

function Importer:ImportCrosshair()
	local shader = self:dxCreateTextureShader();
	
	self:dxSetShaderTex(shader, "files/images/crosshair.png", "sitem16");
	
end
-- ///////////////////////////////
-- ////dxSetShaderTex		//////
-- ///////////////////////////////

function Importer:dxSetShaderTex(shader, texture, world)
	local s = dxSetShaderValue(shader, "Tex", dxCreateTexture(texture));
	if(world) then
		return s, engineApplyShaderToWorldTexture(shader, world);
	end
end

-- ///////////////////////////////
-- ////dxCreateTextureShader//////
-- ///////////////////////////////

function Importer:dxCreateTextureShader()
	local shader = dxCreateShader("files/shaders/texture.fx")
	return shader;
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Importer:Constructor(...)
--	self:ImportMap(8838);
	self:ImportCrosshair();
	self:ImportBarrels();
	self:ImportRock();
	
	logger:OutputInfo("[CALLING] Importer: Constructor");
end

-- EVENT HANDLER --
