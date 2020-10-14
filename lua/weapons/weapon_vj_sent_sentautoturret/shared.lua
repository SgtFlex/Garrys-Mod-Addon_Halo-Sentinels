if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "(H3) Sentinel Auto Turret"
SWEP.Author 					= "DrVrej"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "Halo Sentinels"
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/sentinels/sentinel_turret.mdl"
SWEP.WorldModel					= "models/sentinels/sentinel_turret.mdl" -- The world model (Third person, when a NPC is holding it, on ground, etc.)
SWEP.HoldType 					= "ar2" -- List of holdtypes are in the GMod wiki
SWEP.Reload_TimeUntilFinished	= 2 -- How much time until the player can play idle animation, shoot, etc.
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
SWEP.Primary.DisableBulletCode	= true -- The bullet won't spawn, this can be used when creating a projectile-based weapon
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= 0.03 -- Next time it can use primary fire
SWEP.NPC_CustomSpread	 		= 0 -- This is added on top of the custom spread that's set inside the SNPC! | Starting from 1: Closer to 0 = better accuracy, Farther than 1 = worse accuracy

	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 0	 -- Damage
SWEP.Primary.ClipSize			= 1 -- Max amount of bullets per clip
SWEP.Primary.Tracer				= 1
SWEP.Primary.Recoil				= 0 -- How much recoil does the player get?
SWEP.Primary.Force				= 2 -- Force applied on the object the bullet hits
SWEP.Primary.TakeAmmo			= 1 -- How much ammo should it take on each shot?
SWEP.Primary.Automatic		= false
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Ammo				= "none" -- Ammo type
SWEP.Primary.DisableBulletCode	= false -- The bullet won't spawn, this can be used when creating a projectile-based weapon
SWEP.Primary.Sound				= {"npc_vj_sent_sentinel/sentinel_gun/sentrepeat.wav"} -- npc/roller/mine/rmine_explode_shock1.wav
SWEP.DrawAmmo = true

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"


-- Pick one of the following options! Delete the option that you have not selected!


-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base

function SWEP:PrimaryAttack(ShootPos,ShootDir)
	local turret = ents.Create("npc_vj_sent_h3autoturret")
	turret:SetPos(self:GetOwner():GetPos() + Vector(0, 0, 50) + self:GetOwner():GetForward() * 100)
	turret:SetAngles(self:GetOwner():GetAngles())
	turret:Spawn()
	self:Remove()

end