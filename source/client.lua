local trash = false
local wait = false

function SearchTrash()
	trash = true
	while trash do
		for k,v in pairs(Config.Item_List) do
			random = math.random(1, #Config.Item_List)
			id = v.id
			item = v.item
            count = v.count

			if random == id then
				trash = false
                TriggerServerEvent('cmdSearchTrash:trash', item, count)
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())
                break
			end
		end
		Wait(1000)
	end
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
                        TaskPlayAnim(PlayerPedId(), "fixing_a_ped", 2.0, 2.0, -1, 1, 0, false, false, false) -- "mini@repair",
                        logging('debug', 'TaskPlayAnim')
                        Wait(5000)
                        SearchTrash()
                        logging('debug', 'Function started')
                        wait = true
                        logging('debug', 'wait true')
                        Wait(Config.Wait * 1000)
                        wait = false
                        logging('debug', 'wait false')
                    end
                end

            end
        end
        Wait(sleep)
    end
end)

--

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

logging = function(code, ...)
    if Config.Debug then
        local script = "[^2"..GetCurrentResourceName().."^0]"
        MSK.logging(script, code, ...)
    end
end