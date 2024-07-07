local uzaktanOlaylar = game:GetService("ReplicatedStorage").EventsNTBFired

uzaktanOlaylar.StageInfo.Event:Connect(function(player,bolum)
	local mevcutBolum = player:FindFirstChild("leaderstats").Stage
	mevcutBolum.Value = bolum
end)