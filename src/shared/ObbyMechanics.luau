local functions = {}

-- Lider tablosunda bulunan özellikler ile ilgili mekaniklerin fonksiyonları

function functions.zamanArttirma(oyuncu)
    while wait(1) do
        oyuncu:FindFirstChild("leaderstats").Time.Value += 1
    end
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

return functions