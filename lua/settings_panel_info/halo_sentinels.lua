return {
    name = "[VJ] Halo Sentinels", --ONLY APPLIES TO ROOT NODE. If provided, the root node will be named this. Otherwise it will use the filename
    icon = "icons/halo_icon_24.png", --The icon for the root node
    subtree = {
        ["Settings"] = { --An example with all possible table values filled so you know what you can work with
            --for example: Try searching "test"  and this node will come up since "test" resembles "tester", which is one of this node's tags
            controls = {
                ["343 Guilty Spark is Armed"] = {
                    convar = "vj_sent_GSArmed", --The name of the convar you wish to use. Make sure it's unique!
                    default = 1, --The default value used when the convars(Console variables) are created
                    desc = "Whether Guilty Spark is armed with a weapon", --Tooltip displayed on hover
                    panel = {type = "DCheckBox"},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                    tags = {"GS", "lightbulb"}, --When searching controls, this control will be displayed if part of the search term resembles one of these tags
                    
                },
                ["Sentinels friendly"] = {
                    convar = "vj_sent_sentinelsFriendly", --The name of the convar you wish to use. Make sure it's unique!
                    default = 1, --The default value used when the convars(Console variables) are created
                    desc = "Whether sentinels are allied or not", --Tooltip displayed on hover
                    panel = {type = "DCheckBox"},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                    tags = {"ally", "allied"}, --When searching controls, this control will be displayed if part of the search term resembles one of these tags
                },
                ["Sentinels drop weapons"] = {
                    convar = "vj_sent_sentinelsDropWeapon", --The name of the convar you wish to use. Make sure it's unique!
                    default = 1, --The default value used when the convars(Console variables) are created
                    desc = "Whether sentinels drop weapons or not", --Tooltip displayed on hover
                    panel = {type = "DCheckBox"},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                    tags = {"guns", "lightbulb"}, --When searching controls, this control will be displayed if part of the search term resembles one of these tags
                },
                ["Spawn Particle FX"] = {
                    convar = "vj_sent_useParticles", --The name of the convar you wish to use. Make sure it's unique!
                    default = 1, --The default value used when the convars(Console variables) are created
                    desc = "Can save performance by not using any particles.", --Tooltip displayed on hover
                    panel = {type = "DCheckBox"},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                },
                ["Sentinel Damage Modifier"] = {
                    convar = "vj_sent_sentinelDamageModifier", --The name of the convar you wish to use. Make sure it's unique!
                    default = 1, --The default value used when the convars(Console variables) are created
                    desc = "Multiplies sentinel damage by x", --Tooltip displayed on hover
                    panel = {type = "DNumberWang", decimals = 2},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                },
                ["[Death] Fall Chance"] = {
                    convar = "vj_sent_chanceFall", --The name of the convar you wish to use. Make sure it's unique!
                    default = 50, --The default value used when the convars(Console variables) are created
                    desc = "When sentinels die, % chance to fall instead of immediately blowing up.", --Tooltip displayed on hover
                    panel = {type = "DNumSlider", max = 100},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                },
                ["[Death] Ignite Chance"] = {
                    convar = "vj_sent_chanceFire", --The name of the convar you wish to use. Make sure it's unique!
                    default = 50, --The default value used when the convars(Console variables) are created
                    desc = "When sentinels die, % chance corpse will ignite.", --Tooltip displayed on hover
                    panel = {type = "DNumSlider", max = 100},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                },
                ["[Death] Gib Chance"] = {
                    convar = "vj_sent_chanceGib", --The name of the convar you wish to use. Make sure it's unique!
                    default = 50, --The default value used when the convars(Console variables) are created
                    desc = "When sentinels die, % chance sentinel will gib.", --Tooltip displayed on hover
                    panel = {type = "DNumSlider", max = 100},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                },
                ["[Death] Misfire Chance"] = {
                    convar = "vj_sent_chanceRandomFire", --The name of the convar you wish to use. Make sure it's unique!
                    default = 50, --The default value used when the convars(Console variables) are created
                    desc = "When sentinels die, % chance sentinel will misfire.", --Tooltip displayed on hover
                    panel = {type = "DNumSlider", max = 100},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                },
                ["[Death] Malfunction Chance"] = {
                    convar = "vj_sent_chanceTimedDeath", --The name of the convar you wish to use. Make sure it's unique!
                    default = 50, --The default value used when the convars(Console variables) are created
                    desc = "When sentinels die, % chance sentinel will turn into a bomb after a few seconds.", --Tooltip displayed on hover
                    panel = {type = "DNumSlider", max = 100},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                    tags = {"bomb", "timed"}, --When searching controls, this control will be displayed if part of the search term resembles one of these tags
                },
                ["Beam Tick Rate"] = {
                    convar = "vj_sent_beamTickRate", --The name of the convar you wish to use. Make sure it's unique!
                    default = 0.045, --The default value used when the convars(Console variables) are created
                    desc = "How often beams are fired. Lower # results in smoother beams, while a higher # results in laggier beams but less performance intensive.", --Tooltip displayed on hover
                    panel = {type = "DNumSlider", min = 0.001, max = 0.5, decimals = 3},
                    --The type of panel used for displaying this convar. The types supported are "DNumberWang", "DNumSlider", "DCheckBox", "DButton". 
                    --More will come in the future so check the changelog if you're looking for more
                },
            },
        },
    }
}
--convar REQUIRED per control (except DButton)
--default REQUIRED per control (except DButton)
--everything else is optional. Values will be autocompleted (like type will be autofilled to DNumberWang) or left out (like desc) if blank.
--DButton can execute code when clicked. Look at example above