AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_HW1Aggressor/init.lua')
include('shared.lua')

ENT.NextRangeAttackTime = 2
ENT.damage = 30
ENT.models = {
	BaseModel = "models/halowars1/sentinels/protector.mdl",
	CorpseModel = "models/halowars1/sentinels/protector.mdl",
	ShieldModel = "models/hunter/misc/sphere075x075.mdl",
}
ENT.Model = ENT.models["BaseModel"]
ENT.Colors = {
	modelColor = Color(255, 255, 255, 255),
	shieldColor = Color(255, 255, 255, 255),
	corpseColor = Color(100, 100, 100, 255),
	trailColor = Color(200,200,255,150)
}
ENT.defensiveStats = {
	shieldMax = 15,
	shieldCurrent = 15,
	shieldRegen = 1,
	shieldSpeed = .1,
	shieldDelay = 5,
	hullMax = 15,
	hullCurrent = 15,
	hullArmor = 0,
}
ENT.StartHealth = ENT.defensiveStats["hullMax"] + ENT.defensiveStats["shieldMax"]
ENT.attackStats = {
	damage = 30,
	beamDuration = 0,
	beamTickRate = 0,
	reload = 2,
}
ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_hwbeamweapon"}
ENT.soundTable = {
	engineSoundObject = "",
	engineSound = "npc_vj_sent_sentinel/sent_eng1loop.wav",
	enginePitch = 125,
	engineVolume = 0.4,
	firingSoundObject = "",
	firingSound = "npc_vj_sent_sentinel/sentinel_gun/sentGunLoop1.wav",
	firingPitch = 125,
	firingVolume = 1,
	firingIn = "npc_vj_sent_sentinel/sentinel_gun/in.wav",
	firingOut = "npc_vj_sent_sentinel/sentinel_gun/out.wav"
}
ENT.gibTable = {
"models/sentinels/sentinel_constructor_body.mdl",
"models/sentinels/sentinel_constructor_engine.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
}
ENT.lights = {
}
ENT.spriteTrail = {
	Object = "",
	startWidth = 15,
	endWidth = 0,
	lifetime = 2
}
ENT.limbs = {
}