ESX = exports["es_extended"]:getSharedObject()
local preso = false


Citizen.CreateThread(function()
    local model = 's_f_y_cop_01'
    lib.requestModel(model)

    npc = CreatePed(4, model, 454.0437, -980.2996, 29.6896, 86.3776, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local PlayerData = {}

AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local PlayerData = {}

AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterCommand('testJob', function()
    print(PlayerData.job.name)
end)

exports.ox_target:addSphereZone({
    coords = vec3(454.0437, -980.2996, 30.6896), -- Aggiungi le coords
    size = vec3(0.5, 0.5, 0.5),
    radius = 0.7,
    rotation = 45,
    debug = false,
    options = {
        {
            icon = 'fa-solid fa-gun', 
            label = 'Dai armi',
            onSelect = function(data)
                local player = ESX.GetPlayerData()
                local job = Config.Job

               for k,v in pairs(job) do 
                    if player.job.name == v then 
                        TriggerEvent('Christian:Daiequipaggiamento') -- Evento tuo
                    end
                end
                
            end
        }
    }
})

RegisterNetEvent('Christian:Daiequipaggiamento')
AddEventHandler('Christian:Daiequipaggiamento', function(source)
    if preso then 
        lib.notify({
            title = 'Server',
            description = 'Hai già preso l\'equipaggiamento!',
            type = 'error'
        }) 
    else 
        TriggerServerEvent('ChristianDaiArmi')  
        preso = true

        ESX.SetTimeout(Config.TimeOut, function()
            preso = false
          end)
    end 
end)

