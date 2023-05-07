u = {
  Thread = function(r)
    Citizen.CreateThread(r)
  end,

  RNE = function(name,route)
    RegisterNetEvent(name,route)
  end,

  Dprint = function(msg)
    if Config.Debug then 
      print(msg)
    end
  end,
}
