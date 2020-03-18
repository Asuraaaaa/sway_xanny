local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if ESX ~= nil then
		
		else
			ESX = nil
			TriggerEvent('esx:getSharAVACedObject', function(obj) ESX = obj end)
		end
	end
end)

local locations = {}
local spawned = false
Citizen.CreateThread( function()
Citizen.Wait(10000)
while true do
Citizen.Wait(1000)
	if GetDistanceBetweenCoords(Config.PickupBlip.x,Config.PickupBlip.y,Config.PickupBlip.z, GetEntityCoords(GetPlayerPed(-1))) <= 200 then
		if spawned == false then
			for i=1, 80 do
	        	TriggerEvent('xanny:start')
	        end
		end
		spawned = true
	else
		if spawned then
			locations = {}
		end
		spawned = false
		
	end
end
end)


local displayed = false
local menuOpen = false

local process = true
local ShowHelpNotification = true
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			for k in pairs(locations) do
				if GetDistanceBetweenCoords(locations[k].x, locations[k].y, locations[k].z, GetEntityCoords(GetPlayerPed(-1))) < 150 then			
					DrawMarker(20, locations[k].x, locations[k].y, locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 100, 205, 110, 0, 1, 0, 0)	
					
			        if GetDistanceBetweenCoords(locations[k].x, locations[k].y, locations[k].z, GetEntityCoords(GetPlayerPed(-1)), false) < 2 then
			        	ESX.ShowHelpNotification('Press ~INPUT_PICKUP~ to pick the silicon')
					    if IsControlJustReleased(0, 38) then

							FreezeEntityPosition(PlayerPedId(), true)
                            RequestAnimDict("amb@prop_human_bum_bin@idle_b")
							while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
                            TaskPlayAnim(PlayerPedId(),"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 1, 1, 1)
                            local finished = exports["sway_taskbar"]:taskBar(2500, "Picking silicon")
                            if finished == 100 then
                            StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
                            FreezeEntityPosition(PlayerPedId(), false)
							TriggerServerEvent('xanny:get')
						    TriggerEvent('xanny:new', k)	
						    end		
					    end
					end
				end
			end
			
			for i=1, #Config.Zones, 1 do
			if GetDistanceBetweenCoords(Config.Zones[i], GetEntityCoords(GetPlayerPed(-1))) < 150 then			
				DrawMarker(27, Config.Zones[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.0, 0, 100, 205, 110, 0, 1, 0, 0)	
				if GetDistanceBetweenCoords(Config.Zones[i], GetEntityCoords(GetPlayerPed(-1)), true) < 2 then
				--if ShowHelpNotification == true then
				    ESX.ShowHelpNotification('Press ~INPUT_PICKUP~ to process your silicon')	
				--end		
					if IsControlJustReleased(0, 38) then
						 local finished = exports["sway_taskbar"]:taskBar(5500, "Processing silicon")
  						 if finished == 100 then
				        FreezeEntityPosition(PlayerPedId(), true)
                        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
						while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
                        TaskPlayAnim(PlayerPedId(),"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 1, 1, 1)
                        Citizen.Wait(3000)
                        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
                        FreezeEntityPosition(PlayerPedId(), false)
						TriggerEvent('xanny:process')
				   	 end
				   end
			    end
					
			if GetDistanceBetweenCoords(Config.Zones[i], GetEntityCoords(GetPlayerPed(-1)), true) < 5 and GetDistanceBetweenCoords(Config.Zones[i], GetEntityCoords(GetPlayerPed(-1)), true) > 3 then
				process = false
			end
		end
		end	
			for i=1, #Config.Zones2, 1 do
			if GetDistanceBetweenCoords(Config.Zones2[i], GetEntityCoords(GetPlayerPed(-1))) < 150 then			
				DrawMarker(27, Config.Zones2[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.0, 0, 100, 205, 110, 0, 1, 0, 0)	
				if GetDistanceBetweenCoords(Config.Zones2[i], GetEntityCoords(GetPlayerPed(-1)), true) < 2 then
				--if ShowHelpNotification == true then
				    ESX.ShowHelpNotification('Press ~INPUT_PICKUP~ to package your alprazolam into xanax')	
				--end		
					if IsControlJustReleased(0, 38) then
						 local finished = exports["sway_taskbar"]:taskBar(8500, "Packaging alprazolam")
				        FreezeEntityPosition(PlayerPedId(), true)
                        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
						while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
                        TaskPlayAnim(PlayerPedId(),"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 1, 1, 1)
                        Citizen.Wait(1500)
                        StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
						if finished == 100 then
                        FreezeEntityPosition(PlayerPedId(), false)
						TriggerEvent('xanny:bag')
						end
				    end
			    end
					
			if GetDistanceBetweenCoords(Config.Zones2[i], GetEntityCoords(GetPlayerPed(-1)), true) < 5 and GetDistanceBetweenCoords(Config.Zones2[i], GetEntityCoords(GetPlayerPed(-1)), true) > 3 then
				bag = false
			end
		end
		end
    end
end)

RegisterNetEvent('xanny:processing')
AddEventHandler('xanny:processing', function()
    exports['progressBars']:startUI(4000, "Processing silicon")
	FreezeEntityPosition(PlayerPedId(), true)
    RequestAnimDict("amb@prop_human_bum_bin@idle_b")
	while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(),"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 1, 1, 1)
    Citizen.Wait(4000)
    StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
    FreezeEntityPosition(PlayerPedId(), false)
    --if process == true then
        TriggerServerEvent('xanny:process')
    	--process = false
    	ShowHelpNotification = true
    --end
    ShowHelpNotification = true
end)

RegisterNetEvent('xanny:bagging')
AddEventHandler('xanny:bagging', function()
    exports['progressBars']:startUI(4000, "Bagging the alprazolam")
	FreezeEntityPosition(PlayerPedId(), true)
    RequestAnimDict("amb@prop_human_bum_bin@idle_b")
	while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(),"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 1, 1, 1)
    Citizen.Wait(4000)
    StopAnimTask(PlayerPedId(), "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
    FreezeEntityPosition(PlayerPedId(), false)
    --if bag == true then
        TriggerServerEvent('xanny:bag')
    	--bag = false
    	ShowHelpNotification = true
    --end
    ShowHelpNotification = true
end)

RegisterNetEvent('xanny:process')
AddEventHandler('xanny:process', function()
	ShowHelpNotification = false
	--if process == false then
		TriggerServerEvent('xanny:processing')
		--process = true
        Citizen.Wait(4000)
        ShowHelpNotification = true
	--end
end)

RegisterNetEvent('xanny:bag')
AddEventHandler('xanny:bag', function()
	ShowHelpNotification = false
	--if bag == false then
		TriggerServerEvent('xanny:bagging')
		--bag = true
        Citizen.Wait(4000)
        ShowHelpNotification = true
	--end
end)

RegisterNetEvent('xanny:start')
AddEventHandler('xanny:start', function()
	Citizen.Wait(10)
	local set = false
	local rnX = Config.PickupBlip.x + math.random(-35, 35)
	local rnY = Config.PickupBlip.y + math.random(-35, 35)
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	table.insert(locations,{x=rnX, y=rnY, z=Z + 0.3});
end)


RegisterNetEvent('xanny:new')
AddEventHandler('xanny:new', function(id)
	Citizen.Wait(10)
	local set = false
	local rnX = Config.PickupBlip.x + math.random(-35, 35)
	local rnY = Config.PickupBlip.y + math.random(-35, 35)
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	locations[id].x = rnX
	locations[id].y = rnY
	locations[id].z = Z + 0.3
end)