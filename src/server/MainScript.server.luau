local uzaktanOlaylarModule = require(game:GetService("ReplicatedStorage").Shared.EventsAreRemote)
local obbyMekanikleri = require(game:GetService("ReplicatedStorage").Shared.ObbyMechanics)
local ileriGeriParcalar = game:GetService("Workspace"):FindFirstChild("ObbyParcalari").IleriVeGeriParcalar

-- Spawn noktalarına basıldığında tetiklenir

uzaktanOlaylarModule.bolumPartinaDokundu()

-- İleri, geri, yukarı, aşağı hareket eden parçalar için döngü

for _, child in pairs(ileriGeriParcalar:GetDescendants()) do
	obbyMekanikleri.IleriVeGeriParcalar(child)
end

