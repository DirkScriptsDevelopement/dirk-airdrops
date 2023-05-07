Config = {
  UsingESX    = false, 
  UsingQBCore = true, 
  TimeBeforeAnnounce = 45,
  DropSpeed   = 0.02, --## Higher is faster obviously
  Drops = {

    ['BigGunBox'] = {
      WarningAnnounce = "There is a big gun drop happening in %s minutes",
      Height          = 40, --## How high of the ground. Lower the faster it'll drop obviously.
      CrateObject     = "ex_prop_crate_jewels_racks_sc",
      Positions       = {
       vector4(-625.97528076172,-262.98999023438,38.72970199585,209.16088867188),
      },
      SetTimes        = {
        [9] = true, --## At 1300 Hours this will drop.
        [10] = true, --## At 1300 Hours this will drop.
        [11] = true, --## At 1300 Hours this will drop.
        [8] = true, --## At 1300 Hours this will drop.
        [19] = true, --## At 1300 Hours this will drop.
      },
      Loot            = {
        cash = {
          chance = 100, 
          minAmt = 20, 
          maxAmt = 500, 
        }, 
        weapon_pistol = {
          chance = 100, 
          minAmt = 20, 
          maxAmt = 500, 
        },  

        hacking_device = {
          chance = 20, 
          minAmt = 20, 
          maxAmt = 500, 
        },
        
        
      },
    },
  },

  DropItems = { --## Someone wanted the ability to use an item and it call a drop so here
    ['drop_smoke'] = {
      'BigGunBox', --## List of all the drops it will start
    },
  },
}




if Config.UsingQBCore then 
QBCore = exports['qb-core']:GetCoreObject()
elseif Config.UsingESX then 
  TriggerEvent("esx:getSharedObject", function(obj) ESX = obj; end)
end