local functions = {}

local tweenService = game:GetService("TweenService")


-- Lider tablosunda bulunan özellikler ile ilgili mekaniklerin fonksiyonları

function functions.zamanArttirma(oyuncu)
    while wait(1) do
        oyuncu:FindFirstChild("leaderstats").Time.Value += 1
    end
end

-- Obby içerisinde bulunan ölümcül tuzaklar, hareketli parçalar için fonksiyonlar

function functions.IleriVeGeriParcalar(parca)
    
	local konumBilgileri = string.split(parca.Name, ",")
	local x = tonumber(konumBilgileri[1])
	local y = tonumber(konumBilgileri[2])
	local z = tonumber(konumBilgileri[3])
	local zaman = tonumber(konumBilgileri[4])
	
	local hedefKonum = Vector3.new(x, y, z)

    local tweenInfo = TweenInfo.new(
	zaman, -- Süre (saniye)
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.InOut,
	-1, -- Tekrar sayısı (-1 sınırsız olmasını sağlar)
	true, -- Yoyo (animasyonu tersine çevir)
	0 -- Gecikme süresi
    )

	local hedef = {Position = hedefKonum}

    local tween = tweenService:Create(parca, tweenInfo, hedef)
    tween:Play()
end

return functions