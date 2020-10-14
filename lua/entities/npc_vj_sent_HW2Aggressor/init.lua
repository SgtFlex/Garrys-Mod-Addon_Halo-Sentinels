AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_HW1Aggressor/init.lua')
include('shared.lua')

ENT.lights = {
}
ENT.models = {
	BaseModel = "models/sentinels/hw2aggressor.mdl",
	CorpseModel = "models/sentinels/hw2aggressor.mdl",
	ShieldModel = "models/sentinels/sentinel_a_shield.mdl",
}
ENT.Model = ENT.models["BaseModel"]

-- function ENT:SpawnLights() //Spawn any light sprites around the sentinel
-- end