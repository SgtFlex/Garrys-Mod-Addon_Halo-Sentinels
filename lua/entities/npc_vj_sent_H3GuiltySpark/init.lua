AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_H3Aggressor/init.lua')
include('shared.lua')
ENT.models = {
	BaseModel = "models/sentinels/sentinel_343GS.mdl",
	CorpseModel = "models/sentinels/sentinel_343GS.mdl",
	ShieldModel = "models/hunter/misc/sphere075x075.mdl",
}
ENT.Model = ENT.models["BaseModel"]
ENT.flyVars = {
	minRadiusAroundTarget = 300,
	maxRadiusAroundTarget = 800,
	minHeightAboveTarget = 250, //How far above should we aim to be above the target
	maxHeightAboveTarget = 400, //How far above should we aim to be above the target
	maxPitch = 40,
	maxRoll = 40,
	DecelerationTime = 1,
	AccelerationTime = 1,
	minTravelTime = 1,
	maxTravelTime = 5
}
ENT.defensiveStats = {
	shieldMax = 300,
	shieldCurrent = 300,
	shieldRegen = 5,
	shieldSpeed = .1,
	shieldDelay = 8,
	hullMax = 300,
	hullCurrent = 300,
	hullArmor = 0,
}
ENT.StartHealth = ENT.defensiveStats["hullMax"] + ENT.defensiveStats["shieldMax"]//GetConVarNumber("vj_dum_dummy_h")
ENT.attackStats = {
	damage = 225,
	beamDuration = 1.5,
	beamTickRate = 0.045,
	reload = 2,
}
ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.canFireAbove = true
ENT.Aerial_AnimTbl_Calm = {"idle"}
ENT.SoundTbl_IdleDialogue = {"343GS/dialogue/idle/idle1.wav","343GS/dialogue/idle/idle2.wav","343GS/dialogue/idle/idle3.wav","343GS/dialogue/idle/idle4.wav","343GS/dialogue/idle/idle5.wav","343GS/dialogue/idle/idle6.wav","343GS/dialogue/idle/idle7.wav"}
ENT.SoundTbl_OnPlayerSight = {"343GS/dialogue/greet/grt1.wav","343GS/dialogue/greet/grt2.wav","343GS/dialogue/greet/grt3.wav","343GS/dialogue/greet/grt4.wav","343GS/dialogue/greet/grt5.wav",}
ENT.SoundTbl_Alert = {"343GS/dialogue/combatStart/combat1.wav","343GS/dialogue/combatStart/combat2.wav","343GS/dialogue/combatStart/combat3.wav","343GS/dialogue/combatStart/combat4.wav","343GS/dialogue/combatStart/combat5.wav"}
ENT.SoundTbl_BecomeEnemyToPlayer = {"343GS/dialogue/friendlyFireTurn/ffTurn1.wav","343GS/dialogue/friendlyFireTurn/ffTurn2.wav","343GS/dialogue/friendlyFireTurn/ffTurn3.wav","343GS/dialogue/friendlyFireTurn/ffTurn4.wav","343GS/dialogue/friendlyFireTurn/ffTurn5.wav","343GS/dialogue/friendlyFireTurn/ffTurn6.wav","343GS/dialogue/friendlyFireTurn/ffTurn7.wav","343GS/dialogue/friendlyFireTurn/ffTurn8.wav"}
ENT.SoundTbl_DamageByPlayer = {"343GS/dialogue/friendlyFire/ff1.wav","343GS/dialogue/friendlyFire/ff2.wav","343GS/dialogue/friendlyFire/ff3.wav","343GS/dialogue/friendlyFire/ff4.wav","343GS/dialogue/friendlyFire/ff5.wav","343GS/dialogue/friendlyFire/ff6.wav","343GS/dialogue/friendlyFire/ff7.wav","343GS/dialogue/friendlyFire/ff8.wav","343GS/dialogue/friendlyFire/ff9.wav","343GS/dialogue/friendlyFire/ff10.wav","343GS/dialogue/friendlyFire/ff11.wav","343GS/dialogue/friendlyFire/ff12.wav","343GS/dialogue/friendlyFire/ff13.wav","343GS/dialogue/friendlyFire/ff14.wav"}
ENT.SoundTbl_AllyDeath = {"343GS/dialogue/allydeath/allyDeath1.wav", "343GS/dialogue/allydeath/allyDeath2.wav", "343GS/dialogue/allydeath/allyDeath3.wav", "343GS/dialogue/allydeath/allyDeath4.wav"}
ENT.SoundTbl_MoveOutOfPlayersWay = {"343GS/dialogue/bump/bump1.wav","343GS/dialogue/bump/bump2.wav","343GS/dialogue/bump/bump3.wav","343GS/dialogue/bump/bump4.wav","343GS/dialogue/bump/bump5.wav","343GS/dialogue/bump/bump6.wav","343GS/dialogue/bump/bump7.wav"}
ENT.soundTable = {
	engineSoundObject = "",
	firingSoundObject = "",
	engineSound = "343GS/misc/loopMove.wav",
	enginePitch = 100,
	engineVolume = 0.4,
	firingSound = "343GS/weapon/GSWeaponLoop.wav",
	firingPitch = 100,
	firingVolume = 1,
	firingIn = "343GS/weapon/GSWeaponIn.wav",
	firingOut = "343GS/weapon/GSWeaponOut.wav"
}
ENT.spriteTrail = {
	Object = "",
	startWidth = 20,
	endWidth = 0,
	lifetime = 0.5
}
ENT.Colors = {
	modelColor = Color(255, 255, 255, 255),
	shieldColor = Color(255, 255, 255, 255),
	corpseColor = Color(100, 100, 100, 255),
	trailColor = Color(100,170,225,150)
}
ENT.lights = {
	HeadLight = {Object = "", Attachment = "", Color = "0 155 255", Scale = .25, Offset = Vector(9, 0, 0)},
}
ENT.AllyDeathSoundChance = 1.2
ENT.HasIdleDialogueSounds = true
ENT.IdleSoundChance = 1
ENT.ItemDropsOnDeath_EntityList = {}
ENT.SoundTbl_Death = {"343GS/dialogue/death/DeathExplosion.wav"}
ENT.gibTable = {
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/gibs/metal_gib5.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
"models/combine_helicopter/bomb_debris_3.mdl",
"models/combine_helicopter/bomb_debris_3.mdl"
}
ENT.maxPitch = 0
ENT.maxRoll = 0
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.DisableDefaultMeleeAttackDamageCode = true -- Disables the default melee attack damage code
ENT.MeleeAttackDistance = 600 -- How close does it have to be until it attacks?
ENT.NextMeleeAttackTime = 0.05 -- How much time until it can use a melee attack?
ENT.MeleeAttackAnimationAllowOtherTasks = true -- If set to true, the animation will not stop other tasks from playing, such as chasing | Useful for gesture attacks!
ENT.DisableMeleeAttackAnimation = true -- if true, it will disable the animation code
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code
ENT.MeleeAttackReps = 5 -- How many times does it run the melee attack code?


function ENT:TypeOfDeath()
	self.fall=true
	self.timeDeath=true
	if (math.random(0, 100)) <=  GetConVar("vj_sent_chanceGib"):GetInt() then self.gib=true end
	if (math.random(0, 100)) <=  GetConVar("vj_sent_chanceRandomFire"):GetInt() then self.randomFire=true end
	if (math.random(0, 100)) <=  GetConVar("vj_sent_chanceFire"):GetInt() then self.ignite=true end
end


function ENT:VariantCode()
	if (GetConVarNumber("vj_sent_GSArmed")==0) then
		self.HasRangeAttack = false
	end
end


function ENT:CustomWhenBecomingEnemyTowardsPlayer(dmginfo,hitgroup) 
self.SoundTbl_DamageByPlayer = {"343GS/dialogue/hurtByPlayer/hurtP1.wav","343GS/dialogue/hurtByPlayer/hurtP2.wav","343GS/dialogue/hurtByPlayer/hurtP3.wav","343GS/dialogue/hurtByPlayer/hurtP4.wav","343GS/dialogue/hurtByPlayer/hurtP5.wav","343GS/dialogue/hurtByPlayer/hurtP6.wav","343GS/dialogue/hurtByPlayer/hurtP7.wav"}
self.NextSoundTime_DamageByPlayer1 = 5
self.NextSoundTime_DamageByPlayer2 = 8
end

function ENT:DamageByPlayerCode(dmginfo,hitgroup)
	if self.HasDamageByPlayer == true && CurTime() > self.NextDamageByPlayerT && GetConVarNumber("ai_disabled") == 0 then
		local theattack = dmginfo:GetAttacker()
		if theattack:IsPlayer() && self:Visible(theattack) then
			-- if self.DamageByPlayerDispositionLevel == 1 && self:Disposition(theattack) != D_LI && self:Disposition(theattack) != D_NU then return end
			-- if self.DamageByPlayerDispositionLevel == 2 && (self:Disposition(theattack) == D_LI or self:Disposition(theattack) == D_NU) then return end
			self:CustomOnDamageByPlayer(dmginfo,hitgroup)
			self:DamageByPlayerSoundCode()
			self.NextDamageByPlayerT = CurTime() + math.Rand(self.DamageByPlayerTime.a,self.DamageByPlayerTime.b)
		end
	end
end

function ENT:FallDeath() //Make NPC limp and fall to their death
	self:AddEFlags(EFL_NO_THINK_FUNCTION)
	local moreVelocity = 5
	self.enableAI=false
	self:StopMoving()
	self:SetSchedule(73)
	self:AddCallback("PhysicsCollide", function()
		if (self.dead && !self.timeDeath) then
			self:TakeDamage(99999, attacker)
			util.ScreenShake( self:GetPos(), 50, 500, 1.2, 500 )
		elseif (self.dead && self.timeDeath) then
			if !(timer.Exists("destroy"..self.uniqueId)) then
				self:EmitSound("343GS/dialogue/death/preDeath.wav")
				self:EmitSound("343GS/dialogue/death/preDeathDialogueModified.wav")
				timer.Create("destroy"..self.uniqueId,4,1,function() if (IsValid(self)) then self:TakeDamage(99999, attacker) util.ScreenShake( self:GetPos(), 50, 500, 1.2, 500 ) end end)
			end
		end end)
	local effect = EffectData()
	if (IsValid(self.Trail)) then self.Trail:Remove() end
	if (GetConVarNumber("vj_sent_useParticles")==1) then timer.Create("FireFallFX"..self.uniqueId, 0.05, 300, function() if (IsValid(self) && self:GetVelocity().z<-100) then effect:SetOrigin(self:GetPos()) util.Effect("fireFallFX", effect) end end) end
	if (self.randomFire) then self:RandomFire() end
	self.CanFlinch = 0
	self.dead = true
	self:SetHealth(99999)
	self.RangeAttackReps = 0 //stop any current attacks
	self.ConstantlyFaceEnemy = false
	self.Behavior = VJ_BEHAVIOR_PASSIVE
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:GetPhysicsObject():Wake()
	self:GetPhysicsObject():AddAngleVelocity(Vector(math.random(0, 500), math.random(0, 500), math.random(0, 500)))
	self:GetPhysicsObject():AddVelocity(self.vAlive)
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
end

function ENT:CustomOnMeleeAttack_BeforeChecks(IsPropAttack,AttackDist,CustomEnt)
	for _, v in pairs(ents.FindInSphere(self:GetPos(), self.MeleeAttackDistance)) do
		if (v!=self and (v:IsNPC() or v:IsPlayer())) then
			if (self:Disposition(v)!=3) then
				if !(v:IsOnGround()) then
					v:SetVelocity((v:GetPos()-self:GetPos())*1.5)
				else
					v:SetVelocity((v:GetPos()-self:GetPos())*400)
				end
			end
		end
	end
end