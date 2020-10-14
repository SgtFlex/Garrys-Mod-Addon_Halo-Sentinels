    
TOOL.Name = "Halo Sentinel Emitter"
TOOL.Category = "Tools"
TOOL.Tab = "DrVrej"
TOOL.Command = nil
TOOL.ConfigName = "" 
 
TOOL.ClientConVar["spawnDelay"] = 10
TOOL.ClientConVar["maxActive"] = 20
TOOL.ClientConVar["maxActivePerSpawner"] = 10
TOOL.ClientConVar["healthEmitter"] = 200
TOOL.ClientConVar["damageOnlyWhenOpen"] = 1
TOOL.ClientConVar["canBeTargeted"] = 1



local emitterValues = {
	timeSpawn = 50,
	maxActive = 20,
	maxActivePer = 5,
	emitterHealth = 200,
	dmgOnlyWhenOpen = true
}

local DefaultConVars = {}
for k,v in pairs(TOOL.ClientConVar) do
	DefaultConVars["vjstool_sentinelemitter_"..k] = v
end

if (CLIENT) then
	language.Add("tool.emitter_spawner.name", "Halo Sentinel Emitter Tool")
	language.Add("tool.emitter_spawner.desc", "Spawn Sentinel Emitters")
	language.Add("tool.emitter_spawner.0", "Left-click to spawn an emitter with the current parameters, Right-click to remove the selected emitter")
end

function TOOL:LeftClick( trace )
	local posSpawn = trace.HitNormal
	local ent = ents.Create("obj_vj_sent_spawner")
	ent:SetPos(trace.HitPos)
	ent:SetAngles(posSpawn:Angle())
	ent.StartHealth = GetConVarNumber("vjstool_sentinelemitter_healthEmitter")
	ent.TimedSpawn_Time = GetConVarNumber("vjstool_sentinelemitter_spawnDelay")
	ent.maxActive = GetConVarNumber("vjstool_sentinelemitter_maxActive")
	ent.whatToSpawn = GetConVarString("vjstool_sentinelemitter_spawnType")
	ent.damageOnlyWhenOpen = GetConVarNumber("vjstool_sentinelemitter_damageOnlyWhenOpen")
	ent.perSpawner = GetConVarNumber("vjstool_sentinelemitter_maxActivePerSpawner")
	ent.canBeTargeted = GetConVarNumber("vjstool_sentinelemitter_canBeTargeted")
	ent:Spawn()
	undo.Create( "Emitter" )
	undo.AddEntity( ent )
	undo.SetPlayer(self:GetOwner() )
	undo.Finish()
return true
end
 
function TOOL:RightClick( trace )
	if trace.Entity:GetClass() == "obj_vj_sent_spawner" then
		trace.Entity:Remove()
		return true
	end
end




local function DoBuildCPanel_Spawner(Panel)
		local reset = vgui.Create("DButton")
		reset:SetFont("DermaDefaultBold")
		reset:SetText("Reset To Default")
		reset:SetSize(150,25)
		reset:SetColor(Color(0,0,0,255))
		reset.DoClick = function(reset)
			for k,v in pairs(DefaultConVars) do
				if v == "" then LocalPlayer():ConCommand(k.." ".."None") else
				LocalPlayer():ConCommand(k.." "..v) end
				timer.Simple(0.05,function()
				GetPanel = controlpanel.Get("vjstool_sentinelemitter")
				GetPanel:ClearControls()
				DoBuildCPanel_Spawner(GetPanel)
				end)
			end
			LocalPlayer():ConCommand("vjstool_construct_sentinelemitter_maxEmitters".." 5")
		end
		Panel:AddPanel(reset)
	Panel:ControlHelp("NOTE: These settings will only apply to newly spawned sentinel emitters")
	Panel:AddControl("Slider", {Label = "Time between spawns",min = 0,max = 1000,Command = "vjstool_sentinelemitter_spawnDelay"})
	Panel:AddControl("Slider", {Label = "Max active of type",min = 0,max = 1000,Command = "vjstool_sentinelemitter_maxActive"})
	Panel:AddControl("Slider", {Label = "Max active per spawner",min = 0,max = 1000,Command = "vjstool_sentinelemitter_maxActivePerSpawner"})
	Panel:AddControl("Slider", {Label = "Spawner Health",min = 0,max = 1000,Command = "vjstool_sentinelemitter_healthEmitter"})
	Panel:AddControl("Slider", {Label = "Max Construct. Emitters",min = 0,max = 20,Command = "vjstool_construct_sentinelemitter_maxEmitters"})
	Panel:AddControl("Checkbox", {Label = "Only take damage when open?", Command = "vjstool_sentinelemitter_damageOnlyWhenOpen"})
	Panel:AddControl("Checkbox", {Label = "Can be targeted by NPCs?", Command = "vjstool_sentinelemitter_canBeTargeted"})
	local typebox = vgui.Create("DComboBox")
	typebox:SetValue(GetConVarString("vjstool_sentinelemitter_spawnType"))
	typebox:AddChoice("npc_vj_sent_H1Aggressor")
	typebox:AddChoice("npc_vj_sent_H1AggressorMajor")
	typebox:AddChoice("npc_vj_sent_H2Aggressor")
	typebox:AddChoice("npc_vj_sent_H2AggressorMajor")
	typebox:AddChoice("npc_vj_sent_H2AggressorNeedler")
	typebox:AddChoice("npc_vj_sent_H2Constructor")
	typebox:AddChoice("npc_vj_sent_H2Assembler")
	typebox:AddChoice("npc_vj_sent_H2EnforcerUnshielded")
	typebox:AddChoice("npc_vj_sent_H2EnforcerShielded")
	typebox:AddChoice("npc_vj_sent_H3Aggressor")
	typebox:AddChoice("npc_vj_sent_H3AggressorMajor")
	typebox:AddChoice("npc_vj_sent_H3AutoTurret")
	typebox:AddChoice("npc_vj_sent_H3GuiltySpark")
	typebox:AddChoice("npc_vj_sent_HW1Aggressor")
	typebox:AddChoice("npc_vj_sent_HW1AggressorMajor")
	typebox:AddChoice("npc_vj_sent_HW1AttackProtector")
	typebox:AddChoice("npc_vj_sent_HW1HealProtector")
	typebox:AddChoice("npc_vj_sent_HW1ShieldProtector")
	typebox:AddChoice("npc_vj_sent_HW1SuperSentinel")
	typebox:AddChoice("npc_vj_sent_RandomSentinel")
	function typebox:OnSelect(index,value,data)
		LocalPlayer():ConCommand("vjstool_sentinelemitter_spawnType "..value)
	end
	Panel:AddPanel(typebox)
		local constructorEmitter = vgui.Create("DButton")
		constructorEmitter:SetFont("DermaDefaultBold")
		constructorEmitter:SetText("Update Constructors' Emitters")
		constructorEmitter:SetSize(150,25)
		constructorEmitter:SetColor(Color(0,0,0,255))
		constructorEmitter.DoClick = function(constructorEmitter)
		LocalPlayer():ConCommand("vjstool_construct_sentinelemitter_spawnDelay".." "..GetConVarNumber("vjstool_sentinelemitter_spawnDelay"))
		LocalPlayer():ConCommand("vjstool_construct_sentinelemitter_maxActive".." "..GetConVarNumber("vjstool_sentinelemitter_maxActive"))
		LocalPlayer():ConCommand("vjstool_construct_sentinelemitter_maxActivePerSpawner".." "..GetConVarNumber("vjstool_sentinelemitter_maxActivePerSpawner"))
		LocalPlayer():ConCommand("vjstool_construct_sentinelemitter_healthEmitter".." "..GetConVarNumber("vjstool_sentinelemitter_healthEmitter"))
		LocalPlayer():ConCommand("vjstool_construct_sentinelemitter_damageOnlyWhenOpen".." "..GetConVarNumber("vjstool_sentinelemitter_damageOnlyWhenOpen"))
		LocalPlayer():ConCommand("vjstool_construct_sentinelemitter_spawnType".." "..GetConVarString("vjstool_sentinelemitter_spawnType"))
		LocalPlayer():ConCommand("vjstool_construct_sentinelemitter_canBeTargeted".." "..GetConVarNumber("vjstool_sentinelemitter_canBeTargeted"))

		end
		Panel:AddPanel(constructorEmitter)
end

function TOOL.BuildCPanel(Panel)
		DoBuildCPanel_Spawner(Panel)
end

