ESX = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
MoneyPlayer = 0
BankPlayer = 0
ItemChosie = nil 
Item = nil
Prix = nil 
Label = "" 
local bancaire = true 
local liquide = false

TriggerServerEvent("tokenget")


RegisterNetEvent("token")  -- FOR SECURITY DON'T TOUCH IT
AddEventHandler("token", function(_token)  -- FOR SECURITY DON
    Config.Token = _token  -- FOR SECURITY DON
end)  -- FOR SECURITY DON

local xIndexList = 1
local nombre = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}


RMenu.Add('Magasin', 'mainmagasin', RageUI.CreateMenu("Magasin", "Magasin"))
RMenu.Add('Nourriture', 'submagasin', RageUI.CreateSubMenu(RMenu:Get('Magasin', 'mainmagasin'), "Nourriture", "Nourriture"))
RMenu.Add('Boisson', 'submagasin2', RageUI.CreateSubMenu(RMenu:Get('Magasin', 'mainmagasin'), "Boisson", "Boisson"))
RMenu.Add('Electronique', 'submagasin3', RageUI.CreateSubMenu(RMenu:Get('Magasin', 'mainmagasin'), "Electronique", "Electronique"))
RMenu.Add('Combien', 'Combien', RageUI.CreateSubMenu(RMenu:Get('Magasin', 'mainmagasin'), "Combien", "Combien"))

Citizen.CreateThread(function()

    while true do
        RageUI.IsVisible(RMenu:Get('Magasin', 'mainmagasin'), function()
            RageUI.Separator("↓ ~b~ Magasin ~s~↓")
            RageUI.Line()
            RageUI.Button('Nourriture', nil, { RightLabel = "→→→" }, true, {
                onSelected = function()
                end
            }, RMenu:Get('Nourriture', 'submagasin'))

            RageUI.Button('Boisson', nil, { RightLabel = "→→→" }, true, {
                onSelected = function()
                end
            }, RMenu:Get('Boisson', 'submagasin2'))

            RageUI.Button('Electronique', nil, { RightLabel = "→→→" }, true, {
                onSelected = function()
                end
            }, RMenu:Get('Electronique', 'submagasin3'))

        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('Nourriture', 'submagasin'), function()
            RageUI.Separator("↓ ~b~ Nourriture ~s~↓")
            RageUI.Line()

            for k,v in pairs(NourritureItem) do
                RageUI.Button(v.Label, nil, { RightLabel = v.Price.."$" }, true, {
                    onSelected = function()
                        ItemChosie = v.Value
                        Prix = v.Price
                        Label = v.Label
                        
                    end
                }, RMenu:Get('Combien', 'Combien'))
            end

        end, function()
        end)


        RageUI.IsVisible(RMenu:Get('Boisson', 'submagasin2'), function()
            RageUI.Separator("↓ ~b~ Boisson ~s~↓")
            RageUI.Line()
            
            for k,v in pairs(BoissonItem) do
                RageUI.Button(v.Label, nil, { RightLabel = v.Price.."$" }, true, {
                    onSelected = function()
                        ItemChosie = v.Value
                        Prix = v.Price
                        Label = v.Label
                        
                    end
                }, RMenu:Get('Combien', 'Combien'))
            end

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('Electronique', 'submagasin3'), function()
            RageUI.Separator("↓ ~b~ Electronique ~s~↓")
            RageUI.Line()

            for k,v in pairs(ElectroniqueItem) do
                RageUI.Button(v.Label, nil, { RightLabel = v.Price.."$" }, true, {
                    onSelected = function()
                        ItemChosie = v.Value
                        Prix = v.Price
                        Label = v.Label
                        
                    end
                }, RMenu:Get('Combien', 'Combien'))
            end

        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('Combien', 'Combien'), function()
            RageUI.Separator("↓ ~b~ Magasin ~s~↓")
            RageUI.Separator("↓ ~b~ "..Label.." ~s~↓")

            RageUI.Line()

            RageUI.List("Nombre de items", nombre, xIndexList, nil, {}, true, {
                onListChange = function(Index, Item)
                    xIndexList = Item
                end,
                onSelected = function(Index, Item)
                    xIndexList = Item
                end
            })
            
            if xIndexList ~= nil and Prix ~= nil then
                xIndexList = tonumber(xIndexList)
                Prix = tonumber(Prix)
                if xIndexList and Prix then
                    local total = Prix * xIndexList

                    RageUI.Checkbox("Payer par carte bancaire ~g~" .. BankPlayer .. " $", "Vous avez : " .. BankPlayer .. " $", bancaire, {}, {
                        onChecked = function()
                            bancaire = true
                            liquide = false
                        end,
                        onUnChecked = function()
                            bancaire = false
                            liquide = true
                        end
                    })

                    RageUI.Checkbox("Payer en liquide ~g~" .. MoneyPlayer .. " $", "Vous avez : " .. MoneyPlayer .. " $", liquide, {}, {
                        onChecked = function()
                            liquide = true
                            bancaire = false
                        end,
                        onUnChecked = function()
                            liquide = false
                            bancaire = true
                        end
                    })

                    RageUI.Button("Acheter", nil, { RightLabel = total .. "$" }, true, {
                        onSelected = function()
                            TriggerServerEvent('esx:buyItem', ItemChosie, xIndexList ,total, bancaire, liquide, Config.Token)
                            Wait(210)
                            GetPlayerMoney()
                        end
                    })

                end
            end
        end, function()
        end)

        Citizen.Wait(0)
    end
end)

function GetPlayerMoney()
    ESX.TriggerServerCallback('getmoney', function(money, bank)
        MoneyPlayer = money
        BankPlayer = bank

    end)
end 

function OpenMenuMagasin()
    GetPlayerMoney()
    RageUI.Visible(RMenu:Get('Magasin', 'mainmagasin'), not RageUI.Visible(RMenu:Get('Magasin', 'mainmagasin')))
end

AddEventHandler('openMagasin', function()
    OpenMenuMagasin()

end)

