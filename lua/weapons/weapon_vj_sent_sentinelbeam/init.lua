AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile("shared.lua")
include('shared.lua')

SWEP.uniqueId = 0
SWEP.variantColor = Color(255, 255, 255, 255)
SWEP.damage = .5
SWEP.DeploySound = {"weapons/draw_rifle.wav"}
SWEP.aimOffsetZ = 0
SWEP.Primary.Delay				= 0.03 -- Time until it can shoot again


function SWEP:CustomOnInitialize()
	self:SetColor(self.variantColor)
	self.sentRepeat = CreateSound(self, "npc_vj_sent_sentinel/sentinel_gun/sentGunLoop1.wav")
	self.uniqueId = tostring(self:GetCreationID())
end

function SWEP:BeamThing(beamOn)
	if (beamOn) then
		self:SetNWBool("firing",true)
		self:EmitSound("npc_vj_sent_sentinel/sentinel_gun/in.wav") 
		self.sentRepeat:Play()
		//self.sentRepeat:ChangePitch(self.soundTable["firingPitch"])
		//self.sentRepeat:ChangeVolume(self.soundTable["firingVolume"])
	elseif (!beamOn) then
		self:SetNWBool("firing", false)
		self.sentRepeat:Stop()
		self:EmitSound("npc_vj_sent_sentinel/sentinel_gun/out.wav") 

	end
end

function SWEP:CustomOnRemove() 
	self.sentRepeat:Stop()
end

local endPosition = 0
function SWEP:CustomOnPrimaryAttackEffects()
	if (!timer.Exists("currentFiring"..self.uniqueId)) then
		self:BeamThing(true) 
		timer.Create("currentFiring"..self.uniqueId, 0.1, 1, function() if (IsValid(self)) then self:BeamThing(false) end end)
	else
		timer.Remove("currentFiring"..self.uniqueId)
		timer.Create("currentFiring"..self.uniqueId, 0.1, 1, function() if (IsValid(self)) then self:BeamThing(false) end end)
	end
	if (string.StartWith(self:GetOwner():GetClass(), "npc_")) then self.aimOffsetZ = -155 end
	if (self:GetOwner():IsNPC()) then
		endPosition = self:GetOwner():GetPos()+ self:GetOwner():OBBCenter() + ((self:GetOwner():GetAimVector()-Vector(0,0,0.08))*10000) + Vector(0, 0, self.aimOffsetZ)
	else
		endPosition = self:GetOwner():GetPos()+ self:GetOwner():OBBCenter() + ((self:GetOwner():GetAimVector())*10000) + Vector(0, 0, self.aimOffsetZ)
	end
	local trC = util.TraceLine({
		start = self:GetOwner():GetPos() + self:GetOwner():OBBCenter() + Vector(0, 0, 35),
		endpos = endPosition,
		filter = self:GetOwner(),
		collisiongroup = 0,
		ignoreworld = false,
		mask = MASK_SHOT,
	})
	self:SetNWVector("testvector", trC.HitPos)
	if (IsValid(trC.Entity)) then
		trC.Entity:TakeDamage(self.damage, self:GetOwner(), self:GetOwner())
	end
end