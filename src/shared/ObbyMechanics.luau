local eventsNTBFired = game:GetService("ReplicatedStorage").EventsNTBFired

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

-- Oyun içerisinde ölümcül parçalar bulunmakta bu parçaların karakteri öldürmesini sağlayacak fonksiyon

function functions.olumculParca(info1, info2)
	for _, child in pairs(info2:GetDescendants()) do
		local obje = child
        obje.Touched:Connect(function(hit)
        local player = game.Players:GetPlayerFromCharacter(hit.Parent) 
            if player then
                info1:Fire(player)
            end
        end)
    end
end

return functions