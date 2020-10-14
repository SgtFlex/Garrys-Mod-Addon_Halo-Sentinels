AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_H3Aggressor/init.lua')
include('shared.lua')
ENT.models = {
	BaseModel = "models/sentinels/h3aggressor.mdl",
	CorpseModel = "models/sentinels/h3aggressor.mdl",
	ShieldModel = "models/sentinels/sentinel_a_shield.mdl",
}
ENT.Model = ENT.models["BaseModel"]

ENT.Colors = {
	modelColor = Color(0, 255, 255, 255),
	shieldColor = Color(0, 255, 255, 255),
	corpseColor = Color(100, 100, 100, 255),
	trailColor = Color(0,170,225,150)
}

ENT.defensiveStats = {
	shieldMax = 150,
	shieldCurrent = 150,
	shieldRegen = 1,
	shieldSpeed = .1,
	shieldDelay = 5,
	hullMax = 50,
	hullCurrent = 50,
	hullArmor = 10,
}
ENT.StartHealth = ENT.defensiveStats["hullMax"] + ENT.defensiveStats["shieldMax"]//GetConVarNumber("vj_dum_dummy_h")
ENT.attackStats = {
	damage = 0,
	beamDuration = 1.5,
	beamTickRate = 0.045,
	reload = 4,
}

ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_hwstasisweapon"}
ENT.TimeUntilRangeAttackProjectileRelease=0.1
ENT.RangeAttackReps = 1
ENT.NextRangeAttackTime = 4
ENT.RangeDistance = 3500
ENT.flyVars = {
	minRadiusAroundTarget = 3200,
	maxRadiusAroundTarget = 2500,
	minHeightAboveTarget = 500, //How far above should we aim to be above the target
	maxHeightAboveTarget = 1500, //How far above should we aim to be above the target
	maxPitch = 40,
	maxRoll = 40,
	DecelerationTime = 3,
	AccelerationTime = 3,
	minTravelTime = 1,
	maxTravelTime = 5
}


function ENT:CustomRangeAttackCode() 
	local slowField = ents.Create("obj_vj_sent_slowField")
	slowField:SetPos(self:GetAttachment(self:LookupAttachment("barrel"))["Pos"])
	slowField:Spawn()
	slowField:GetPhysicsObject():SetVelocity(Vector(0,0,20) +self:GetAimVector()*2500 - Vector(0,0,35) + self:PredictPos(self:GetEnemy(), 1))
	slowField:SetOwner(self)
end

function ENT:PredictPos(entity, multiplier)
	local multiplier = 1
	if ((entity:IsPlayer()) && (IsValid(entity:GetVehicle())==false)) then
		return (self:GetEnemy():GetVelocity()*multiplier)
	elseif ((entity:IsPlayer() == false)) then
		return  (self:GetEnemy():GetGroundSpeedVelocity()*multiplier)
	else
		return (self:GetEnemy():GetVehicle():GetParent():GetVelocity()*multiplier)
	end
end

function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (((self:GetEnemy():GetPos() + self:PredictPos(self:GetEnemy(), 2)) -self:LocalToWorld(Vector(0,0,0))) *0.5 + self:GetUp()*400) //Get enemy coordinate, then get my coordinate in the world * 0.7, and then subtract the two and
end