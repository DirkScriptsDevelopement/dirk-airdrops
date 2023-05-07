local CurrentBoxes = {}
Init = function()
  while not FW.IsPlayerReady() do Wait(500); end
  Update()
end

Update = function()
  while true do 
    local wait_time = 1000
    local pos = GetEntityCoords(GetPlayerPed(-1))
    for dN,dS in pairs(CurrentBoxes) do
      for k,v in pairs(dS) do 
        local cs = GetEntityCoords(v.Box)
        if #(pos - cs) <= 2.5 then 
          wait_time = 0
          u.SHN("Press ~INPUT_DETONATE~ to search this box")
          if IsControlJustPressed(0,47) then 
            TriggerServerEvent("AirDrop:SearchDrop", dN, k)
          end
        end
        local hAG = GetEntityHeightAboveGround(v.Box)
        if hAG > 0.2 then 
          
          wait_time = 0 
          SetEntityCoords(v.Box, cs.x, cs.y, cs.z - Config.DropSpeed, 0.0, 0.0, 0.0, false)
        elseif hAG <= 0.2 then 
          if v.Para and DoesEntityExist(v.Para) then 
            DeleteEntity(v.Para)
            v.Para = false
          end
        end
      end
    end
    Wait(wait_time)
  end
end


u.RNE('AirDropBlip', function(k,t,p)
  local blip = AddBlipForCoord(p.x,p.y,p.z)
  SetBlipSprite(blip, 162)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.9)
  SetBlipColour(blip, 25)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(t..k)
  EndTextCommandSetBlipName(blip)
  SetTimeout(360000, function()
    RemoveBlip(blip)
  end)
end)

u.RNE("AirDropStart", function(dropName, Pos)
  if Config.Drops[dropName] then 
    local ply    = PlayerPedId()
    local pos    = GetEntityCoords(ply)
    local is     = vector3(pos.x,pos.y,pos.z + 15.0)
    local ds     = vector3(Pos.x,Pos.y,Pos.z + Config.Drops[dropName].Height)
    local hash   = GetHashKey(Config.Drops[dropName].CrateObject)
    local para   = GetHashKey("p_cargo_chute_s")
    if not CurrentBoxes[dropName] then 
      CurrentBoxes[dropName] = {}
    else
      if DoesEntityExist(CurrentBoxes[dropName][ds].Box) then DeleteEntity(CurrentBoxes[dropName][ds].Box); end
      if DoesEntityExist(CurrentBoxes[dropName][ds].Para) then DeleteEntity(CurrentBoxes[dropName][ds].Para); end

    end


    CurrentBoxes[dropName][ds] = {
      Box = false, 
      Para = false,
    }
    while not HasModelLoaded(hash) do RequestModel(hash) Wait(0); end
    while not HasModelLoaded(para) do RequestModel(para) Wait(0); end

    CurrentBoxes[dropName][ds].Box = CreateObject(hash, is, false, true, false) 
    SetEntityCoords(CurrentBoxes[dropName][ds].Box, ds.x, ds.y, ds.z)
    SetEntityLodDist(CurrentBoxes[dropName][ds].Box, 1000) 
    CurrentBoxes[dropName][ds].Para = CreateObject(para, is, false, true, false) 
    SetEntityCoords(CurrentBoxes[dropName][ds].Para, ds.x,ds.y,ds.z)
    AttachEntityToEntity(CurrentBoxes[dropName][ds].Para,CurrentBoxes[dropName][ds].Box, 0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
  end
end)

u.RNE("AirDrop:Searched", function(d,ds)
  print('Searched', d, ds)
  SetTimeout(30000, function()
    DeleteEntity(CurrentBoxes[d][ds].Box)
     CurrentBoxes[d][ds] = nil
  end)
 
end)
  

u.Thread(Init)


--- Server Side
