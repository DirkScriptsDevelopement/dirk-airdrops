FW = {
  Callback = function(name,route)
    if Config.UsingESX then 
      ESX.RegisterServerCallback(name,route)
    elseif Config.UsingQBCore then 
      QBCore.Functions.CreateCallback(name,route) 
    end
  end,


  Player = function(s)
    if Config.UsingESX then 
      return ESX.GetPlayerFromId(s)
    elseif Config.UsingQBCore then 
      print('Getting Player')
      local ply = QBCore.Functions.GetPlayer(s)
      return ply
    end
  end,

  GetPlayerId = function(p)
    if Config.UsingESX then 
      return ESX.GetPlayerFromId(source).identifier
    elseif Config.UsingQBCore then 
      return QBCore.Functions.GetPlayer(p).PlayerData.citizenid
    end
  end,

  Notify = function(p,msg)
    if Config.UsingESX then 
      TriggerClientEvent("esx:showNotification", p, msg)
    elseif Config.UsingQBCore then 
      TriggerClientEvent("QBCore:Notify", p, msg)
    end
  end,


  RemoveItem = function(p,i,a)
    if Config.UsingESX then 
      local ply = ESX.GetPlayerFromId(p)
      ply.removeInventoryItem(i,a)
    elseif Config.UsingQBCore then 
      local ply = QBCore.Functions.GetPlayer(p)
      ply.Functions.RemoveItem(i,a)
    end
  end,

  HasItem = function(p, i,a)
    if Config.UsingESX then 
      local ply = ESX.GetPlayerFromId(p)
      local item = xPlayer.getInventoryItem(i)
      if item and item.count >= a then 
        return true
      end
    elseif Config.UsingQBCore then 
      local ply = QBCore.Functions.GetPlayer(p)
      local item = ply.Functions.GetItemByName(i)
      if item and item.amount >= a then 
        return true
      end
    end
    return false
  end,

  AddItem = function(p,item,count)
    local player = FW.Player(p)
    if Config.UsingESX then 
      player.addInventoryItem(item,count)
    elseif Config.UsingQBCore then
      player.Functions.AddItem(item,count)
      TriggerClientEvent('inventory:client:ItemBox', p, QBCore.Shared.Items[item], "add")
    end
  end, 

  AddMoney = function(p,acc,a)
    if Config.UsingESX then 
      local ply = ESX.GetPlayerFromId(p)
      local accs = ply.getAccounts()
      local exists = false
      for k,v in pairs(accs) do
        if v.name == acc then
          exists = true
          break
        end
      end
      ply.addAccountMoney(acc,a)
    elseif Config.UsingQBCore then 
      local ply = FW.Player(p)
      ply.Functions.AddMoney(acc,a)
    end
  end,

  GetPlayerJob = function(p)
    local src = tonumber(p)
    local jt = {}
    if Config.UsingQBCore then 
      local ply = QBCore.Functions.GetPlayer(src)
      print('REturning QB Job')
      jt.grade = ply.PlayerData.job.grade.level
      jt.name  = ply.PlayerData.job.name
      return jt
    elseif Config.UsingESX then 
      local ply = ESX.GetPlayerFromId(src)
      local job = ply.getJob()
      jt.grade = job.grade
      jt.name  = job.name
    end
    return {}
  end,

}