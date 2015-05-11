local Guivar = 0
local Fenster = {}
local Knopf = {}
local Memo = {}
local Label = {}
local Radio = {}
	
local function createReportGui()
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)
	local X, Y, Width, Height = getMiddleGuiPosition(396,283)
	Fenster[1] = guiCreateWindow(X, Y, Width, Height,"Report system",false)
	Radio[1] = guiCreateRadioButton(9,21,104,21,"Question",false,Fenster[1])
	guiRadioButtonSetSelected(Radio[1],true)
	guiSetFont(Radio[1],"default-bold-small")
	Radio[2] = guiCreateRadioButton(85,22,104,21,"Bug",false,Fenster[1])
	guiSetFont(Radio[2],"default-bold-small")
	Radio[3] = guiCreateRadioButton(136,22,104,21,"I need help",false,Fenster[1])
	guiSetFont(Radio[3],"default-bold-small")
	Radio[4] = guiCreateRadioButton(225,23,104,21,"Other",false,Fenster[1])
	guiSetFont(Radio[4],"default-bold-small")
	Label[1] = guiCreateLabel(10,49,110,17,"Your Report:",false,Fenster[1])
	guiSetFont(Label[1],"default-bold-small")
	Memo[1] = guiCreateMemo(9,70,376,173,"",false,Fenster[1])
	Knopf[1] = guiCreateButton(9,249,105,26,"Send",false,Fenster[1])
	Knopf[2] = guiCreateButton(283,248,103,27,"Cancel",false,Fenster[1])
	
	addEventHandler("onClientGUIClick", Knopf[1], function()
		local typ = "N/A"
		if(guiRadioButtonGetSelected(Radio[1])) then typ = "Question" end
		if(guiRadioButtonGetSelected(Radio[2])) then typ = "Bug" end
		if(guiRadioButtonGetSelected(Radio[3])) then typ = "Need help" end
		if(guiRadioButtonGetSelected(Radio[4])) then typ = "Other" end
		if(typ == "N/A") then return end
		local text = guiGetText(Memo[1])
		if(string.len(text) < 20) then sendInfoMessage("Your report must be at least 20 characters long!", "red") return end
		triggerServerEvent("onMultistuntReportInsert", gMe, typ, text)
		destroyElement(Fenster[1])
		Guivar = 0
		setGuiState(0)
		sendInfoMessage("Report succesfull send!", "green")
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[2], function()
		destroyElement(Fenster[1])
		Guivar = 0
		setGuiState(0)
	end, false)
end




addCommandHandler("report", createReportGui)