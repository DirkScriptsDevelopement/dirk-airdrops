FW = {
  PlayerJob = {},
  

  IsPlayerReady = function()
    if Config.UsingESX then 
      while not ESX.IsPlayerLoaded() do Wait(500); end
      FW.GetPlayerJob()
      return true
    elseif Config.UsingQBCore then 
      while not QBCore.Functions.GetPlayerData().job do Wait(500); end
      print('Player Ready')
      FW.GetPlayerJob()
      return true
    end
  end,

  Callback = function(name,cb,...)
    if Config.UsingESX then
      ESX.TriggerServerCallback(name,cb,...)
    elseif Config.UsingQBCore then 
      QBCore.Functions.TriggerCallback(name,cb,...)
    end
  end,

  GetPlayerJob = function()
    local jt = {}
    if Config.UsingESX then 
      local data = ESX.GetPlayerData()
      jt.name  =  data.job.name
      jt.label =  data.job.label
      jt.rank  =  data.job.grade
      jt.rankL =  data.job.grade_label
      FW.PlayerJob = jt
    elseif Config.UsingQBCore then 
      local data = QBCore.Functions.GetPlayerData()
      jt.name  = data.job.name
      jt.label = data.job.label
      jt.rank  = data.job.grade
      jt.rankL = data.job.grade.name
      FW.PlayerJob = jt
    end
  end,

  GiveKeys = function(veh,plate)
    if Config.UsingQBCore then 
      TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
    elseif Config.UsingESX then 
      -- Add Eevent for your key system here
    end
  end,  

  GetClosestObject = function(obj,cs,rad)
    if Config.UsingQBCore then 
      local cO, cD = QBCore.Functions.GetClosestObject(cs.xyz)
      if GetEntityModel(cO) == tonumber(obj) then 
        if cD <= rad then
          return cO
        end
      end
    elseif Config.UsingESX then 

    end
    return false
  end
}









if Config.UsingESX then 
  RegisterNetEvent("esx:setJob", function(job)
    FW.GetPlayerJob()
    TriggerEvent("JobUpdate")
  end)
elseif Config.UsingQBCore then 
  RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    FW.GetPlayerJob()
    TriggerEvent("JobUpdate")
  end)
end




