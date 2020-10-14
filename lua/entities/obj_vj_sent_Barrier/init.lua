if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
AddCSLuaFile("shared.lua")
include("shared.lua")
/*--------------------------------------------------
	=============== Board Entity ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used for defending a certain area from enemies, SNPCs will attack it when close.
--------------------------------------------------*/
ENT.uniqueId = ""
ENT.Model = {"models/hunter/misc/sphere375x375.mdl"}

ENT.shieldRegen = false
ENT.StartHealth = shieldMaxHealth
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.savedMaxHealth = 0
ENT.barrierAmount = 350
function ENT:Initialize()
	self:SetModel("models/hunter/misc/sphere375x375.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMaterial("Models/effects/comball_tape")
	self.RenderGroup = RENDERGROUP_TRANSLUCENT
	self:SetColor(Color(255, 255, 255, 255))
	self:SetParent(self:GetOwner())
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self:SetMoveType(MOVETYPE_NOCLIP)
	self.savedMaxHealth = self:GetOwner():GetMaxHealth()
	self:GetOwner():SetMaxHealth(self:GetOwner():GetMaxHealth() + self.barrierAmount)
	self:GetOwner():SetHealth(self:GetOwner():GetMaxHealth())
	timer.Create("barrier"..self:GetCreationID(), 20, 20, function()
		if (IsValid(self)) then
		self:GetOwner():SetMaxHealth(self.savedMaxHealth)
		self:GetOwner():SetHealth(self.savedMaxHealth)
		self:Remove()
	end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data, physobj)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Use(activator, caller)

end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmginfo)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RegenShield() //Regenerate the shield
end


---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
end



/*--------------------------------------------------
	=============== Board Entity ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used for defending a certain area from enemies, SNPCs will attack it when close.
--------------------------------------------------*/
