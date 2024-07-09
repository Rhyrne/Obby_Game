local uzaktanOlaylarModule = require(game:GetService("ReplicatedStorage").Shared.EventsAreRemote)

print("MainScript is going on")

-- Spawn noktalarına basıldığında tetiklenir

uzaktanOlaylarModule.bolumPartinaDokundu()

-- Ölümcül parçalara dokunulduğunda tetiklenir

uzaktanOlaylarModule.olumPartinaDokundu()

-- Oyuncu oyuna girdiğinde, ait olduğu "Time" durumunu arttırmak için tetiklenir

uzaktanOlaylarModule.zamanArttirmaKodu()