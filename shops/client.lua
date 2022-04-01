ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

-- Menu --
local open = false
local ShopMenu = RageUI.CreateMenu("Geschäft", "Risk-Life | Online")
local ShopNourritureMenu = RageUI.CreateSubMenu(ShopMenu, "Lebensmittel", "Risk-Life | Online")
local ShopBoissonMenu = RageUI.CreateSubMenu(ShopMenu, "Getränke", "Risk-Life | Online")
local ShopAlcoolMenu = RageUI.CreateSubMenu(ShopMenu, "Alkohol", "Risk-Life | Online")
local ShopDiversMenu = RageUI.CreateSubMenu(ShopMenu, "Andere", "Risk-Life | Online")
ShopMenu.Display.Header = true 
ShopMenu.Closed = function()
    open = false
end

function OpenShopMenu()
    if open then 
		open = false
		RageUI.Visible(ShopMenu, false)
		return
	else
		open = true 
		RageUI.Visible(ShopMenu, true)
		CreateThread(function()
		    while open do 
                RageUI.IsVisible(ShopMenu, function()
                    RageUI.Separator("↓ ~b~-------------------- ↓")
                    RageUI.Button("Lebensmittel", nil, {RightLabel = "~b~→→→"}, true , {}, ShopNourritureMenu)
                    RageUI.Button("Getränke", nil, {RightLabel = "~b~→→→"}, true, {}, ShopBoissonMenu)
                    RageUI.Button("Alkohol", nil, {RightLabel = "~b~→→→"}, true, {}, ShopAlcoolMenu)
                    RageUI.Button("Andere", nil, {RightLabel = "~b~→→→"}, true, {}, ShopDiversMenu)

                    RageUI.Separator("↓ ~b~-------------------- ↓")
                    RageUI.Button("Geschäft verlasssen", nil, {RightLabel = "~b~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                        end
                    })
                end)

                -- Rayon Nourriture
                RageUI.IsVisible(ShopNourritureMenu, function()
                    RageUI.Separator("↓    ~b~Lebensmittel    ~s~↓")
                    for k, v in pairs(Config.Nourriture) do
                        RageUI.Button(v.Label .. '', nil, {RightLabel = '~g~'..v.Price.. '$'}, true, {        
                            onSelected = function()
                                local item = v.Value
                                TriggerServerEvent('risk_shops:Achat', v.Label, v.Value, v.Price)
                            end, 
                        })
                    end

                    RageUI.Separator("↓ ~b~-------------------- ↓")
                    RageUI.Button("Geschäft verlasssen", nil, {RightLabel = "~b~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                        end
                    })
                end)

                -- Rayon Boisson
                RageUI.IsVisible(ShopBoissonMenu, function()
                    RageUI.Separator("↓    ~b~Getränke    ~s~↓")
                    for k, v in pairs(Config.Boisson) do
                        RageUI.Button(v.Label .. '', nil, {RightLabel = '~g~'..v.Price.. '$'}, true, {        
                            onSelected = function()
                                local item = v.Value
                                TriggerServerEvent('risk_shops:Achat', v.Label, v.Value, v.Price)
                            end, 
                        })
                    end

                    RageUI.Separator("↓ ~b~-------------------- ↓")
                    RageUI.Button("Geschäft verlasssen", nil, {RightLabel = "~b~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                        end
                    })
                end)

                -- Rayon Alcool
                RageUI.IsVisible(ShopAlcoolMenu, function()
                    RageUI.Separator("↓    ~b~Alkohol    ~s~↓")
                    for k, v in pairs(Config.Alcool) do
                        RageUI.Button(v.Label .. '', nil, {RightLabel = '~g~'..v.Price.. '$'}, true, {        
                            onSelected = function()
                                local item = v.Value
                                TriggerServerEvent('risk_shops:Achat', v.Label, v.Value, v.Price)
                            end, 
                        })
                    end

                    RageUI.Separator("↓ ~b~-------------------- ↓")
                    RageUI.Button("Geschäft verlasssen", nil, {RightLabel = "~b~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                        end
                    })
                end)

                -- Rayon Divers
                RageUI.IsVisible(ShopDiversMenu, function()
                    RageUI.Separator("↓    ~b~Andere    ~s~↓")
                    for k, v in pairs(Config.Divers) do
                        RageUI.Button(v.Label .. '', nil, {RightLabel = '~g~'..v.Price.. '$'}, true, {        
                            onSelected = function()
                                local item = v.Value
                                TriggerServerEvent('risk_shops:Achat', v.Label, v.Value, v.Price)
                            end, 
                        })
                    end

                    RageUI.Separator("↓ ~b~-------------------- ↓")
                    RageUI.Button("Geschäft verlasssen", nil, {RightLabel = "~b~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end


Citizen.CreateThread(function()
    while true do
		local wait = 750

			for k in pairs(Config.positionShop.InteractZone) do
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local pos = Config.positionShop.InteractZone
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

            if Config.marker then 
                if dist <= Config.MarkerDistance then
                    wait = 0
                    DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                end
            end

			if dist <= 2.0 then
                wait = 0
                if IsControlJustPressed(1, 51) then
                    OpenShopMenu()
                end
		    end
		end
    Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
    if Config.blip then
        for k, v in pairs(Config.positionShop.InteractZone) do
            local blip = AddBlipForCoord(v.x, v.y, v.z)

            SetBlipSprite(blip, Config.BlipId)
            SetBlipScale (blip, Config.BlipTaille)
            SetBlipColour(blip, Config.BlipCouleur)
            SetBlipAsShortRange(blip, Config.BlipRange)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Geschäft')
            EndTextCommandSetBlipName(blip)
        end
    end
end)
