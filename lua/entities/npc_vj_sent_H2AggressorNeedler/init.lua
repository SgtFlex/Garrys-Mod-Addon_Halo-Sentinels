AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_H3AggressorMajor/init.lua')
include('shared.lua')

ENT.TimeUntilRangeAttackProjectileRelease=0.2
ENT.RangeAttackReps = 7
ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_h2needleweapon"}
ENT.lights = {
	RightLight = {Object = "", Attachment = "root", Color = "0 180 255", Scale = .25, Offset = Vector(8, 16, -1)},
	LeftLight = {Object = "", Attachment = "root", Color = "0 180 255", Scale = .25, Offset = Vector(8, -16, -1)},
	EngineLight = {Object = "", Attachment = "root", Color = "200 240 240", Scale = .7, Offset = Vector(7, 0, 11)},
	GunLight = {Object = "", Attachment = "barrel", Color = "255 150 0", Scale = .25, Offset = Vector(8, 0, -2)},
	HeadLight = {Object = "", Attachment = "eye", Color = "0 155 255", Scale = .25, Offset = Vector(3, 0, -2.5)}
}
ENT.models = {
	BaseModel = "models/sentinels/h2aggressor.mdl",
	CorpseModel = "models/sentinels/h2aggressor.mdl",
	ShieldModel = "models/sentinels/sentinel_a_shield.mdl",
}
ENT.Model = ENT.models["BaseModel"]

function ENT:CustomRangeAttackCode() 
	local bolt = ents.Create("obj_vj_sent_bolt")
	bolt:SetPos(self:GetPos() + Vector(0, 0, -20))
	bolt:Spawn()
	bolt:GetPhysicsObject():SetVelocity(Vector(0,0,20) +self:GetAimVector()*700 - Vector(0,0,35) + self:PredictPos(self:GetEnemy(), 1))
	bolt:SetOwner(self)
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

function ENT:VariantCode()
	self:SetMaterial("models/sentinels/h2aggressor/h2aggressor_base_major")
end