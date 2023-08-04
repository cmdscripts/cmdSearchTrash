RegisterNetEvent('cmdSearchTrash:trash')
AddEventHandler('cmdSearchTrash:trash', function(item, count)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canCarryItem(item, count) then
        xPlayer.addInventoryItem(item, count)
        xPlayer.showNotification("You got" .. count .. " " .. ESX.GetItemLabel(item) .. " ")
    else
        xPlayer.showNotification("Your pockets are too full")
    end
end)
