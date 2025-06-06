local function getDiscordIdentifier(src)
    for _, v in ipairs(GetPlayerIdentifiers(src)) do
        if v:find("discord:") then
            return v:gsub("discord:", "")
        end
    end
    return nil
end

RegisterServerEvent("loadout:requestLoadout")
AddEventHandler("loadout:requestLoadout", function(loadoutName)
    local src = source
    local discordId = getDiscordIdentifier(src)
    if not discordId then
        TriggerClientEvent("loadout:notify", src, "❌ Discord not found. Make sure Discord is open.")
        return
    end

    local loadout = Config.Loadouts[loadoutName]
    if not loadout then
        TriggerClientEvent("loadout:notify", src, "❌ Loadout not found.")
        return
    end
    -- Links with Badger Discord API by default to aquire all roles that the user has.
    local roles = exports['Badger_Discord_API']:GetDiscordRoles(src)
    local hasRole = false

    if roles ~= nil then
        for _, role in ipairs(roles) do
            if tostring(role) == tostring(loadout.discordRoleId) then
                hasRole = true
                break
            end
        end
    end

    if hasRole then
        TriggerClientEvent("loadout:giveWeapons", src, loadout.weapons)
        if Config.Debug then
            print(("[DEBUG] %s received loadout %s."):format(GetPlayerName(src), loadoutName))
        end
    else
        TriggerClientEvent("loadout:notify", src, "🚫 You do not have permission to use this loadout.")
    end
end)
