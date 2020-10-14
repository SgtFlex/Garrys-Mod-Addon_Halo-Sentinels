AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_H3Aggressor/init.lua')
include('shared.lua')

ENT.Colors = {
	modelColor = Color(255,230,0,255),
	shieldColor = Color(255,230,170,150),
	corpseColor = Color(115,100,0,255),
	trailColor = Color(170,170,0,200)
}
ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_sentinelbeamMajor"}
ENT.defensiveStats = {
	shieldMax = 150,
	shieldCurrent = 150,
	shieldRegen = 3,
	shieldSpeed = .1,
	shieldDelay = 5,
	hullMax = 50,
	hullCurrent = 50,
	hullArmor = 20,
}
ENT.StartHealth = ENT.defensiveStats["hullMax"] + ENT.defensiveStats["shieldMax"]//GetConVarNumber("vj_dum_dummy_h")
ENT.attackStats = {
	damage = 225,
	beamDuration = 1.5,
	beamTickRate = 0.045,
	reload = 2,
}
function ENT:VariantCode()
	self:SetMaterial("models/sentinels/h3aggressor/h3aggressor_base_major")
end