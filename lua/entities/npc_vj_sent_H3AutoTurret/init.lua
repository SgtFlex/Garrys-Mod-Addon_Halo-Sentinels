AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_H3Aggressor/init.lua')
include('shared.lua')

ENT.models = {
	BaseModel = "models/sentinels/sentinel_turret.mdl",
	CorpseModel = "models/sentinels/sentinel_turret.mdl",
	ShieldModel = "models/sentinels/sentinel_a_shield.mdl",
}
ENT.Model = ENT.models["BaseModel"]
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.Aerial_AnimTbl_Calm = {"idle"} -- Animations it plays when it's wandering around while idle
ENT.Aerial_AnimTbl_Alerted = {"idleCombat"} -- Animations it plays when it's moving while alerted
ENT.canFireAbove = true
ENT.minSpread = 100
ENT.maxSpread = 150
ENT.Colors = {
	modelColor = Color(255, 255, 255, 255),
	shieldColor = Color(255, 255, 255, 255),
	corpseColor = Color(100, 100, 100, 255),
	trailColor = Color(100,170,225,150)
}
ENT.soundTable = {
	engineSoundObject = "",
	firingSoundObject = "",
	engineSound = "npc_vj_sent_sentinel/sent_eng1loop.wav",
	enginePitch = 115,
	engineVolume = 0.2,
	firingSound = "npc_vj_sent_sentinel/sentinel_gun/sentGunLoop1.wav",
	firingPitch = 115,
	firingVolume = 0.7,
	firingIn = "npc_vj_sent_sentinel/sentinel_gun/in.wav",
	firingOut = "npc_vj_sent_sentinel/sentinel_gun/out.wav"
}
ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_sentinelbeamMajor"}

ENT.gibTable = {
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
"models/combine_helicopter/bomb_debris_3.mdl"
}
ENT.lights = {
	HeadLight = {Object = "", Attachment = "", Color = "0 180 200", Scale = .25, Offset = Vector(11, 0, 7)}
}
ENT.defensiveStats = {
	shieldMax = 0,
	shieldCurrent = 0,
	shieldRegen = 1,
	shieldSpeed = .1,
	shieldDelay = 5,
	hullMax = 60,
	hullCurrent = 60,
	hullArmor = 0,
}
ENT.StartHealth = ENT.defensiveStats["hullMax"] + ENT.defensiveStats["shieldMax"]//GetConVarNumber("vj_dum_dummy_h")
ENT.attackStats = {
	damage = 120,
	beamDuration = 1.5,
	beamTickRate = 0.045,
	reload = 2,
}