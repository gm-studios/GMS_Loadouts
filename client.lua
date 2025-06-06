-- GMS_Loadouts (Standalone) -- Client side.


-- Making the command usable like so: /loadout mo19
RegisterCommand("loadout", function(source, args)
    local loadoutName = args[1]
    if not loadoutName then
        print("Usage: /loadout <loadoutName>")
        return
    end

    TriggerServerEvent("loadout:requestLoadout", loadoutName)
end, false)

-- Make even to give the weapons to player upon checking they have correct roles.
RegisterNetEvent("loadout:giveWeapons", function(weapons)
    for _, weapon in ipairs(weapons) do
        GiveWeaponToPed(PlayerPedId(), GetHashKey(weapon), 250, false, true)
    end
end)


-- Ability to add in custom notify functionality here.
RegisterNetEvent("loadout:notify", function(msg)
    print(msg) 
end)
