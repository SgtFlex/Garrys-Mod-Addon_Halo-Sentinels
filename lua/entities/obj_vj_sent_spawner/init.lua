if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
/*--------------------------------------------------
	=============== Spawner Base ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to make spawners.
--------------------------------------------------*/
ENT.IsVJBaseSpawner = true
ENT.VJBaseSpawnerDisabled = false -- If set to true, it will stop spawning the entities
ENT.SingleSpawner = false -- If set to true, it will spawn the entities once then remove itself
	-- General ---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Model = {"models/sentinels/sentinel_emitter.mdl"} -- The models it should spawn with | Picks a random one from the table
ENT.whatToSpawn = "npc_vj_sent_H3Aggressor"
ENT.EntitiesToSpawn = {
	{EntityName = "H3Aggressor",SpawnPosition = {vForward=100,vRight=0,vUp=0},Entities = {ENT.whatToSpawn}},
	-- Extras: --
	-- WeaponsList = {} (Use "default" to make it spawn the NPC with its default weapons)
}
ENT.TimedSpawn_Time = 7 -- How much time until it spawns another SNPC?
ENT.spawnSingle = 1
ENT.TimedSpawn_OnlyOne = false -- If it's true then it will only have one SNPC spawned at a time
ENT.HasIdleSounds = true -- Does it have idle sounds?
ENT.SoundTbl_Idle = {}
ENT.IdleSoundChance = 1 -- How much chance to play the sound? 1 = always
ENT.IdleSoundLevel = 80
ENT.IdleSoundPitch1 = 80
ENT.IdleSoundPitch2 = 100
ENT.NextSoundTime_Idle1 = 0.2
ENT.NextSoundTime_Idle2 = 0.5
ENT.SoundTbl_SpawnEntity = {}
ENT.SpawnEntitySoundChance = 1 -- How much chance to play the sound? 1 = always
ENT.SpawnEntitySoundLevel = 80
ENT.SpawnEntitySoundPitch1 = 80
ENT.SpawnEntitySoundPitch2 = 100
ENT.StartHealth = 100
ENT.canBeDamaged = false
ENT.corpseColor = Color(100, 100, 100, 255)
ENT.uniqueId=""
ENT.maxActive = 20
ENT.damageOnlyWhenOpen = 1
ENT.perSpawner = 5

ENT.gibTable = {
"models/sentinels/sentinel_emitter_door.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",

}
	-- Independent Variables ---------------------------------------------------------------------------------------------------------------------------------------------
-- These should be left as they are
ENT.Dead = false
ENT.AlreadyDoneVJBaseSpawnerDisabled = false
ENT.NextIdleSoundT = 0
ENT.NextTimedSpawnT = 0
ENT.VJ_AddEntityToSNPCAttackList = true
ENT.canBeTargeted = true
ENT.lightColors = {
	"0 140 200",
	"250 250 255"
}
ENT.lightPositions = { //Use attachments instead of just positions in future update
	Vector(35, 0, -26),
	Vector(20, 0, 15)
}
ENT.lightScales = {
	1.5,
	5
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnEntitySpawn(EntityName,SpawnPosition,Entities,TheEntity) 
	timer.Simple(1.5, function() 
		if (IsValid(self)) then 
			self:SetSequence("idleClose") 
			self:RemoveFlags( FL_OBJECT )
			self:SetHate(false) 
		end 
	end)	
end

function ENT:SetHate(isTrue)
	if (self.canBeTargeted==1 && isTrue==true) then
	for _,v in pairs(ents.GetAll()) do
        if v:IsNPC() && (!v.PlayerFriendly) && (v.IsVJBaseSNPC) then
        	if (!string.StartWith(v:GetClass(), "npc_vj_sent")) then
            	table.insert(v.VJ_AddCertainEntityAsEnemy,self)
            	v:VJ_DoSetEnemy(self,true,true)
            	v:SetEnemy(self)
	            end
        end
    end
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize_BeforeNPCSpawn() 
	self:SetSequence("idleClose")
	self:SpawnLights()
end

function ENT:SpawnLights()
	for k,v in ipairs(self.lightColors) do
		local light1 = ents.Create("env_sprite")
		light1:SetParent(self, 1)
		light1:SetKeyValue("rendermode", "9")
		light1:SetKeyValue("renderamt", "255")
		light1:SetKeyValue("model","blueflare1_noz.vmt")
		light1:SetKeyValue("GlowProxySize","5.5")
		light1:SetKeyValue("rendercolor",tostring(self.lightColors[k]))
		light1:SetKeyValue("scale",tostring(self.lightScales[k]))
		light1:Spawn()
		light1:Activate()
		light1:SetPos(self:GetPos() + self:GetForward()*self.lightPositions[k].x + self:GetRight()*self.lightPositions[k].y + self:GetUp()*self.lightPositions[k].z)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize_AfterNPCSpawn() end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_BeforeAliveChecks() end



function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup) 
	if self.canBeDamaged==false && self.damageOnlyWhenOpen==1 then return false end
	if (dmginfo:GetDamage() >= self:Health()) then
		
		self:CreateCustomCorpse()
	end
end

function ENT:CreateCustomCorpse()
	util.ScreenShake( self:GetPos(), 50, 500, 1.2, 500 )
	local corpse = ents.Create("prop_physics")
		corpse:SetModel("models/sentinels/sentinel_emitter_destroyed.mdl")
		corpse:SetModelScale(self:GetModelScale())
		corpse:SetColor(self.corpseColor)
		corpse:PhysicsInit(SOLID_VPHYSICS)
		corpse:SetMoveType(MOVETYPE_NONE)
		corpse:SetPos(self:GetPos())
		corpse:SetAngles(self:GetAngles())
		corpse:SetSequence(self:GetSequence())
		corpse.RenderGroup = RENDERGROUP_BOTH
		local effect = EffectData()
		effect:SetOrigin(corpse:GetPos() + corpse:GetForward()*150)
		ParticleEffect("explosion_turret_break",corpse:GetPos() + corpse:GetForward()*50,Angle(0,0,0),nil)
		util.Effect("cball_explode",EffectData())
		corpse:EmitSound(Sound("npc_vj_sent_sentinel/sentinel_death/quick1.wav"))
		timer.Create("corpse"..self.uniqueId,2.5,16,function () if (IsValid(corpse)) then effect:SetOrigin(corpse:GetPos()) util.Effect("cball_explode",effect) corpse:EmitSound(Sound("Sentinel/sentinel_welder_impact/weld13.wav")) end end)
		timer.Simple(2.5,function() if (IsValid(corpse)) then corpse:Ignite() end end)
		timer.Simple(40, function () if (IsValid(corpse)) then  corpse:Remove() end end)
		local ent={}
		for k,v in pairs(self.gibTable) do
			ent[k] = ents.Create("obj_vj_sent_gib")
			ent[k]:SetModel(self.gibTable[k])
			ent[k]:SetModelScale(self:GetModelScale())
			ent[k]:PhysicsInit(SOLID_VPHYSICS)
			ent[k]:SetPos(self:GetPos())
			ent[k]:SetCollisionGroup(1)
			ent[k]:GetPhysicsObject():AddAngleVelocity(Vector(math.random(-100, 100),math.random(-100, 100), math.random(75, 250)))
			ent[k]:GetPhysicsObject():AddVelocity(self:GetForward() + Vector(math.random(-300, 300),math.random(-300, 300), math.random(-50, 150)))
			timer.Create("debris"..self.uniqueId..k, 6, 1, function() if (IsValid(ent[k])) then ent[k]:Remove() end end)
			local effect=EffectData()
			if (GetConVarNumber("vj_sent_useParticles")==1) then timer.Create("FireFallFXSmall"..self.uniqueId..k, 0.025, 300, function() if (IsValid(ent[k]) && ent[k]:GetVelocity():Length()>50) then effect:SetOrigin(ent[k]:GetPos()) util.Effect("fireFallFXSmall", effect) end end) end
		end
		self:Remove()
end


function ENT:OnTakeDamage(dmginfo,data)
	if self.canBeDamaged==false && self.damageOnlyWhenOpen==1 then return false end
	if self.DoingVJDeathDissolve == true then self.DoingVJDeathDissolve = false return true end
	if self.Dead == true then return false end
	if self.GodMode == true then return false end
	if dmginfo:GetDamage() <= 0 then return false end
	local DamageInflictor = dmginfo:GetInflictor()
	local DamageAttacker = dmginfo:GetAttacker()
	local DamageType = dmginfo:GetDamageType()
	local hitgroup = self.VJ_ScaleHitGroupDamage
	if IsValid(DamageInflictor) && DamageInflictor:GetClass() == "prop_ragdoll" && DamageInflictor:GetVelocity():Length() <= 100 then return false end

	if self.GetDamageFromIsHugeMonster == true then
		if DamageAttacker.VJ_IsHugeMonster == true then
			self:SetHealth(self:Health() - dmginfo:GetDamage())
		end
		if self:Health() <= 0 && self.Dead == false then
			self:PriorToKilled(dmginfo,hitgroup)
		end
	end
	
	if self:IsOnFire() && self:WaterLevel() == 2 then self:Extinguish() end

	if VJ_HasValue(self.ImmuneDamagesTable,DamageType) then return end
	if self.AllowIgnition == false && (self:IsOnFire() && IsValid(DamageInflictor) && IsValid(DamageAttacker) && DamageInflictor:GetClass() == "entityflame" && DamageAttacker:GetClass() == "entityflame") then print("gay") self:Extinguish() return false end
	if self.Immune_Fire == true && (DamageType == DMG_BURN or DamageType == DMG_SLOWBURN or (self:IsOnFire() && IsValid(DamageInflictor) && IsValid(DamageAttacker) && DamageInflictor:GetClass() == "entityflame" && DamageAttacker:GetClass() == "entityflame")) then return false end
	if self.Immune_AcidPoisonRadiation == true && (DamageType == DMG_ACID or DamageType == DMG_RADIATION or DamageType == DMG_POISON or DamageType == DMG_NERVEGAS or DamageType == DMG_PARALYZE) then return false end
	if self.Immune_Bullet == true && (dmginfo:IsBulletDamage() or DamageType == DMG_AIRBOAT or DamageType == DMG_BUCKSHOT) then return false end
	if self.Immune_Blast == true && (DamageType == DMG_BLAST or DamageType == DMG_BLAST_SURFACE) then return false end
	if self.Immune_Dissolve == true then if DamageType == DMG_DISSOLVE then return false end end
	if self.Immune_Electricity == true && (DamageType == DMG_SHOCK or DamageType == DMG_ENERGYBEAM or DamageType == DMG_PHYSGUN) then return false end
	if self.Immune_Melee == true && (DamageType == DMG_CLUB or DamageType == DMG_SLASH) then return false end
	if self.Immune_Physics == true && DamageType == DMG_CRUSH then return false end
	if self.Immune_Sonic == true && DamageType == DMG_SONIC then return false end
	if (IsValid(DamageInflictor) && DamageInflictor:GetClass() == "prop_combine_ball") or (IsValid(DamageAttacker) && DamageAttacker:GetClass() == "prop_combine_ball") then
		if self.Immune_Dissolve == true then return false end
		if CurTime() > self.NextCanGetCombineBallDamageT then
			dmginfo:SetDamage(math.random(400,500))
			dmginfo:SetDamageType(DMG_DISSOLVE)
			self.NextCanGetCombineBallDamageT = CurTime() + 0.2
		else
			dmginfo:SetDamage(1)
		end
	end

	self:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
	if dmginfo:GetDamage() <= 0 then return false end
	self.LatestDmgInfo = dmginfo
	self:SetHealth(self:Health() -dmginfo:GetDamage())
	if self.VJDEBUG_SNPC_ENABLED == true then if GetConVarNumber("vj_npc_printondamage") == 1 then print(self:GetClass().." Got Damaged! | Amount = "..dmginfo:GetDamage()) end end
	if self.Bleeds == true && dmginfo:GetDamage() > 0 then
		if self.HasBloodParticle == true && ((!self:IsOnFire()) or (self:IsOnFire() && IsValid(DamageInflictor) && IsValid(DamageAttacker) && DamageInflictor:GetClass() != "entityflame" && DamageAttacker:GetClass() != "entityflame")) then self:SpawnBloodParticles(dmginfo,hitgroup) end
		if self.HasBloodDecal == true then self:SpawnBloodDecal(dmginfo,hitgroup) end
		self:ImpactSoundCode()
	end

	if self:Health() >= 0 then
		//self:DoFlinch(dmginfo,hitgroup)
		//self:DamageByPlayerCode(dmginfo,hitgroup)
		//self:PainSoundCode()

		if (self.Behavior == VJ_BEHAVIOR_PASSIVE or self.Behavior == VJ_BEHAVIOR_PASSIVE_NATURE) && CurTime() > self.Passive_NextRunOnDamageT then
			if self.Passive_RunOnDamage == true then
				self:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH",function(x) end)
			end
			if self.Passive_AlliesRunOnDamage then
				local checka = self:CheckAlliesAroundMe(self.Passive_AlliesRunOnDamageDistance)
				if checka.ItFoundAllies == true then
					for k,v in ipairs(checka.FoundAllies) do
						v.Passive_NextRunOnDamageT = CurTime() + math.Rand(v.Passive_NextRunOnDamageTime1,v.Passive_NextRunOnDamageTime2)
						v:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH",function(x) end)
						v:AlertSoundCode()
					end
				end
			end
			self.Passive_NextRunOnDamageT = CurTime() + math.Rand(self.Passive_NextRunOnDamageTime1,self.Passive_NextRunOnDamageTime2)
		end

		if self.CallForBackUpOnDamage == true && CurTime() > self.NextCallForBackUpOnDamageT && !IsValid(self:GetEnemy()) && self.FollowingPlayer == false && self.Behavior != VJ_BEHAVIOR_PASSIVE && self.Behavior != VJ_BEHAVIOR_PASSIVE_NATURE && ((!IsValid(DamageInflictor)) or (IsValid(DamageInflictor) && DamageInflictor:GetClass() != "entityflame")) && IsValid(DamageAttacker) && DamageAttacker:GetClass() != "entityflame" then
			local allies = self:CheckAlliesAroundMe(self.CallForBackUpOnDamageDistance)
			if allies.ItFoundAllies == true then
				self:BringAlliesToMe("Random",self.CallForBackUpOnDamageDistance,allies.FoundAllies,self.CallForBackUpOnDamageLimit)
				self:ClearSchedule()
				self.NextFlinchT = CurTime() + 1
				local pickanim = VJ_PICKRANDOMTABLE(self.CallForBackUpOnDamageAnimation)
				if VJ_AnimationExists(self,pickanim) == true && self.DisableCallForBackUpOnDamageAnimation == false then
					self:VJ_ACT_PLAYACTIVITY(pickanim,true,self:DecideAnimationLength(pickanim,self.CallForBackUpOnDamageAnimationTime),true)
				else
					self:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH",function(x) x.CanShootWhenMoving = true x.ConstantlyFaceEnemy = true end)
					//self:VJ_SetSchedule(SCHED_RUN_FROM_ENEMY)
					/*local vschedHide = ai_vj_schedule.New("vj_hide_callbackupondamage")
					vschedHide:EngTask("TASK_FIND_COVER_FROM_ENEMY", 0)
					vschedHide:EngTask("TASK_RUN_PATH", 0)
					vschedHide:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
					vschedHide.ResetOnFail = true
					self:StartSchedule(vschedHide)*/
				end
				self.NextCallForBackUpOnDamageT = CurTime() + math.Rand(self.NextCallForBackUpOnDamageTime1,self.NextCallForBackUpOnDamageTime2)
			end
		end
		
		/*if DamageInflictor:GetClass() == "crossbow_bolt" then
			print("test")
			local mdlBolt = ents.Create("prop_dynamic_override")
			mdlBolt:SetPos(dmginfo:GetDamagePosition())
			mdlBolt:SetAngles(DamageAttacker:GetAngles())
			mdlBolt:SetModel("models/crossbow_bolt.mdl")
			mdlBolt:SetParent(self)
			mdlBolt:Spawn()
			mdlBolt:Activate()
		end*/
		

		if self.BecomeEnemyToPlayer == true && self.VJ_IsBeingControlled == false && DamageAttacker:IsPlayer() && GetConVarNumber("ai_disabled") == 0 && GetConVarNumber("ai_ignoreplayers") == 0 && (self:Disposition(DamageAttacker) == D_LI or self:Disposition(DamageAttacker) == D_NU) then
			if self.AngerLevelTowardsPlayer <= self.BecomeEnemyToPlayerLevel then
				self.AngerLevelTowardsPlayer = self.AngerLevelTowardsPlayer + 1
			end
			if self.AngerLevelTowardsPlayer > self.BecomeEnemyToPlayerLevel then
				if self:Disposition(DamageAttacker) != D_HT then
					self:CustomWhenBecomingEnemyTowardsPlayer(dmginfo,hitgroup)
					if self.FollowingPlayer == true && self.FollowingPlayerName == DamageAttacker then self:FollowPlayerReset() end
					self.VJ_AddCertainEntityAsEnemy[#self.VJ_AddCertainEntityAsEnemy+1] = DamageAttacker
					self:AddEntityRelationship(DamageAttacker,D_HT,99)
					if !IsValid(self:GetEnemy()) then
						self:StopMoving()
						self:SetTarget(DamageAttacker)
						self:VJ_TASK_FACE_X("TASK_FACE_TARGET")
					end
					if self.AllowPrintingInChat == true then
						DamageAttacker:PrintMessage(HUD_PRINTTALK, self:GetName().." no longer likes you.")
					end
					self:BecomeEnemyToPlayerSoundCode()
				end
				self.Alerted = true
			end
		end

		if self.DisableTakeDamageFindEnemy == false && !IsValid(self:GetEnemy()) && CurTime() > self.TakingCoverT && self.VJ_IsBeingControlled == false && self.Behavior != VJ_BEHAVIOR_PASSIVE && self.Behavior != VJ_BEHAVIOR_PASSIVE_NATURE /*&& self.Alerted == false*/ && GetConVarNumber("ai_disabled") == 0 then
			local sightdist = self.SightDistance / 2 -- Gesvadz tive
			-- Yete gesvadz tive hazaren aveli kich e, ere vor chi ges e tive...
			-- Yete tive 2000 - 4000 mechene, ere vor mishd 2000 ela...
			-- Yete 4000 aveli e, ere vor gesvadz tive kordzadz e
			if sightdist <= 1000 then
				sightdist = self.SightDistance
			else
				sightdist = math.Clamp(sightdist,2000,self.SightDistance)
			end
			local Targets = ents.FindInSphere(self:GetPos(),sightdist)
			if (!Targets) then return end
			for k,v in pairs(Targets) do
				if CurTime() > self.NextSetEnemyOnDamageT && self:Visible(v) && self:DoRelationshipCheck(v) == true then
					self:CustomOnSetEnemyOnDamage(dmginfo,hitgroup)
					self.NextCallForHelpT = CurTime() + 1
					self:VJ_DoSetEnemy(v,true)
					self:DoChaseAnimation()
					self.NextSetEnemyOnDamageT = CurTime() + 1
				else
					//self:CallForHelpCode(self.CallForHelpDistance)
					if CurTime() > self.NextRunAwayOnDamageT then
						if self.FollowingPlayer == false && self.RunAwayOnUnknownDamage == true && self.MovementType != VJ_MOVETYPE_STATIONARY then
							self:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH",function(x) x.CanShootWhenMoving = true x.ConstantlyFaceEnemy = true end)
							//self:VJ_SetSchedule(SCHED_RUN_FROM_ENEMY)
							/*local vschedHide = ai_vj_schedule.New("vj_hide_unknowndamage")
							vschedHide:EngTask("TASK_FIND_COVER_FROM_ENEMY", 0)
							vschedHide:EngTask("TASK_RUN_PATH", 0)
							vschedHide:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
							vschedHide.ResetOnFail = true
							self:StartSchedule(vschedHide)*/
						end
						self.NextRunAwayOnDamageT = CurTime() + self.NextRunAwayOnDamageTime
					end
				end
			end
		end
	end

	if self:Health() <= 0 && self.Dead == false then
		self:RemoveEFlags(EFL_NO_DISSOLVE)
		if (dmginfo:GetDamageType() == DMG_DISSOLVE) or (IsValid(DamageInflictor) && DamageInflictor:GetClass() == "prop_combine_ball") then
			local dissolve = DamageInfo()
			dissolve:SetDamage(self:Health())
			dissolve:SetAttacker(DamageAttacker)
			dissolve:SetDamageType(DMG_DISSOLVE)
			self.DoingVJDeathDissolve = true
			self:TakeDamageInfo(dissolve)
		end
		//self:PriorToKilled(dmginfo,hitgroup)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AfterAliveChecks() end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove() end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnAnEntity(keys,values,initspawn)
	local trstart = self:GetPos() + self:GetForward()*100
	local trend = self:GetPos() + self:GetForward()*100
	local tr = util.TraceHull({
		start = trstart,
		endpos = trend,
		mins = Vector(-50, -50, -50),
		maxs = Vector(50, 50, 50),
		mask = MASK_NPCSOLID,
		filter = self
	})
	local k = keys
	local v = values
	local initspawn = initspawn or false
	local overridedisable = false
	local hasweps = false
	local wepslist = {}
	if initspawn == true then overridedisable = true end
	if self.VJBaseSpawnerDisabled == true && overridedisable == false then return end
	local getthename = v.EntityName
	local spawnpos = v.SpawnPosition
	local getthename = ents.Create(VJ_PICKRANDOMTABLE(v.Entities))
	getthename:SetPos(self:GetPos() +self:GetForward()*spawnpos.vForward +self:GetRight()*spawnpos.vRight +self:GetUp()*spawnpos.vUp)
	getthename:SetAngles(self:GetAngles())
	getthename:Spawn()
	getthename:SetSequence("spawn") //not working correctly
	getthename:Activate()
	if v.WeaponsList != nil && VJ_PICKRANDOMTABLE(v.WeaponsList) != false && VJ_PICKRANDOMTABLE(v.WeaponsList) != NULL && VJ_PICKRANDOMTABLE(v.WeaponsList) != "None" && VJ_PICKRANDOMTABLE(v.WeaponsList) != "none" then hasweps = true wepslist = v.WeaponsList end
	if hasweps == true then
		local randwep = VJ_PICKRANDOMTABLE(v.WeaponsList) -- Kharen zenkme zad e
		if randwep == "default" then
			getthename:Give(VJ_PICKRANDOMTABLE(list.Get("NPC")[getthename:GetClass()].Weapons))
		else
			getthename:Give(randwep)
		end
	end
	//if initspawn == false then table.remove(self.CurrentEntities,k) end
	table.insert(self.CurrentEntities,k,{EntityName=v.EntityName,SpawnPosition=v.SpawnPosition,Entities=v.Entities,TheEntity=getthename,WeaponsList=wepslist,Dead=false/*NextTimedSpawnT=CurTime()+self.TimedSpawn_Time*/})
	self:SpawnEntitySoundCode()
	if self.VJBaseSpawnerDisabled == true && overridedisable == true then getthename:Remove() return end
	self:CustomOnEntitySpawn(v.EntityName,v.SpawnPosition,v.Entities,TheEntity)
	if tr.Hit || initspawn then 
		getthename:Remove()
		//table.RemoveByValue(self.CurrentEntities, #self.CurrentEntities)
		return
	end
	timer.Simple(0.1,function() if IsValid(self) then if self.SingleSpawner == true then self:DoSingleSpawnerRemove() end end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	if self:GetModel() == "models/error.mdl" then
	self:SetModel(VJ_PICKRANDOMTABLE(self.Model)) end
	self.uniqueId = tostring(self:GetCreationID())
	if self.spawnSingle == 1 then self.TimedSpawn_OnlyOne = true -- If it's true then it will only have one SNPC spawned at a time
	elseif self.spawnSingle == 0 then self.TimedSpawn_OnlyOne = false
	end
	self:SetSequence("idleOpen")
	self.EntitiesToSpawn = {	{EntityName = "",SpawnPosition = {vForward=175,vRight=0,vUp=0},Entities = {self.whatToSpawn}}}
	if (GetConVarString("vjstool_sentinelemitter_spawnType") == "npc_vj_sent_H2EnforcerShielded" or GetConVarString("vjstool_sentinelemitter_spawnType") == "npc_vj_sent_H2EnforcerUnshielded") then
		self.EntitiesToSpawn = {	{EntityName = "",SpawnPosition = {vForward=175,vRight=0,vUp=0},Entities = {GetConVarString("vjstool_sentinelemitter_spawnType")}}}
		self:SetModelScale(2, 0)
		self:Activate()
	elseif ((GetConVarString("vjstool_sentinelemitter_spawnType")) == "npc_vj_sent_RandomSentinel") then
		self.EntitiesToSpawn = {	{EntityName = "",SpawnPosition = {vForward=175,vRight=0,vUp=0},Entities = {GetConVarString("vjstool_sentinelemitter_spawnType")}}}
	elseif (GetConVarString("vjstool_sentinelemitter_spawnType") == "npc_vj_sent_H2Constructor" || GetConVarString("vjstool_sentinelemitter_spawnType") == "npc_vj_sent_H3AutoTurret") then
		self:SetModelScale(0.3, 0)
		self.EntitiesToSpawn = {	{EntityName = "",SpawnPosition = {vForward=100,vRight=0,vUp=0},Entities = {GetConVarString("vjstool_sentinelemitter_spawnType")}}}
	else
		self:SetModelScale(1, 0)
	end
	self:SetHealth(self.StartHealth)
	self:SetMaxHealth(self:Health())
	self:DrawShadow(false)
	self:SetNoDraw(false)
	self:SetNotSolid(false)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:GetPhysicsObject():EnableMotion(false)
	self.CurrentEntities = {}
	self:CustomOnInitialize_BeforeNPCSpawn()
	self.NumberOfEntitiesToSpawn =  table.Count(self.EntitiesToSpawn)
	for k,v in ipairs(self.EntitiesToSpawn) do self:SpawnAnEntity(k,v,true) end
	self:CustomOnInitialize_AfterNPCSpawn()
end
// lua_run for k,v in ipairs(ents.GetAll()) do if v.IsVJBaseSpawner == true then v.VJBaseSpawnerDisabled = false end end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	local countAlive = 0
	if (self:GetSequence()==1) then
		self.canBeDamaged=true
	else
		self.canBeDamaged=false
	end
	for k,v in ipairs(self.CurrentEntities) do //utilize this later
		if IsValid(v.TheEntity) then
			countAlive = countAlive + 1
		end
	end
	if self.Dead == true then VJ_STOPSOUND(self.CurrentIdleSound) return end
	if self.VJBaseSpawnerDisabled == true then self.AlreadyDoneVJBaseSpawnerDisabled = false end
	//PrintTable(self.CurrentEntities)
	//print("-----------------------------------------------------------")
	self:CustomOnThink_BeforeAliveChecks()
	self:IdleSoundCode()
	
	/*if self.VJBaseSpawnerDisabled == false && self.AlreadyDoneVJBaseSpawnerDisabled == false && table.Count(self.CurrentEntities) < self.NumberOfEntitiesToSpawn then
		self.AlreadyDoneVJBaseSpawnerDisabled = true
		for k,v in ipairs(self.EntitiesToSpawn) do self:SpawnAnEntity(k,v) end
	end*/
	
	if self.VJBaseSpawnerDisabled == false && self.SingleSpawner == false then
		for k,v in ipairs(self.CurrentEntities) do
			if /*!IsValid(v.TheEntity) &&*/v.Dead == false && #ents.FindByClass(self.whatToSpawn) < self.maxActive /*&& v.NextTimedSpawnT < CurTime()*/ then
				if countAlive >= self.perSpawner then return end
				v.Dead = true
				timer.Simple(self.TimedSpawn_Time - 2.5, function() 
					if IsValid(self) then 
						self:SetSequence("idleOpen") 
						self:EmitSound(Sound("obj_vj_sent_spawner/sentinel_emitter1.wav"))
						self:SetHate(true) 
					end 
				end)
				timer.Simple(self.TimedSpawn_Time,function() 
					if IsValid(self) && !self.VJBaseSpawnerDisabled then 
						/*table.remove(self.CurrentEntities,k)*/ 
						self:SpawnAnEntity(k,v,false) 
					end 
				end)
			end
		end
	end
	self:CustomOnThink_AfterAliveChecks()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:IdleSoundCode()
	if self.HasIdleSounds == false then return end
	if CurTime() > self.NextIdleSoundT then
		local randomidlesound = math.random(1,self.IdleSoundChance)
		if randomidlesound == 1 /*&& self:VJ_IsPlayingSoundFromTable(self.SoundTbl_Idle) == false*/ then
			self.CurrentIdleSound = VJ_CreateSound(self,self.SoundTbl_Idle,self.IdleSoundLevel,math.random(self.IdleSoundPitch1,self.IdleSoundPitch2))
		end
		self.NextIdleSoundT = CurTime() + math.Rand(self.NextSoundTime_Idle1,self.NextSoundTime_Idle2)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnEntitySoundCode()
	if self.HasIdleSounds == false then return end
	local randomidlesound = math.random(1,self.SpawnEntitySoundChance)
	if randomidlesound == 1 /*&& self:VJ_IsPlayingSoundFromTable(self.SoundTbl_Idle) == false*/ then
		self.CurrentSpawnEntitySound = VJ_CreateSound(self,self.SoundTbl_SpawnEntity,self.SpawnEntitySoundLevel,math.random(self.SpawnEntitySoundPitch1,self.SpawnEntitySoundPitch2))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoSingleSpawnerRemove()
	for k,v in ipairs(self.CurrentEntities) do
		if IsValid(v.TheEntity) && self:GetCreator() != nil then
			//cleanup.ReplaceEntity(self,v.TheEntity)
			//undo.ReplaceEntity(self,v.TheEntity)
			undo.Create(v.TheEntity:GetName())
			undo.AddEntity(v.TheEntity)
			undo.SetPlayer(self:GetCreator())
			undo.Finish()
		end
	end
	self.Dead = true
	VJ_STOPSOUND(self.CurrentIdleSound)
	self:Remove()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self:CustomOnRemove()
	self.Dead = true
	VJ_STOPSOUND(self.CurrentIdleSound)
	/*if self.SingleSpawner == false && self.CurrentEntities != nil then
		for k,v in ipairs(self.CurrentEntities) do
			if IsValid(v.TheEntity) && v.TheEntity then v.TheEntity:Remove() end
		end
	end
	*/
end
/*--------------------------------------------------
	=============== Spawner Base ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to make spawners.
--------------------------------------------------*/