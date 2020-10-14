if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
include('shared.lua')
require('sound_vj_track')
/*--------------------------------------------------
	=============== Creature SNPC Base ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to make creature SNPCs
--------------------------------------------------*/
SWEP.RenderGroup = RENDERGROUP_BOTH
SWEP.sentFX = "sentBeamFX"
SWEP.sentFXOrigin = "sentBeamFXOrigin"
SWEP.Laser = Material("cable/redlaser")
SWEP.firingOffset = Vector(0, 0, 20)

local target = Vector(5000, 5000, 5000)
local shootPos = Vector(0, 0, 0)
local firingPos
local spawnParticles = 1
function SWEP:Initialize() 
	if (GetConVar("vj_sent_useParticles"):GetInt() == 0) then
		spawnParticles = false
	elseif (GetConVar("vj_sent_useParticles"):GetInt() == 1) then
		spawnParticles = true
	end
end
function SWEP:Draw()
	self:DrawModel()
	self:CustomOnDraw()
end
function SWEP:DrawTranslucent() self:Draw() end
function SWEP:BuildBonePositions(NumBones,NumPhysBones) end
function SWEP:SetRagdollBones(bIn) self.m_bRagdollSetup = bIn end
function SWEP:DoRagdollBone(PhysBoneNum,BoneNum) /*self:SetBonePosition(BoneNum,Pos,Angle)*/ end
//function ENT:CalcAbsolutePosition(pos, ang) end
-- Custom functions ---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:ViewModelDrawn()
	if (self:LookupAttachment("barrel") != 0) then 
		firingPos = self:GetAttachment(self:LookupAttachment("barrel"))["Pos"]
	else 
		firingPos = self:GetPos() + self:GetRight()*5
	end
    render.SetMaterial( self.Laser )
    if (self:GetNWBool("firing",false)==true) then
    	render.DrawBeam( firingPos + self.firingOffset, self:GetOwner():GetEyeTrace().HitPos, 35, 1, 1, Color( 0, 0, 0, 0) )
    	if (spawnParticles == true) then
    	local effect = EffectData()
    	effect:SetOrigin(firingPos)
    	effect:SetEntity(self)
    	util.Effect(self.sentFXOrigin, effect)
    	effect:SetOrigin(self:GetNWVector("testvector"))
    	util.Effect(self.sentFX, effect)
    end
    end
end

function SWEP:CustomOnDrawWorldModel()
	if (self:LookupAttachment("barrel") != 0) then 
		firingPos = self:GetAttachment(self:LookupAttachment("barrel"))["Pos"]
	else 
		firingPos = self:GetPos()
	end
    render.SetMaterial( self.Laser )
    if (self:GetNWBool("firing",false)==true) then
    	render.DrawBeam( firingPos, self:GetNWVector("testvector",Vector( 0, 0, 0 )), 35, 1, 1, Color( 0, 0, 0, 0) )
    	if (spawnParticles == true) then
    	local effect = EffectData()
    	effect:SetOrigin(firingPos)
    	effect:SetEntity(self)
    	util.Effect(self.sentFXOrigin, effect)
    	effect:SetOrigin(self:GetNWVector("testvector"))
    	util.Effect(self.sentFX, effect)
    end
    end
end
