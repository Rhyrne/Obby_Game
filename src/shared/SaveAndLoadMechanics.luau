local functions = {}

local veriDepolamaServisi = game:GetService("DataStoreService")
local depolanmisVeriler = veriDepolamaServisi:GetDataStore("depolanmisVeriler")

-- Load işlemleri için yapılmış fonksiyonlar(kullanıcı oyuna girdiğinde çağrılmalıdır)

function functions.liderTablosuOlustur(oyuncu)
    local leaderboard = Instance.new("Folder", oyuncu)
	leaderboard.Name = "leaderstats"
	local bolum = Instance.new("IntValue", leaderboard)
	bolum.Name = "Stage"
    local zaman = Instance.new("IntValue", leaderboard)
	zaman.Name = "Time"
	local para = Instance.new("IntValue", leaderboard)
	para.Name = "Money"
end

function functions.verileriTabloyaGetir(oyuncu)
    local oyuncuId = oyuncu.UserId
    local veriler = depolanmisVeriler:GetAsync(tostring(oyuncuId))

    if veriler then
        oyuncu.leaderstats.Stage.Value = veriler.Stage
		oyuncu.leaderstats.Time.Value = veriler.Time
        oyuncu.leaderstats.Money.Value = veriler.Money
	else
		oyuncu.leaderstats.Stage.Value = 1
		oyuncu.leaderstats.Time.Value = 0
        oyuncu.leaderstats.Time.Value = 25
    end
end

-- Save işlemleri için yapılmış fonksiyonlar(kullanıcı oyundan çıktığında çağrılmalıdır)

function functions.verileriTabloyaKaydet(oyuncu)
    local oyuncuId = oyuncu.UserId
    if oyuncu:FindFirstChild("leaderstats") then
        local veriler = {
            Stage = oyuncu.leaderstats.Stage.Value,
            Time = oyuncu.leaderstats.Time.Value,
            Money = oyuncu.leaderstats.Money.Value
        }
        depolanmisVeriler:SetAsync(tostring(oyuncuId), veriler)
    end
end

return functions