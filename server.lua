RegisterNetEvent('cmdSearchTrash:trash')
AddEventHandler('cmdSearchTrash:trash', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local random = math.random(1, #Config.Item_List)
    local itemData = Config.Item_List[random]
    local item, count = itemData.item, itemData.count

    if xPlayer.canCarryItem(item, count) then
        xPlayer.addInventoryItem(item, count)
        xPlayer.showNotification("You got " .. count .. " " .. ESX.GetItemLabel(item) .. " ")
    else
        xPlayer.showNotification("Your pockets are too full")
    end
end)