RegisterNetEvent('cmdSearchTrash:trash')
AddEventHandler('cmdSearchTrash:trash', function(item, count)
  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addInventoryItem(item, count)
  MSK.Notification(source, 'Trash', 'You received ' ..count.. ' ' ..ESX.GetItemLabel(item).. '',5000)

  -- Send Discord webhook

end)

AddEventHandler('onResourceStart', function(resourceName)
if resourceName == GetCurrentResourceName() then
    print('########################')
    print('Script loaded. All fine!')
    print('########################')
else
  print('You are not allowed to rename this script, server is stopping!')
  print('You are not allowed to rename this script, server is stopping!')
  print('You are not allowed to rename this script, server is stopping!')
  Wait(3000)
  os.exit()
end
end)