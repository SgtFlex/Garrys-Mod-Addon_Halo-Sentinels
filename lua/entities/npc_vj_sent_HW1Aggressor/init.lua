AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_H3Aggressor/init.lua')
include('shared.lua')

ENT.RangeAttackReps = 1
ENT.NextRangeAttackTime = 3
ENT.NextRangeAttackTime_DoRand = False -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_hwbeamweapon"}
ENT.attackStats = {
	damage = 70,
	beamDuration = 0,
	beamTickRate = 0,
	reload = 3,
}
function ENT:CustomRangeAttackCode() 
	local HWBolt = ents.Create("obj_vj_sent_hwbolt")
	HWBolt:SetOwner(self)
	if (self:LookupAttachment("barrel") != 0) then 
		HWBolt:SetPos(self:GetAttachment(self:LookupAttachment("barrel"))["Pos"])
	else 
		HWBolt:SetPos(self:GetPos() + self:GetForward()*20)
	end
	HWBolt:Spawn()
	HWBolt:GetPhysicsObject():SetVelocity(Vector(0,0,20) +self:GetAimVector()*2500 - Vector(0,0,35) + self:PredictPos(self:GetEnemy(), 1))
	
end

function ENT:PredictPos(entity, multiplier)
	if ((entity:IsPlayer()) && (IsValid(entity:GetVehicle())==false)) then
		return (self:GetEnemy():GetVelocity()*multiplier)
	elseif ((entity:IsPlayer() == false)) then
		return  (self:GetEnemy():GetGroundSpeedVelocity()*multiplier)
	elseif (IsValid(self:GetEnemy():GetVehicle():GetParent())) then
		return (self:GetEnemy():GetVehicle():GetParent():GetVelocity()*multiplier)
	else
		return (self:GetEnemy():GetVehicle():GetVelocity()*multiplier)
	end
end

function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (((self:GetEnemy():GetPos() + self:PredictPos(self:GetEnemy(), 2)) -self:LocalToWorld(Vector(0,0,0))) *0.5 + self:GetUp()*400) //Get enemy coordinate, then get my coordinate in the world * 0.7, and then subtract the two and
end