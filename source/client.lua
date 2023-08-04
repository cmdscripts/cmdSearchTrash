local trash = false
local wait = false
local usedTrashBins = {}

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
                local trashBinID = tostring(object)

                if dist <= 2 then
                    sleep = 0
                    if Config.DrawMarker then
                        DrawMarker(0, coords.x, coords.y, coords.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 20, 20, 180, false, true, p19, false)
                    end

                    if Config.HelpNotificationAllow then
                        ESX.ShowHelpNotification("~INPUT_CONTEXT~ Search the garbage")
                    end

                    if IsControlJustPressed(1, 51) then
                        if CheckIfUsed(object) then
                            UseTrashBin(object)
                        else 
                            ESX.ShowNotification("The trash can is empty")
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function UseTrashBin(object)
    print("Control pressed")
    loadAnimDict("mini@repair")
    TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 2.0, 2.0, -1, 1, 0, false, false, false)
    Wait(5000)
    ClearPedTasks(PlayerPedId())
    SearchTrash()
    print(SearchTrash)

    local TmpData = {
        Id = object,
        Time = Config.Wait
    }
    table.insert(usedTrashBins, TmpData)
end

CreateThread(function ()
    while true do
        for k, v in ipairs(usedTrashBins) do
            if v.Time >= 1 then
                DeleteTrashBinFromTable(v.Id)
            else 
                v.Time = v.Time - 1 
            end
        end
        Wait(60000)
    end
end)

function DeleteTrashBinFromTable(Trashbin)
    for k, v in ipairs(usedTrashBins) do
        if v.Id == Trashbin then
            table.remove(usedTrashBins, k)
            return
        end
    end

    print(TrashBin, usedTrashBins, k)
end

function CheckIfUsed(TrashBin)
    for k, v in ipairs(usedTrashBins) do
        if v.Id == TrashBin then
            return false
        end
    end

    return true
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

function debugPrint(msg)
    if Config.Debug then
        print(msg)
    end
end