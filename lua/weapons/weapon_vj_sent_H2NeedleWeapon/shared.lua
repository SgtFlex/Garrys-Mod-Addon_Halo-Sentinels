if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "(H2) Needle Weapon"
SWEP.Author 					= "DrVrej"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "Halo Sentinels"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/c_irifle.mdl"
SWEP.WorldModel					= "models/sentinels/sentinel_gun.mdl" -- The world model (Third person, when a NPC is holding it, on ground, etc.)
SWEP.HoldType 					= "ar2" -- List of holdtypes are in the GMod wiki
SWEP.Reload_TimeUntilFinished	= 2 -- How much time until the player can play idle animation, shoot, etc.
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
SWEP.Primary.DisableBulletCode	= true -- The bullet won't spawn, this can be used when creating a projectile-based weapon

	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= 0.1 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0 -- This is added on top of the custom spread that's set inside the SNPC! | Starting from 1: Closer to 0 = better accuracy, Farther than 1 = worse accuracy

	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 0	 -- Damage
SWEP.Primary.ClipSize			= 40 -- Max amount of bullets per clip
SWEP.Primary.Tracer				= 1
SWEP.Primary.Recoil				= 0 -- How much recoil does the player get?
SWEP.Primary.Force				= 2 -- Force applied on the object the bullet hits
SWEP.Primary.TakeAmmo			= 1 -- How much ammo should it take on each shot?
SWEP.Primary.Ammo				= "SMG1" -- Ammo type
SWEP.Primary.DisableBulletCode	= true -- The bullet won't spawn, this can be used when creating a projectile-based weapon
SWEP.Primary.Sound				= {} -- npc/roller/mine/rmine_explode_shock1.wav
SWEP.Primary.Delay				= 0.1 -- Time until it can shoot again

SWEP.uniqueId = 0
SWEP.variantColor = Color(255, 255, 255, 255)
SWEP.DeploySound = {"weapons/draw_rifle.wav"}
SWEP.damage = 70

function SWEP:CustomOnInitialize()
	self:SetColor(self.variantColor)
end

function SWEP:CustomOnPrimaryAttackEffects()
	local bolt = ents.Create("obj_vj_sent_bolt")
	bolt:SetPos(self:GetOwner():GetPos() + self:GetOwner():OBBCenter() + Vector(0, 0, 20) + self:GetOwner():GetForward()*15)
	bolt:Spawn()
	if (self:GetOwner():IsNPC()) then
	bolt:GetPhysicsObject():SetVelocity((self:GetOwner():GetAimVector()-Vector(0,0,0.08))*1000)
	else
		bolt:GetPhysicsObject():SetVelocity((self:GetOwner():GetAimVector())*1000)
	end
	bolt:SetOwner(self)
end