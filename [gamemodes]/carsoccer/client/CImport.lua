--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Carball' - Gamemode for MTA: San Andreas PROJECT X         ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2013-2014, Noneatme
]]


local cFunc = {}
local cSetting = {}


-- FUNCTIONS --

local function replaceObject (name, id)

	local txd = engineLoadTXD ( "data/goal.txd" )
	engineImportTXD ( txd, id )
	
	local col = engineLoadCOL ( "data/"..name..".col" )
	engineReplaceCOL ( col, id )

	local dff = engineLoadDFF ( "data/"..name..".dff" , id )
	engineReplaceModel ( dff, id )
	engineSetModelLODDistance ( id, 10000 )
end

replaceObject ( "goal", 2508 )

local function replaceThings()
	local shader = dxCreateShader("data/shaders/texshader.fx")
	dxSetShaderValue(shader, "myTex", dxCreateTexture("data/images/grass.jpg"))
	engineApplyShaderToWorldTexture(shader, "greyground256128")
	
	--[[
	shader = dxCreateShader("data/shaders/texshader.fx")
	dxSetShaderValue(shader, "myTex", dxCreateTexture("skybox.jpg"))
	engineApplyShaderToWorldTexture(shader, "heat_04")]]
end

replaceThings()


-- EVENT HANDLERS --