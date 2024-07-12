local replicatedStorage = game:GetService("ReplicatedStorage")
local uzaktanOlaylar = replicatedStorage.EventsNTBFired
local bolumVeSpawnModule = require(replicatedStorage.Shared.StageAndSpawnMechanics)
local obbyMekanikModule = require(replicatedStorage.Shared.ObbyMechanics)
local marketPlaceService = game:GetService("MarketplaceService")

local functions = {}

-- Uzaktan ulaşım için hazırlanmış(client to server, server to server, client to client) fonksiyonlar

function functions.bolumPartinaDokundu()
	uzaktanOlaylar.StageInfo.Event:Connect(function(player,bolum)
		local mevcutBolum = player:FindFirstChild("leaderstats").Stage
		mevcutBolum.Value = bolum
	end)
end

function functions.olumPartinaDokundu()
	uzaktanOlaylar.KillSomeone.Event:Connect(function(player)
		if player then
			local character = player.Character or player.CharacterAdded:Wait()
			local humanoid = character:WaitForChild("Humanoid")
			if humanoid then
				humanoid.Health = 0
			else
				print(humanoid.Name .. (" is not humanoid"))
			end

			humanoid.Died:Connect(function()
				bolumVeSpawnModule.karakteriYenidenBaslat(player, character)
			end)
		end
	end)
end

function functions.zamanArttirmaKodu()
	uzaktanOlaylar.IncreaseTime.Event:Connect(function(player)
		while wait(1) do
			player:WaitForChild("leaderstats").Time.Value += 1
		end
	end)
end

function functions.kirpanPartinaDokundu()
	uzaktanOlaylar.NeedBlind.Event:Connect(function(player, obje)
		if player then
			obje.Transparency = 0.5
			obje.CanCollide = false
			obje.CanTouch = false
			wait(2)
			obje.Transparency = 0
			obje.CanCollide = true
			obje.CanTouch = true
		end
	end)
end

function functions.satinAlmaIslemi()
	uzaktanOlaylar.PlayerIsShopping.OnServerEvent:Connect(function(player, mevcutUrun, urunTuru)
		if urunTuru == "Silah" then
			local klonUrun = replicatedStorage.Gears[mevcutUrun.Name]:Clone()
			klonUrun.Parent = player.Backpack
			player.leaderstats.Money.Value -= mevcutUrun.Price.Value
		else
			marketPlaceService:PromptProductPurchase(player,mevcutUrun.Parent.ID.Value)
			
			marketPlaceService.ProcessReceipt = function(islem)
				if islem.ProductId == mevcutUrun.Parent.ID.Value then
					player.leaderstats.Money.Value += tonumber(mevcutUrun.Parent.Name) 
				end
			end
		end
	end)
end

function functions.liderTablosunuDoldur()
	uzaktanOlaylar.LeaderBoardDatas.OnServerEvent:Connect(function(oyuncu, veriTuru, ornekUI)
		local veriDepolamaServisi = game:GetService("DataStoreService")
		local veriDepo = veriDepolamaServisi:GetOrderedDataStore("lidertablosuverisi")
		for _,oyuncu in pairs(game:GetService("Players"):GetChildren()) do
			veriDepo:SetAsync(oyuncu.UserId,oyuncu.leaderstats[veriTuru].Value)
		end

		local sayfalar = veriDepo:GetSortedAsync(false,10,1,10e30)
		local siralanmisVeriler = sayfalar:GetCurrentPage()
		local veriler = {}

		for _,veri in ipairs(siralanmisVeriler) do
			local username = game:GetService("Players"):GetNameFromUserIdAsync(veri.key)
			local Value = veri.value
			table.insert(veriler,{username,Value})
		end

		for _,child in pairs(oyuncu.PlayerGui.LeaderBoardUI.Cerceve.FrameForLeaders:GetDescendants()) do
			if child:IsA("Frame") then
				child:Destroy()
			end
		end

		for number,d in pairs(veriler) do
			local isim = d[1]
			local deger = d[2]
			local yeniUI = ornekUI:Clone()
			yeniUI.Parent = oyuncu.PlayerGui.LeaderBoardUI.Cerceve.FrameForLeaders
			yeniUI.LayoutOrder = number
			yeniUI.Name = isim
			yeniUI.Pozisyon.Text = yeniUI.LayoutOrder
			yeniUI.Username.Text = isim
			yeniUI.Value.Text = deger
			yeniUI.Visible = true
		end
	end)
end

function functions.karakteriIstenilenBolumeIsinla()
	uzaktanOlaylar.ChangePlayerStage.OnServerEvent:Connect(function(player, istenilenBolum)
		obbyMekanikModule.karakterinBolumunuDegistir(player, istenilenBolum)
	end)
end

return functions