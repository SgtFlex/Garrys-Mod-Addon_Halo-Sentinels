ENT.Base 			= "npc_vj_creature_base" -- List of all base types: https://github.com/DrVrej/VJ-Base/wiki/Base-Types
ENT.Type 			= "ai"
ENT.PrintName 		= "Sentinel"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Halo Sentinels"

if (CLIENT) then
	local Name = "(HW1) Healing Protector Sentinel SW0459"
	local LangName = "npc_vj_sent_HW1HealProtector"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end