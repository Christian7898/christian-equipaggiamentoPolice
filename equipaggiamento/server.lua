ESX = exports["es_extended"]:getSharedObject()

local function sendDiscordEmbed(webhookUrl, embedData)
    local embeds = {
        {
            ["title"] = embedData.title,
            ["description"] = embedData.description,
            ["color"] = embedData.color,
            ["fields"] = embedData.fields
        }
    }

    local data = {
        ["embeds"] = embeds
    }

    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('ChristianDaiArmi')
AddEventHandler('ChristianDaiArmi', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerName = GetPlayerName(_source)

    local playerIdentifiers = GetPlayerIdentifiers(_source)
    local discordId = nil
    local steamId = nil

    for _, identifier in ipairs(playerIdentifiers) do
        if string.match(identifier, "^discord:") then
            discordId = string.sub(identifier, 9)
            break
        end
    end

    for _, identifier in ipairs(playerIdentifiers) do
        if string.match(identifier, "^steam:") then
            steamId = string.sub(identifier, 8)
            break
        end
    end

    if xPlayer then
        for k,v in ipairs(Config.Equipaggiamento) do
            exports.ox_inventory:AddItem(xPlayer.source, v.item, v.amount)
        end
    end

    local embedData = {
        title = ''.." ha preso l'equipaggiamento!",
        description = playerName.. " ha preso l'equipaggiamento della polizia",
        color = 16711680, -- Colore rosso
        fields = {
            {name = "Giocatore: ", value = '<@'..discordId..'>', inline = false},
            {name = "Steam-HEX: ", value = steamId, inline = false},
            {name = "ID Giocatore: ", value = _source, inline = false},
            
        }
    }
    sendDiscordEmbed(Config.Webhook, embedData)
 
end)