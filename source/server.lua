RegisterNetEvent('cmdSearchTrash:trash')
AddEventHandler('cmdSearchTrash:trash', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem(item, count) then
        xPlayer.addInventoryItem(item, count)
        xPlayer.showNotification("Du hast " .. count .. " " .. ESX.GetItemLabel(item) .. " bekommen")
    else
        xPlayer.showNotification("Deine Taschen sind zu voll")
    end
end)
