RegisterNetEvent('cmdSearchTrash:trash')
AddEventHandler('cmdSearchTrash:trash', function(item, count)
  local xPlayer = ESX.GetPlayerFromId(source)
    
   if xPlayer.canCarryItem(item, count) then
    xPlayer.addInventoryItem(item, count)
    MSK.Notification(source, 'Trash', 'You received ' ..count.. ' ' ..ESX.GetItemLabel(item), 'info', 5000)
   else
    --xPlayer.showNotification("Deine Taschen sind zu voll")
      MSK.Notification(source, 'Trash', 'Deine Taschen sind zu voll', 'info', 5000)
   end
end)

