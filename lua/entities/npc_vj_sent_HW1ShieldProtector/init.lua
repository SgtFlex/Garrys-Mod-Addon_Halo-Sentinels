AddCSLuaFile("shared.lua")
include('shared.lua')
include('entities/npc_vj_sent_HW1HealProtector/init.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
/* To do list:
	-Get rid of blood on Gib
	-Add shield effects
	-Fix AI 
	-Instead of NPC blowing up immediatly, have them fall out of the air, wait 2 seconds, them explode
	-Make Major(beefed up) and Protector(Support) variants
	VARIANT 
	
	ENT.StartHealth = 20//GetConVarNumber("vj_dum_dummy_h")
	util.SpriteTrail(self, 0,Color(80,140,255,150),true,50,10,2,20,"trails/smoke")
	self:SetColor(Color(150,150,200,255)) --Gold
	bullet.Damage = 1
*/
ENT.IsMedicSNPC = true
ENT.Medic_HealthAmount = 0 -- How health does it give?
ENT.Medic_NextHealTime1 = 10 -- How much time until it can give health to an ally again | First number in the math.random
ENT.Medic_NextHealTime2 = 10 -- How much time until it can give health to an ally again | Second number in the math.random
ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_sentinelbeamrepair"}
ENT.Colors = {
	modelColor = Color(255,230,150,255),
	shieldColor =  Color(255,230,150,255),
	corpseColor = Color(50,30,10,255),
	trailColor = Color(255,230,150,150)
}
ENT.spriteTrail = {
	Object = "",
	startWidth = 15,
	endWidth = 0,
	lifetime = 2
}
ENT.defensiveStats = {
	shieldMax = 15,
	shieldCurrent = 15,
	shieldRegen = 1,
	shieldSpeed = .1,
	shieldDelay = 5,
	hullMax = 5,
	hullCurrent = 5,
	hullArmor = 0,
}
ENT.StartHealth = ENT.defensiveStats["hullMax"] + ENT.defensiveStats["shieldMax"]//GetConVarNumber("vj_dum_dummy_h")ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_sentinelbeamRepair"}
ENT.attackStats = {
	damage = 0,
	beamDuration = 1.5,
	beamTickRate = 0.045,
	reload = 2,
}
local barrier = ""
function ENT:CustomOnMedic_OnHeal()
	self:SetNWVector("SentinelBeam1",self.Medic_CurrentEntToHeal:GetPos() + Vector(0,0,30))
	self:BeamThing(true)
	timer.Simple(0.5,function() if (IsValid(self)) then self:BeamThing(false) end end)
	barrier = ents.Create("obj_vj_sent_Barrier")
	barrier:SetPos(self.entToShield:GetPos())
	barrier:SetOwner(self.entToShield)
	barrier:Spawn()
end

ENT.entToShield = ""
function ENT:DoMedicCode_FindAllies()
	-- for k,v in ipairs(player.GetAll()) do v.AlreadyBeingHealedByMedic = false end
	if self.IsMedicSNPC == false or self.Medic_IsHealingAlly == true or CurTime() < self.Medic_NextHealT or self.VJ_IsBeingControlled == true then return false end
	local findallies = ents.FindInSphere(self:GetPos(),self.Medic_CheckDistance)
	for k,v in ipairs(findallies) do
		if !v:IsNPC() && !v:IsPlayer() then continue end
		if v:EntIndex() != self:EntIndex() && v.AlreadyBeingHealedByMedic == false && (!v.IsVJBaseSNPC_Tank) && v:Health() <= v:GetMaxHealth() * 0.75 && ((v.IsVJBaseSNPC == true && v.Medic_CanBeHealed == true) or (v:IsPlayer() && GetConVarNumber("ai_ignoreplayers") == 0)) then
			if /*self:Disposition(v) == D_LI &&*/ self:DoRelationshipCheck(v) == false then
				self.Medic_NextHealT = CurTime() + math.Rand(self.Medic_NextHealTime1,self.Medic_NextHealTime2)
				self.NextIdleTime = CurTime() + 5
				self.NextChaseTime = CurTime() + 5
				self.Medic_WanderValue = self.DisableWandering
				self.Medic_ChaseValue = self.DisableChasingEnemy
				self.DisableWandering = true
				self.DisableChasingEnemy = true
				self.Medic_CurrentEntToHeal = v
				self.Medic_IsHealingAlly = true
				self.AlreadyDoneMedicThinkCode = false
				v.AlreadyBeingHealedByMedic = true
				self.entToShield = v
				//self:SelectSchedule()
				//self:VJ_SetSchedule(SCHED_IDLE_STAND)
				self:SelectSchedule()
				self:StopMoving()
				self:StopMoving()
				self:SetTarget(v)
				self:VJ_TASK_GOTO_TARGET()
			return true
			end
		end
	end
	return false
end

function ENT:CustomRangeAttackCode()
end
/*-----------------------------------------------
*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-------------------------------------------------*/