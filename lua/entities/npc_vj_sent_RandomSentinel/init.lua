AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {}
ENT.randomSpawn = ""
ENT.uniqueId = ""
ENT.VJ_NPC_Class = {"CLASS_SENTINEL", "CLASS_PLAYER_ALLY", "CLASS_HUMAN_PASSIVE", "CLASS_EARTH_FAUNA"} -- NPCs with the same class with be allied to each other

local tableOfSentinels = {
	"npc_vj_sent_H1Aggressor",
	"npc_vj_sent_H1AggressorMajor",
	"npc_vj_sent_H2Aggressor",
	"npc_vj_sent_H2AggressorMajor",
	"npc_vj_sent_H2AggressorNeedler",
	"npc_vj_sent_H2Constructor",
	"npc_vj_sent_H2Assembler",
	"npc_vj_sent_H2EnforcerUnshielded",
	"npc_vj_sent_H2EnforcerShielded",
	"npc_vj_sent_H3Aggressor",
	"npc_vj_sent_H3AggressorMajor",
	"npc_vj_sent_H3AutoTurret",
	"npc_vj_sent_H3GuiltySpark",
	"npc_vj_sent_HW1Aggressor",
	"npc_vj_sent_HW1AggressorMajor",
	"npc_vj_sent_HW1AttackProtector",
	"npc_vj_sent_HW1HealProtector",
	"npc_vj_sent_HW1ShieldProtector",
	"npc_vj_sent_HW1SuperSentinel"
}

local weightingSystem = {
		GetConVarNumber("vj_sent_H1AggressorWeight"),
		GetConVarNumber("vj_sent_H1AggressorMajorWeight"),
		GetConVarNumber("vj_sent_H2AggressorWeight"),
		GetConVarNumber("vj_sent_H2AggressorMajorWeight"),
		GetConVarNumber("vj_sent_H2AggressorNeedlerWeight"),
		GetConVarNumber("vj_sent_H2ConstructorWeight"),
		GetConVarNumber("vj_sent_H2AssemblerWeight"),
		GetConVarNumber("vj_sent_H2EnforcerUnshieldedWeight"),
		GetConVarNumber("vj_sent_H2EnforcerShieldedWeight"),
		GetConVarNumber("vj_sent_H3AggressorWeight"),
		GetConVarNumber("vj_sent_H3AggressorMajorWeight"),
		GetConVarNumber("vj_sent_H3AutoTurretWeight"),
		GetConVarNumber("vj_sent_H3GuiltySparkWeight"),
		GetConVarNumber("vj_sent_HW1AggressorWeight"),
		GetConVarNumber("vj_sent_HW1AggressorMajorWeight"),
		GetConVarNumber("vj_sent_HW1AttackProtectorWeight"),
		GetConVarNumber("vj_sent_HW1HealProtectorWeight"),
		GetConVarNumber("vj_sent_HW1ShieldProtectorWeight"),
		GetConVarNumber("vj_sent_HW1SuperSentinelWeight")
}



local randomSelection = 0
function ENT:CustomOnInitialize()
	self:UseConvars()
	self:SetMaxHealth(100)
	self:SetHealth(100)
	weightingSystem = {
		GetConVarNumber("vj_sent_H1AggressorWeight"),
		GetConVarNumber("vj_sent_H1AggressorMajorWeight"),
		GetConVarNumber("vj_sent_H2AggressorWeight"),
		GetConVarNumber("vj_sent_H2AggressorMajorWeight"),
		GetConVarNumber("vj_sent_H2AggressorNeedlerWeight"),
		GetConVarNumber("vj_sent_H2ConstructorWeight"),
		GetConVarNumber("vj_sent_H2AssemblerWeight"),
		GetConVarNumber("vj_sent_H2EnforcerUnshieldedWeight"),
		GetConVarNumber("vj_sent_H2EnforcerShieldedWeight"),
		GetConVarNumber("vj_sent_H3AggressorWeight"),
		GetConVarNumber("vj_sent_H3AggressorMajorWeight"),
		GetConVarNumber("vj_sent_H3AutoTurretWeight"),
		GetConVarNumber("vj_sent_H3GuiltySparkWeight"),
		GetConVarNumber("vj_sent_HW1AggressorWeight"),
		GetConVarNumber("vj_sent_HW1AggressorMajorWeight"),
		GetConVarNumber("vj_sent_HW1AttackProtectorWeight"),
		GetConVarNumber("vj_sent_HW1HealProtectorWeight"),
		GetConVarNumber("vj_sent_HW1ShieldProtectorWeight"),
		GetConVarNumber("vj_sent_HW1SuperSentinelWeight")
}
	local totalWeight = 0
	local spawnIndex = 0
	for k, v in pairs(weightingSystem) do
		totalWeight = totalWeight + v
	end
	randomSelection = math.random(0, totalWeight)
	for k, v in pairs(weightingSystem) do
			randomSelection = randomSelection - v
			spawnIndex = spawnIndex + 1
			if (randomSelection <= 0 && v>0) then break end
	end
	self.randomSpawn = ents.Create(tableOfSentinels[spawnIndex])
	self.randomSpawn:SetPos(self:GetPos())
	self.randomSpawn:SetAngles(self:GetAngles())
	self:SetParent(self.randomSpawn)
	self.randomSpawn:Spawn()
	self:SetNoDraw(true)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetNotSolid(true)
end

function ENT:CustomOnRemove()
	if (IsValid(self.randomSpawn)) then
		self.randomSpawn:Remove()
	end
end

function ENT:UseConvars()
	if (GetConVar("vj_sent_sentinelsDropWeapon"):GetInt() == 1) then
		self.HasItemDropsOnDeath = true
	elseif (GetConVar("vj_sent_sentinelsDropWeapon"):GetInt() == 0) then
		self.HasItemDropsOnDeath = false
	end
	if (GetConVar("vj_sent_sentinelsFriendly"):GetInt() == 1) then
		self.PlayerFriendly = true
		self.FriendsWithAllPlayerAllies = true
		self.VJ_NPC_Class = {"CLASS_SENTINEL", "CLASS_PLAYER_ALLY", "CLASS_HUMAN_PASSIVE", "CLASS_EARTH_FAUNA"} -- NPCs with the same class with be allied to each other

	elseif (GetConVar("vj_sent_sentinelsFriendly"):GetInt() == 0) then
		self.PlayerFriendly = false
		self.FriendsWithAllPlayerAllies = false
		self.VJ_NPC_Class = {"CLASS_SENTINEL", "CLASS_EARTH_FAUNA"}
		for _,v in pairs(ents.GetAll()) do
        if v:IsNPC() && (v.PlayerFriendly) then
        	if (string.StartWith(v:GetClass(), "npc_vj_sent")) then
            	table.insert(v.VJ_AddCertainEntityAsEnemy,self)
            	v:VJ_DoSetEnemy(self,true,true)
            	v:SetEnemy(self)
            end
        end
        //test code for making sentinels hunt each other
    end
	end
	if (GetConVar("vj_sent_useParticles"):GetInt() == 0) then
		spawnParticles = false
	elseif (GetConVar("vj_sent_useParticles"):GetInt() == 1) then
		spawnParticles = true
	end
end