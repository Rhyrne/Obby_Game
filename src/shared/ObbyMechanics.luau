
local eventsNTBFired = game:GetService("ReplicatedStorage").EventsNTBFired
local tweenService = game:GetService("TweenService")

local functions = {}

-- Lider tablosunda bulunan özellikler ile ilgili mekaniklerin fonksiyonları

function functions.zamanArttirma(oyuncu)
	eventsNTBFired.IncreaseTime:Fire(oyuncu)
end

-- Oyunda parçaların ileri, geri, yukarı ve aşağı hareket etmesini sağlayan mekaniğin fonksiyonu

function functions.parcalarIlerletiliyor(parca)
	
	local platform = parca.Platform
	local start = parca.A
	local finish = parca.B
	local bodyPos = platform.BodyPosition
	
	while true do
		bodyPos.Position = start.Position
		wait(tonumber(parca.Name))
		bodyPos.Position = finish.Position
		wait(tonumber(parca.Name))
	end
end

-- Oyun içerisinde ölümcül, kaybolan parçalar bulunmakta bu parçaların karakteri öldürmesini sağlayacak fonksiyon

function functions.olumculParca(eventimiz, olumculParcalar)
	for _, child in pairs(olumculParcalar:GetDescendants()) do
		local obje = child
        obje.Touched:Connect(function(hit)
        local oyuncu = game.Players:GetPlayerFromCharacter(hit.Parent) 
            if oyuncu then
                eventimiz:Fire(oyuncu)
            end
        end)
    end
end

function functions.gozKirpanParca(eventimiz, gozKirpanParcalar)
	for _, child in pairs(gozKirpanParcalar:GetDescendants()) do
		local obje = child
		obje.Touched:Connect(function(hit)
			local oyuncu = game.Players:GetPlayerFromCharacter(hit.Parent) 
			if oyuncu then
				eventimiz:Fire(oyuncu, obje)
			end
		end)
	end
end

-- Oyun içerisinde bölüm noktaları üzerine rasgele coin spawn etmeye yarayan fonksiyonlar

function functions.paralariKlonlaVeIsinla()
	local toplamMadeniPara = game:GetService("ServerScriptService").TotalCoins
	while toplamMadeniPara.Value < 21 and #game:GetService("Workspace").ObbyParts.Coins:GetChildren() < 21 do
		local madeniPara = game:GetService("ReplicatedStorage").Coin:Clone()
		madeniPara.Parent = game:GetService("Workspace").ObbyParts.Coins
		local random = math.random(1,#game:GetService("Workspace").ObbyParts.Stages:GetChildren()) 
		madeniPara.Position = game:GetService("Workspace").ObbyParts.Stages[tostring(random)].Position + Vector3.new(math.random(-20,20),math.random(3,10),math.random(-20,20))
		toplamMadeniPara.Value += 1
	end
end

function functions.paraDonmeVeYenileme(parca)
	local tweenInfo = TweenInfo.new(
		2, -- Süre (saniye)
		Enum.EasingStyle.Linear, -- Easing stili
		Enum.EasingDirection.InOut, -- Easing yönü
		-1, -- Tekrar sayısı (sonsuz için -1)
		false, -- Geri dönsün mü?
		0 -- Gecikme
	)

	local tween = tweenService:Create(parca, tweenInfo, {Orientation = Vector3.new(0,360,0)})

	tween:Play()
	
	local debounce = true
	parca.Touched:Connect(function(dokunanParca)
		local karakter = dokunanParca.Parent
		if karakter and karakter:FindFirstChild("Humanoid") and debounce == true then
			debounce = false
			local oyuncu = game:GetService("Players"):GetPlayerFromCharacter(karakter)
			if oyuncu then
				functions.paralariKlonlaVeIsinla()
				oyuncu.leaderstats.Money.Value += 150
				game:GetService("ServerScriptService").TotalCoins.Value -= 1
				parca:Destroy()
			end
		end
	end)
end

return functions