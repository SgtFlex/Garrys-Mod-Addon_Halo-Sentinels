AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('weapons/weapon_vj_sent_sentinelbeam/init.lua')
include('shared.lua')

SWEP.variantColor = Color(150,150,200,255)
SWEP.damage = .25
SWEP.NPC_CanBePickedUp	= false -- Can this weapon be picked up by NPCs? (Ex: Rebels)


function SWEP:CustomOnPrimaryAttackEffects()
	if (!timer.Exists("currentFiring"..self.uniqueId)) then
		self:BeamThing(true) 
		timer.Create("currentFiring"..self.uniqueId, 0.1, 1, function() if (IsValid(self)) then self:BeamThing(false) end end)
	else
		timer.Remove("currentFiring"..self.uniqueId)
		timer.Create("currentFiring"..self.uniqueId, 0.1, 1, function() if (IsValid(self)) then self:BeamThing(false) end end)
	end
	if (string.StartWith(self:GetOwner():GetClass(), "npc_")) then self.aimOffsetZ = -155 end
	local trC = util.TraceLine({
		start = self:GetOwner():GetPos() + self:GetOwner():OBBCenter() + Vector(0, 0, 35),
		endpos = self:GetOwner():GetPos()+ self:GetOwner():OBBCenter() + self:GetOwner():GetAimVector()*10000 + Vector(0, 0, self.aimOffsetZ),
		filter = self:GetOwner(),
		collisiongroup = 0,
		ignoreworld = false,
		mask = MASK_SHOT,
	})
	self:SetNWVector("testvector", trC.HitPos)
	if (IsValid(trC.Entity)) then
		if ((string.StartWith(trC.Entity:GetClass(), "npc_vj_sent_")) || (string.StartWith(trC.Entity:GetClass(), "obj_vj_sent_spawner"))) then //always checking for table, error
			trC.Entity:SetHealth(math.Clamp(trC.Entity:Health() + 1, 0, trC.Entity:GetMaxHealth()))
		else
			trC.Entity:TakeDamage(self.damage, self:GetOwner(), self:GetOwner())
		end
	end
	self:SetNextPrimaryFire( CurTime() + 0.03 )
end