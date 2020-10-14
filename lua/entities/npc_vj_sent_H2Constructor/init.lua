AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_H3Aggressor/init.lua')
include('shared.lua')
ENT.canFireAbove=true
ENT.Aerial_FlyingSpeed_Calm = 450 -- The speed it should fly with, when it's wandering, moving slowly, etc. | Basically walking campared to ground SNPCs
ENT.Aerial_FlyingSpeed_Alerted = 450 --
ENT.RangeDistance = 500
ENT.Behavior = VJ_BEHAVIOR_AGGRESSIVE
ENT.shieldRegen = false
ENT.lights = {
	EngineLight = {Object = "", Attachment = "root", Color = "200 240 240", Scale = .1, Offset = Vector(-3, 0, 0)},
	HeadLight = {Object = "", Attachment = "head", Color = "0 155 255", Scale = .1, Offset = Vector(5, 0, 4)}
}
ENT.limbs = {
	head = 			{Removed = false, Health = 10, Lights = {"HeadLight"}, Hitgroup = 501, Bodygroups = {"head"}, Gibs = {"models/gibs/metal_gib5.mdl", "models/gibs/metal_gib5.mdl", "models/gibs/metal_gib5.mdl"}},
}
ENT.models = {
	BaseModel = "models/sentinels/h2constructor.mdl",
	CorpseModel = "models/sentinels/h2constructor.mdl",
	ShieldModel = "models/sentinels/sentinel_a_shield.mdl",
}
ENT.Model = ENT.models["BaseModel"]
ENT.flyVars = {
	minRadiusAroundTarget = 100,
	maxRadiusAroundTarget = 350,
	minHeightAboveTarget = 150, //How far above should we aim to be above the target
	maxHeightAboveTarget = 300, //How far above should we aim to be above the target
	maxPitch = 40,
	maxRoll = 40,
	DecelerationTime = 1,
	AccelerationTime = 0.3,
	minTravelTime = 0.5,
	maxTravelTime = 2
}
ENT.defensiveStats = {
	shieldMax = 0,
	shieldCurrent = 0,
	shieldRegen = 1,
	shieldSpeed = .1,
	shieldDelay = 5,
	hullMax = 30,
	hullCurrent = 30,
	hullArmor = 0,
}
ENT.StartHealth = ENT.defensiveStats["hullMax"] + ENT.defensiveStats["shieldMax"]//GetConVarNumber("vj_dum_dummy_h")
ENT.spriteTrail = {
	Object = "",
	startWidth = 15,
	endWidth = 0,
	lifetime = 2
}
ENT.ItemDropsOnDeath_EntityList = {}
ENT.soundTable = {
	engineSoundObject = "",
	engineSound = "npc_vj_sent_sentinel/sent_eng1loop.wav",
	enginePitch = 125,
	engineVolume = 0.1,
	firingSoundObject = "",
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
ENT.attackStats = {
	damage = 45,
	beamDuration = 1.5,
	beamTickRate = 0.045,
	reload = 2,
}
ENT.ItemDropsOnDeath_EntityList = {"weapon_vj_sent_sentinelbeamrepair"}
ENT.ConstantlyFaceEnemy = false
ENT.AA_ConstantlyMove = false

local timeBetween = 10
local canConstruct = true
ENT.lightColors = {
	"0 180 200"
}
ENT.lightPositions = { //Use attachments instead of just positions in future update
	Vector(3, 0, 7)
}
ENT.lightScales = {
	.1
}

function ENT:VariantCode()
	hook.Add("Think", "ConstructTimer"..self.uniqueId, function() 
		if ((#ents.FindByClass("obj_vj_sent_spawner") < GetConVarNumber("vjstool_construct_sentinelemitter_maxEmitters"))) then
			self.Behavior = VJ_BEHAVIOR_PASSIVE
			canConstruct = true
		else
			self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
			canConstruct = false
		end
		if ((math.fmod(math.Round(CurTime(), 0), math.random(10, 20)) == 0) && IsValid(self)) then 
			self:Construct() 
		end 
	end)
end

local checkForEnts = 0
local cooldown = 10
ENT.isConstructing = false
function ENT:Construct()
		local traceConstruct = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() + self:GetForward()*300 + Vector(math.random(-100, 100), math.random(-100, 100), 0),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY,
		ignoreworld = false
	})
		local HullTrace = util.TraceHull({
		start = traceConstruct.HitPos + traceConstruct.HitNormal*70,
		endpos = traceConstruct.HitPos + traceConstruct.HitNormal*70,
		mins = Vector(-60, -60, -60),
		maxs = Vector(60, 60, 60),
		mask = MASK_NPCSOLID,
		ignoreworld = false
		})

	if (canConstruct && self.isConstructing==false && traceConstruct.Hit && ((traceConstruct.HitPos:DistToSqr(self:GetPos())) > 700) && traceConstruct.HitPos.z <= 2000) then
		if (#ents.FindByClass("obj_vj_sent_spawner") < GetConVarNumber("vjstool_construct_sentinelemitter_maxEmitters")) && (HullTrace.Hit == false) then
		self.isConstructing = true
		local EmitterSpawnPos = traceConstruct.HitPos + traceConstruct.HitNormal*70
		debugoverlay.Box(EmitterSpawnPos, Vector(-60, -60, -60), Vector(60, 60, 60), 20, Color(255, 255, 255, 0))
		self:Decelerate()
		self:StopMoving()
		self:SetSchedule(73)
		self:BeamThing(true)
		self:SetNWVector("SentinelBeam1", traceConstruct.HitPos)
		if (traceConstruct.Hit==true) then
		timer.Create("stopBeam"..self.uniqueId, 5, 1, function() 
			local SpawnBox = util.TraceHull({
			start = EmitterSpawnPos,
			endpos = EmitterSpawnPos,
			mins = Vector(-60, -60, -60),
			maxs = Vector(60, 60, 60),
			mask = MASK_NPCSOLID,
			ignoreworld = false
			})
			if (IsValid(self) && SpawnBox.Hit==false) then
				local emitter = ents.Create("obj_vj_sent_spawner")
				emitter:SetPos(traceConstruct.HitPos)
				emitter:SetAngles(traceConstruct.HitNormal:Angle())
				emitter.StartHealth = GetConVarNumber("vjstool_construct_sentinelemitter_healthEmitter")
				emitter.TimedSpawn_Time = GetConVarNumber("vjstool_construct_sentinelemitter_spawnDelay")
				emitter.maxActive = GetConVarNumber("vjstool_construct_sentinelemitter_maxActive")
				emitter.whatToSpawn = GetConVarString("vjstool_construct_sentinelemitter_spawnType")
				emitter.damageOnlyWhenOpen = GetConVarNumber("vjstool_construct_sentinelemitter_damageOnlyWhenOpen")
				emitter.canBeTargeted = GetConVarNumber("vjstool_sentinelemitter_canBeTargeted")
				emitter.perSpawner = GetConVarNumber("vjstool_construct_sentinelemitter_maxActivePerSpawner")
				emitter:Spawn() 
				local effectdata = EffectData()
				effectdata:SetOrigin(traceConstruct.HitPos)
				util.Effect( "HelicopterMegaBomb", effectdata )
				util.Effect( "ThumperDust", effectdata )
				util.Effect( "VJ_Small_Explosion1", effectdata )
		end
		self:SetSchedule(68)
		self:BeamThing(false)
		 end)
		timer.Create("CDTimer"..self.uniqueId, cooldown, 1, function() if IsValid(self) then self.isConstructing = false end end)
	end
		end
	end
end

function ENT:CustomOn_PoseParameterLookingCode(pitch,yaw,roll) //helicopter-like movement, finally working!
	if (!IsValid(self) or self.dead or (!IsValid(self:GetEnemy()))) then return end
	if (canConstruct) then return end
	if (self.VJ_IsBeingControlled) then return end
	if (self:GetVelocity():Length() <= 0) then return end
	if (self:GetAimVector():Length() <= 0) then return end
	if (self:GetVelocity():Length() > 0) then
		local forwardFlat = Vector(self:GetVelocity().x, self:GetVelocity().y, 0) + Vector(1, 1, 0)
		local rightOrLeft = 1
		local aimFlat = Vector(self:GetAimVector().x, self:GetAimVector().y, 0) Vector(1.1, 1, 0) //adding something stops a nil math error, needs fixing
		if ((forwardFlat:Cross(aimFlat)).z > 0) then
			rightOrLeft = 1
		elseif ((forwardFlat:Cross(aimFlat)).z <= 0) then
			rightOrLeft = -1
		end
		local totResult = math.deg(math.acos((forwardFlat:Dot(aimFlat))/(forwardFlat:Length()*aimFlat:Length())))
		self:SetAngles(Angle(math.Clamp((self:GetAngles().x + self:Lerp3(totResult/180, self.flyVars["maxPitch"], 0, -self.flyVars["maxPitch"])), -self.flyVars["maxPitch"], self.flyVars["maxPitch"]), self:GetAngles().y, (self:GetAngles().z + self:Lerp3((totResult)/180, 0, self.flyVars["maxRoll"]*rightOrLeft, 0)), -self.flyVars["maxRoll"], self.flyVars["maxRoll"]))
	end
end