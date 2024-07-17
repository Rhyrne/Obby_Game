local replicatedStorage = game:GetService("ReplicatedStorage")
local uzaktanOlaylar = replicatedStorage.EventsNTBFired
local bolumVeSpawnModule = require(replicatedStorage.Shared.StageAndSpawnMechanics)
local marketPlaceService = game:GetService("MarketplaceService")
local serverStorage = game:GetService("ServerStorage")

local functions = {}

-- Uzaktan ulaşım için hazırlanmış(client to server, server to server, client to client) fonksiyonlar

function functions.bolumPartinaDokundu()
	uzaktanOlaylar.StageInfo.Event:Connect(function(oyuncu,bolum)
		local mevcutBolum = oyuncu:FindFirstChild("leaderstats").Stage
		mevcutBolum.Value = bolum
	end)
end

function functions.olumPartinaDokundu()
	uzaktanOlaylar.KillSomeone.Event:Connect(function(oyuncu)
		if oyuncu then
			local character = oyuncu.Character or oyuncu.CharacterAdded:Wait()
			local humanoid = character:WaitForChild("Humanoid")
			if humanoid then
				humanoid.Health = 0
			else
				print(humanoid.Name .. (" is not humanoid"))
			end

			humanoid.Died:Connect(function()
				bolumVeSpawnModule.karakteriYenidenBaslat(oyuncu, character)
			end)
		end
	end)
end

function functions.zamanArttirmaKodu()
	uzaktanOlaylar.IncreaseTime.Event:Connect(function(oyuncu)
		while wait(1) do
			oyuncu:WaitForChild("leaderstats").Time.Value += 1
		end
	end)
end

function functions.kirpanPartinaDokundu()
	uzaktanOlaylar.NeedBlind.Event:Connect(function(oyuncu, obje)
		if oyuncu then
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
	uzaktanOlaylar.PlayerIsShopping.OnServerEvent:Connect(function(oyuncu, mevcutUrun, urunTuru)
		if urunTuru == "Silah" then
			local klonUrun = replicatedStorage.Gears[mevcutUrun.Name]:Clone()
			klonUrun.Parent = oyuncu.Backpack
			oyuncu.leaderstats.Money.Value -= mevcutUrun.Price.Value
		else
			marketPlaceService:PromptProductPurchase(oyuncu, mevcutUrun.Parent.ID.Value)
			
			marketPlaceService.ProcessReceipt = function(islem)
				if islem.ProductId == mevcutUrun.Parent.ID.Value then
					oyuncu.leaderstats.Money.Value += tonumber(mevcutUrun.Parent.Name) 
				end
			end
		end
	end)
end

function functions.liderTablosunuDoldur()
	uzaktanOlaylar.LeaderBoardDatas.OnServerEvent:Connect(function(oyuncu, veriTuru, ornekUI)
		local veriDepolamaServisi = game:GetService("DataStoreService")
		
		local veriDepo = veriDepolamaServisi:GetOrderedDataStore("lidertablosuverisi")
		for _,oyuncular in pairs(game:GetService("Players"):GetChildren()) do
			veriDepo:SetAsync(oyuncular.UserId,oyuncular.leaderstats[veriTuru].Value)
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
	uzaktanOlaylar.ChangePlayerStage.OnServerEvent:Connect(function(oyuncu, istenilenBolum)
		bolumVeSpawnModule.karakteriIsinla(oyuncu, istenilenBolum)
	end)
end

function functions.saldiriOlayi()
	uzaktanOlaylar.AttackEvent.OnServerEvent:Connect(function(oyuncu, saldiriStili, hedefPozisyon)
		local firlatilanCisim = serverStorage.Attacks[saldiriStili]:Clone()
		local karakter = oyuncu.Character or oyuncu.CharacterAdded:Wait()
		
		firlatilanCisim.CFrame = karakter.RightHand.CFrame
		firlatilanCisim.Parent = game:GetService("Workspace")
		firlatilanCisim.Holder.Value = oyuncu.Name

		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Velocity = (hedefPozisyon - oyuncu.Character.Head.Position).unit * 70
		bodyVelocity.Parent = firlatilanCisim
		firlatilanCisim.Throw:Play()
	end)
end

function functions.yetenekOlayi()
	uzaktanOlaylar.SkillEvent.OnServerEvent:Connect(function(oyuncu, yetenek, karakter)
		local humanoid = karakter:FindFirstChildOfClass("Humanoid")
		if yetenek == "Speed" then
			humanoid.WalkSpeed = 30
			wait(30)
			humanoid.WalkSpeed = 16
		else
			humanoid.JumpHeight = 14.4
			wait(15)
			humanoid.JumpHeight = 7.2
		end
	end)
end

return functions