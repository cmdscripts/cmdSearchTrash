RegisterNetEvent('cmdSearchTrash:trash')
AddEventHandler('cmdSearchTrash:trash', function(item, count)
  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addInventoryItem(item, count)
  MSK.Notification(source, 'Trash', 'You received ' ..count.. ' ' ..ESX.GetItemLabel(item), 'info', 5000)

end)
