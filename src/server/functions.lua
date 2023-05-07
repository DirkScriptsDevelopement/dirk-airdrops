ChooseRandomPos = function(s)
  for k,v in pairs(Config.Drops[s].Positions) do 
    local Limit = 40 
    math.randomseed(os.time())
    local Chance = math.random(100)
    if Chance <= Limit then 
      return v
    end
  end
  return false
end

CheckTime = function()
  local hour = os.date("%H")
  local minute = os.date("%M")
  for k,v in pairs(Config.Drops) do 
    if v.SetTimes[tonumber(hour + 1)] and not v.Announced then 
      if (60 - minute) <= Config.TimeBeforeAnnounce then 
        print('Announce')
        local timeTo = (60 - minute)
        TriggerClientEvent('chatMessage', -1, "AIRDROP", "warning", string.format(v.WarningAnnounce, timeTo))
        --TriggerClientEvent('chatMessage', -1, '^7[^1Announcement^7]^5:', {0,0,0} --[[This table is just RGB]], 'There will be an airdrop in '..timeTo..' minutes')
        v.Announced = true
      end
    end

    if v.SetTimes[tonumber(hour)] then 
      if v.LastDrop ~= hour then
        v.LastDrop = hour 
        v.Announced = false
        v.Searched = false
        while not Pos do Pos = ChooseRandomPos(k); end
        print('Dropping')
        TriggerClientEvent('chatMessage', -1, "AIRDROP", "warning", 'There has been an airdrop it is marked on your map get there quickly!')
        TriggerClientEvent('AirDropBlip', -1, k, 'DROPPING NOW:', Pos)

        TriggerClientEvent("AirDropStart", -1, k, Pos)
      end 
    end
  end
  SetTimeout(5000,CheckTime)
end

Citizen.CreateThread(function()
  Wait(5000)
  CheckTime()
end)



u.RNE("AirDrop:SearchDrop", function(drop,ds)
  if not Config.Drops[drop].Searched then 
    TriggerClientEvent("AirDrop:Searched", -1, drop,ds)
    Config.Drops[drop].Searched = true
    local loot = Config.Drops[drop].Loot
    local myLoot = {}
    for k,v in pairs(loot) do
    print('Possible ', k) 
      math.randomseed(os.time())
      if math.random(100) <= v.chance then
      print(' Adding Loot') 
        myLoot[k] = math.random(v.minAmt, v.maxAmt)
      end
    end

    local count = 0 
    for k,v in pairs(myLoot) do 
      count = count + 1
    end

    if count >=1 then 
      for i,a in pairs(myLoot) do 
        print(i,a, "ITEMS GAINED")
        if i ~= "cash" or i ~= "bank" or i ~= "money" then 
          FW.AddItem(source,i,a)
        else
          FW.AddMoney(source,i,a)
        end
      end
    else
      TriggerClientEvent(string.format("%s:Notify", GetCurrentResourceName()), source, "There is nothing in this crate")
    end
  else
    TriggerClientEvent(string.format("%s:Notify", GetCurrentResourceName()), source, "There is nothing in this crate")
  end
end)

RegisterCommand("ForceDrop", function(source,args)
  if not args[1] then return; end
  local k = args[1]
  while not Pos do Pos = ChooseRandomPos(k); end
  print('DROP')
  local timeTo = 0
  local v = Config.Drops[k]
  TriggerClientEvent('chatMessage', -1, "AIRDROP", "warning", string.format(v.WarningAnnounce, timeTo))
  TriggerClientEvent('AirDropBlip', -1, k, 'DROPPING NOW:', Pos)  
  TriggerClientEvent("AirDropStart", -1, k, Pos)
end,true)


for k,v in pairs(Config.DropItems) do 
  if Config.UsingESX then 

  elseif Config.UsingQBCore then 

  end
end






DropItem = function(itemname)
  for i,k in pairs(Config.DropItems[itemname]) do
    while not Pos do Pos = ChooseRandomPos(k); end
    print('DROP')
    local timeTo = 0
    local v = Config.Drops[k]
    TriggerClientEvent('chatMessage', -1, "AIRDROP", "warning", string.format(v.WarningAnnounce, timeTo))
    TriggerClientEvent('AirDropBlip', -1, k, 'DROPPING NOW:', Pos)  
    TriggerClientEvent("AirDropStart", -1, k, Pos)
  end
end