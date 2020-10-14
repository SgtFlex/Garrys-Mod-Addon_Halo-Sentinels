AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_H2Constructor/init.lua')
include('shared.lua')

ENT.Colors = {
	modelColor = Color(120, 120, 120, 255),
	shieldColor = Color(255, 255, 255, 255),
	corpseColor = Color(100, 100, 100, 255),
	trailColor = Color(100,170,225,150)
}


function ENT:VariantCode()
	hook.Add("Think", "ConstructTimer"..self.uniqueId, function() if ((math.fmod(math.Round(CurTime(), 0), math.random(10, 20)) == 0) && IsValid(self)) then self:Construct() end end)
end

ENT.isConstructing = false

function ENT:Construct()
		local traceConstruct = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetForward()*200 + Vector(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	})
	if (!IsValid(self:GetEnemy()) && self.isConstructing==false && traceConstruct.Hit)  then
		self.isConstructing = true
		self:BeamThing(true)
		self:SetNWVector("SentinelBeam1", traceConstruct.HitPos)
		timer.Create("stopBeam"..self.uniqueId, math.random(2, 4), 1, function() if IsValid(self) then self:BeamThing(false) end end)
		timer.Create("CDTimer"..self.uniqueId, math.random(5, 10), 1, function() if IsValid(self) then self.isConstructing = false end end)
	end
end