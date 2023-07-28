local trash = false
local wait = false

function SearchTrash()
    local random = math.random(1, #Config.Item_List)
    local itemData = Config.Item_List[random]
    local item, count = itemData.item, itemData.count

    TriggerServerEvent('cmdSearchTrash:trash', item, count)
end

CreateThread(function()
    while true do
        local sleep = 1000

        local object, dist = ESX.Game.GetClosestObject()
        local model = GetEntityModel(object)
        local coords = GetEntityCoords(object)

        for k, v in pairs(Config.Props) do 
            if model == v.model then

                if dist <= 2 and wait == false then
                    sleep = 0
                    if Config.DrawMarker then
                        DrawMarker(0, coords.x, coords.y, coords.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 20, 20, 180, false, true, p19, false)
                    end
                end
                
                if dist <= 2 and wait == false then
                    sleep = 0
                    MSK.HelpNotification(Config.HelpNotification)
                    if IsControlJustPressed(1, 51) then
                        logging('debug', 'Control pressed') 
                        loadAnimDict("mini@repair")
                        if HasAnimDictLoaded("mini@repair") then
                            TaskPlayAnim(PlayerPedId(), "fixing_a_ped", 2.0, 2.0, -1, 1, 0, false, false, false)
                            Wait(5000)
                            ClearPedTasks(PlayerPedId())
                            SearchTrash()
                            wait = true
                            Wait(Config.Wait * 1000)
                            wait = false
                        else
                            logging('debug', 'Failed to load AnimDict: mini@repair')
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(10)
        end
    end
end

logging = function(code, ...)
    if Config.Debug then
        local script = "[^2"..GetCurrentResourceName().."^0]"
        MSK.logging(script, code, ...)
    end
end
