local uzaktanOlaylarModule = require(game:GetService("ReplicatedStorage").Shared.EventsAreRemote)

print("MainScript is going on")

-- Spawn noktalarına basıldığında tetiklenir

uzaktanOlaylarModule.bolumPartinaDokundu()

-- Ölümcül parçalara dokunulduğunda tetiklenir

uzaktanOlaylarModule.olumPartinaDokundu()

-- Oyuncu oyuna girdiğinde, ait olduğu "Time" durumunu arttırmak için tetiklenir

uzaktanOlaylarModule.zamanArttirmaKodu()

-- Basıldığında kaybolan parçalara basılınca tetiklenir

uzaktanOlaylarModule.kirpanPartinaDokundu()

-- Satın alma işlemlerini gerçekleştiren fonksiyon tetiklenir

uzaktanOlaylarModule.satinAlmaIslemi()

-- Lider tablosunun kullanıcılara gösterilmesini sağlıyor (düzgün çalışmıyor)

uzaktanOlaylarModule.liderTablosunuDoldur()

-- Karakterimiz istediği zaman istediği bölümler arasında geçi yapmasını sağlar

uzaktanOlaylarModule.karakteriIstenilenBolumeIsinla()