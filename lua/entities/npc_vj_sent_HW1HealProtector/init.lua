AddCSLuaFile("shared.lua")
include('shared.lua')
include('entities/npc_vj_sent_H3Aggressor/init.lua')
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
ENT.flyVars = {
	minRadiusAroundTarget = 300,
	maxRadiusAroundTarget = 600,
	minHeightAboveTarget = 300, //How far above should we aim to be above the target
	maxHeightAboveTarget = 750, //How far above should we aim to be above the target
	maxPitch = 40,
	maxRoll = 40,
	DecelerationTime = 1,
	AccelerationTime = 1,
	minTravelTime = 1,
	maxTravelTime = 5
}
ENT.Colors = {
	modelColor = Color(200,255,200,255),
	shieldColor =  Color(200,255,200,255),
	corpseColor = Color(10,50,10,255),
	trailColor = Color(200,255,200,150)
}
ENT.spriteTrail = {
	Object = "",
	startWidth = 15,
	endWidth = 0,
	lifetime = 2
}
ENT.models = {
	BaseModel = "models/sentinels/h2constructor.mdl",
	CorpseModel = "models/sentinels/h2constructor.mdl",
	ShieldModel = "models/hunter/misc/sphere075x075.mdl",
}
ENT.Model = ENT.models["BaseModel"]
ENT.IsMedicSNPC = true
ENT.Medic_CheckDistance = 2500 -- How far does it check for allies that are hurt? | World units
ENT.Medic_HealDistance = 2500 -- How close does it have to be until it stops moving and heals its ally?
ENT.Medic_HealthAmount = 5 -- How health does it give?
ENT.Medic_NextHealTime1 = 1 -- How much time until it can give health to an ally again | First number in the math.random
ENT.Medic_NextHealTime2 = 2 -- How much time until it can give health to an ally again | Second number in the math.random
ENT.HasMedicSounds_BeforeHeal = false -- If set to false, it won't play any sounds before it gives a med kit to an ally
ENT.HasMedicSounds_AfterHeal = false -- If set to false, it won't play any sounds after it gives a med kit to an ally
ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_sentinelbeamrepair"}
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
ENT.StartHealth = ENT.defensiveStats["hullMax"] + ENT.defensiveStats["shieldMax"]//GetConVarNumber("vj_dum_dummy_h")
ENT.attackStats = {
	damage = 0,
	beamDuration = 1.5,
	beamTickRate = 0.045,
	reload = 2,
}
ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_sentinelbeamRepair"}
ENT.Aerial_AnimTbl_Calm = {"idle"} -- Animations it plays when it's wandering around while idle
ENT.Aerial_AnimTbl_Alerted = {"idleCombat"} -- Animations it plays when it's moving while alerted
ENT.soundTable = {
	engineSoundObject = "",
	firingSoundObject = "",
	engineSound = "npc_vj_sent_sentinel/sent_eng1loop.wav",
	enginePitch = 125,
	engineVolume = 0.1,
	firingSound = "npc_vj_sent_sentinel/sentinel_gun/sentGunLoop1.wav",
	firingPitch = 125,
	firingVolume = 0.7,
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
	EngineLight = {Object = "", Attachment = "root", Color = "200 240 240", Scale = .1, Offset = Vector(-3, 0, 0)},
	HeadLight = {Object = "", Attachment = "head", Color = "0 155 255", Scale = .1, Offset = Vector(5, 0, 4)}
}
ENT.limbs = {
	head = 			{Removed = false, Health = 10, Lights = {"HeadLight"}, Hitgroup = 501, Bodygroups = {"head"}, Gibs = {"models/gibs/metal_gib5.mdl", "models/gibs/metal_gib5.mdl", "models/gibs/metal_gib5.mdl"}},
}

local barrier = ""
function ENT:CustomOnMedic_OnHeal()
	self:SetNWVector("SentinelBeam1",self.Medic_CurrentEntToHeal:GetPos() + Vector(0,0,30))
	self:BeamThing(true)
	timer.Simple(0.5,function() if (IsValid(self)) then self:BeamThing(false) end end)
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