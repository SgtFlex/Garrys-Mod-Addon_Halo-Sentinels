/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName ="[VJ]Halo Sentinels"
local AddonName ="Halo"
local AddonType ="SNPC"
local AutorunFile ="autorun/vj_halosentinels_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat ="Halo Sentinels" -- Category, you can also set a category individually by replacing the vCat with a string value
	VJ.AddNPC("(All) Weighted Random Sentinel","npc_vj_sent_randomSentinel",vCat)
	VJ.AddNPC("(H1) Aggressor","npc_vj_sent_H1Aggressor",vCat)
	VJ.AddNPC("(H1) Aggressor Major","npc_vj_sent_H1AggressorMajor",vCat)
	VJ.AddNPC("(H2) Aggressor","npc_vj_sent_H2Aggressor",vCat)
	VJ.AddNPC("(H2) Aggressor Major","npc_vj_sent_H2AggressorMajor",vCat)
	VJ.AddNPC("(H2) Aggressor Needler","npc_vj_sent_H2AggressorNeedler",vCat)
	VJ.AddNPC("(H2) Constructor","npc_vj_sent_H2Constructor",vCat)
	VJ.AddNPC("(H2) Assembler","npc_vj_sent_H2Assembler",vCat)
	VJ.AddNPC("(H2) Enforcer unshielded","npc_vj_sent_H2EnforcerUnshielded",vCat)
	VJ.AddNPC("(H2) Enforcer shielded","npc_vj_sent_H2EnforcerShielded",vCat)
	VJ.AddNPC("(H3) Aggressor","npc_vj_sent_H3Aggressor",vCat)
	VJ.AddNPC("(H3) Aggressor Major","npc_vj_sent_H3AggressorMajor",vCat)
	VJ.AddNPC("(H3) Auto Turret","npc_vj_sent_H3AutoTurret",vCat)
	VJ.AddNPC("(H3) 343 Guilty Spark","npc_vj_sent_H3GuiltySpark",vCat)
	VJ.AddNPC("(HW1) Aggressor","npc_vj_sent_HW1Aggressor",vCat)
	VJ.AddNPC("(HW1) Aggressor Major","npc_vj_sent_HW1AggressorMajor",vCat)
	VJ.AddNPC("(HW1) Healing Protector Sentinel SW0459","npc_vj_sent_HW1HealProtector",vCat)
	VJ.AddNPC("(HW1) Shielding Protector Sentinel SW0459","npc_vj_sent_HW1ShieldProtector",vCat)
	VJ.AddNPC("(HW1) Offensive Protector Sentinel SW0459","npc_vj_sent_HW1AttackProtector",vCat)
	VJ.AddNPC("(HW1) Super Sentinel","npc_vj_sent_HW1SuperSentinel", vCat)
	//VJ.AddNPC("(HW2) Aggressor","npc_vj_sent_HW2Aggressor", vCat)
	VJ.AddWeapon("Sentinel Beam","weapon_vj_sent_sentinelbeam", false, vCat)
	VJ.AddWeapon("Sentinel Beam (Major)","weapon_vj_sent_sentinelbeammajor", false, vCat)
	VJ.AddWeapon("Sentinel Beam (Repair)","weapon_vj_sent_sentinelbeamrepair", false, vCat)
	VJ.AddWeapon("Sentinel Auto Turret","weapon_vj_sent_sentautoturret",false,vCat)
	VJ.AddWeapon("(HW) Stasis Weapon","weapon_vj_sent_hw1stasisweapon",false,vCat)
	VJ.AddWeapon("(HW) Beam Weapon","weapon_vj_sent_hw1beamweapon",false,vCat)
	VJ.AddWeapon("(H2) Needle Weapon","weapon_vj_sent_h2needleweapon",false,vCat)
	VJ.AddWeapon("(H2) Rocket Weapon","weapon_vj_sent_h2rocketweapon",false,vCat)
	VJ.AddNPCWeapon("Sentinel Beam","weapon_vj_sent_sentinelbeam")
	VJ.AddNPCWeapon("Sentinel Beam (Major)","weapon_vj_sent_sentinelbeammajor")
	VJ.AddNPCWeapon("Sentinel Beam (Repair)","weapon_vj_sent_sentinelbeamrepair")
	VJ.AddNPCWeapon("Sentinel Auto Turret","weapon_vj_sent_sentautoturret")
	VJ.AddNPCWeapon("(HW) Stasis Weapon","weapon_vj_sent_hw1stasisweapon")
	VJ.AddNPCWeapon("(HW) Beam Weapon","weapon_vj_sent_hw1beamweapon")
	VJ.AddNPCWeapon("(H2) Needle Weapon","weapon_vj_sent_h2needleweapon")
	VJ.AddNPCWeapon("(H2) Rocket Weapon","weapon_vj_sent_h2rocketweapon")

		-- Parameters:
			-- First is the name, second is the class name
			-- Third is a table of weapon, the base will pick a random one from the table and give it to the SNPC when"Default Weapon" is selected
			-- Fourth is the category that it should be in
			-- Fifth is optional, which is a boolean that defines whether or not it's an admin-only entity

	-- ConVars --.
	VJ.AddConVar("vj_sent_GSArmed", 1, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_useParticles", 1, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_chanceFire", 50, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_chanceFall", 50, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_chanceGib", 50, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_chanceTimedDeath", 50, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_chanceRandomFire", 50, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_sentinelsFriendly", 1, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_sentinelsDropWeapon", 1, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_sentinelemitter_healthEmitter", 100, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_sentinelemitter_maxActive", 20, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_sentinelemitter_maxActivePerSpawner", 10, FCVAR_ARCHIVE)	
	VJ.AddConVar("vjstool_sentinelemitter_spawnDelay", 10, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_sentinelemitter_spawnType","npc_vj_sent_H3Aggressor", FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_sentinelemitter_damageOnlyWhenOpen", 1, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_sentinelemitter_canBeTargeted", 1, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_construct_sentinelemitter_healthEmitter", 100, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_construct_sentinelemitter_maxActive", 20, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_construct_sentinelemitter_maxActivePerSpawner", 10, FCVAR_ARCHIVE)	
	VJ.AddConVar("vjstool_construct_sentinelemitter_spawnDelay", 10, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_construct_sentinelemitter_spawnType","npc_vj_sent_H3Aggressor", FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_construct_sentinelemitter_damageOnlyWhenOpen", 1, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_construct_sentinelemitter_maxEmitters", 1, FCVAR_ARCHIVE)
	VJ.AddConVar("vjstool_construct_sentinelemitter_canBeTargeted", 1, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_sentinelDamageModifier", 1, FCVAR_ARCHIVE)
	
	VJ.AddConVar("vj_sent_H1AggressorWeight", 30, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H1AggressorMajorWeight", 10, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H2AggressorWeight", 30, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H2AggressorMajorWeight", 10, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H2AggressorNeedlerWeight", 2, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H2ConstructorWeight", 15, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H2AssemblerWeight", 15, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H2EnforcerUnshieldedWeight", 7, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H2EnforcerShieldedWeight", 7, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H3AggressorWeight", 30, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H3AggressorMajorWeight", 10, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H3AutoTurretWeight", 0, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_H3GuiltySparkWeight", 1, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_HW1AggressorWeight", 30, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_HW1AggressorMajorWeight", 10, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_HW1AttackProtectorWeight", 15, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_HW1HealProtectorWeight", 15, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_HW1ShieldProtectorWeight", 15, FCVAR_ARCHIVE)
	VJ.AddConVar("vj_sent_HW1SuperSentinelWeight", 5, FCVAR_ARCHIVE)


local DefaultConVarsMain = {
	sentinelDamageModifier = 1,
	GSArmed = 1,
	useParticles = 1,
	chanceFire = 50,
	chanceFall = 50,
	chanceGib = 50,
	chanceTimedDeath = 50,
	chanceRandomFire = 50,
	sentinelsFriendly = 1,
	sentinelsDropWeapon = 1,
	H1AggressorWeight = 30,
	H1AggressorMajorWeight = 10,
	H2AggressorWeight = 30,
	H2AggressorMajorWeight = 10,
	H2AggressorNeedlerWeight = 2,
	H2ConstructorWeight = 15,
	H2AssemblerWeight = 15,
	H2EnforcerUnshieldedWeight = 7,
	H2EnforcerShieldedWeight = 7,
	H3AggressorWeight = 30,
	H3AggressorMajorWeight = 10,
	H3AutoTurretWeight = 0,
	H3GuiltySparkWeight = 1,
	HW1AggressorWeight = 30,
	HW1AggressorMajorWeight = 10,
	HW1AttackProtectorWeight = 15,
	HW1HealProtectorWeight = 15,
	HW1ShieldProtectorWeight = 15,
	HW1SuperSentinelWeight = 5
}

	local function VJ_SENTINELS_MAIN(Panel)
		local reset = vgui.Create("DButton")
		reset:SetFont("DermaDefaultBold")
		reset:SetText("Reset To Default")
		reset:SetSize(150,25)
		reset:SetColor(Color(0,0,0,255))
		reset.DoClick = function(reset)
			for k,v in pairs(DefaultConVarsMain) do
				LocalPlayer():ConCommand("vj_sent_"..k.." "..v)
				timer.Simple(0.05,function()
				GetPanel = controlpanel.Get("VJ_SENTINELS_MAIN")
				GetPanel:ClearControls()
				VJ_SENTINELS_MAIN(GetPanel)
				end)
			end
		end
		Panel:AddPanel(reset)
		Panel:ControlHelp("NOTE: These settings will only apply to newly spawned sentinels.")
		Panel:ControlHelp("Bomb & Weapon Malfunction are dependent on Falling death.")
		Panel:ControlHelp("Vfire obviously requires Vfire to be installed.")
		Panel:AddControl("Checkbox", {Label ="Guilty spark is armed?", Command ="vj_sent_GSArmed"})
		Panel:AddControl("Checkbox", {Label ="Sentinels are friendly?", Command ="vj_sent_sentinelsFriendly"})
		Panel:AddControl("Checkbox", {Label ="Sentinels drop weapons?", Command ="vj_sent_sentinelsDropWeapon"})
		Panel:AddControl("Checkbox", {Label ="Spawn Particle FX?", Command ="vj_sent_useParticles"})
		Panel:AddControl("Slider", {Type ="float", Label ="Sentinel Dmg Modifier",min = 0,max = 5,Command ="vj_sent_sentinelDamageModifier"})
		Panel:AddControl("Slider", {Type ="float", Label ="Falling death chance",min = 0,max = 100,Command ="vj_sent_chanceFall"})
		Panel:AddControl("Slider", {Type ="float", Label ="Vfire Chance",min = 0,max = 100,Command ="vj_sent_chanceFire"})
		Panel:AddControl("Slider", {Type ="float", Label ="Gib Chance",min = 0,max = 100,Command ="vj_sent_chanceGib"})
		Panel:AddControl("Slider", {Type ="float", Label ="Bomb Chance",min = 0,max = 100,Command ="vj_sent_chanceTimedDeath"})
		Panel:AddControl("Slider", {Type ="float", Label ="Weapon Malfunction chance",min = 0,max = 100,Command ="vj_sent_chanceRandomFire"})
		Panel:ControlHelp("Weights: Adjust these numbers to control the chances of different sentinels spawning from \"Weighted Random Sentinel\". A higher number for a sentinel relative to others means it's more likely to spawn. A weight set to 0 means it won't spawn.")
		Panel:AddControl("Textbox", {Label ="H1Aggressor", Command ="vj_sent_H1AggressorWeight"})
		Panel:AddControl("Textbox", {Label ="H1AggressorMajor", Command ="vj_sent_H1AggressorMajorWeight"})
		Panel:AddControl("Textbox", {Label ="H2Aggressor", Command ="vj_sent_H2AggressorWeight"})
		Panel:AddControl("Textbox", {Label ="H2AggressorMajor", Command ="vj_sent_H2AggressorMajorWeight"})
		Panel:AddControl("Textbox", {Label ="H2AggressorNeedler", Command ="vj_sent_H2AggressorNeedlerWeight"})
		Panel:AddControl("Textbox", {Label ="H2Constructor", Command ="vj_sent_H2ConstructorWeight"})
		Panel:AddControl("Textbox", {Label ="H2Assembler", Command ="vj_sent_H2AssemblerWeight"})
		Panel:AddControl("Textbox", {Label ="H2EnforcerUnshielded", Command ="vj_sent_H2EnforcerUnshieldedWeight"})
		Panel:AddControl("Textbox", {Label ="H2EnforcerShielded", Command ="vj_sent_H2EnforcerShieldedWeight"})
		Panel:AddControl("Textbox", {Label ="H3Aggressor", Command ="vj_sent_H3AggressorWeight"})
		Panel:AddControl("Textbox", {Label ="H3AggressorMajor", Command ="vj_sent_H3AggressorMajorWeight"})
		Panel:AddControl("Textbox", {Label ="H3AutoTurret", Command ="vj_sent_H3AutoTurretWeight"})
		Panel:AddControl("Textbox", {Label ="H3GuiltySpark", Command ="vj_sent_H3GuiltySparkWeight"})
		Panel:AddControl("Textbox", {Label ="HWAggressor", Command ="vj_sent_HW1AggressorWeight"})
		Panel:AddControl("Textbox", {Label ="HWAggressorMajor", Command ="vj_sent_HW1AggressorMajorWeight"})
		Panel:AddControl("Textbox", {Label ="HWAttackProtector", Command ="vj_sent_HW1AttackProtectorWeight"})
		Panel:AddControl("Textbox", {Label ="HWHealProtector", Command ="vj_sent_HW1HealProtectorWeight"})
		Panel:AddControl("Textbox", {Label ="HWShieldProtector", Command ="vj_sent_HW1ShieldProtectorWeight"})
		Panel:AddControl("Textbox", {Label ="HWSuperSentinel", Command ="vj_sent_HW1SuperSentinelWeight"})


	end
	function VJ_ADDTOMENU_SENTINELS(Panel)
		spawnmenu.AddToolMenuOption("DrVrej","SNPC Configures","Halo Sentinels","Halo Sentinels","","", VJ_SENTINELS_MAIN, {} )
	end
		hook.Add("PopulateToolMenu","VJ_ADDTOMENU_SENTINELS", VJ_ADDTOMENU_SENTINELS )

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end