local functions = {}
-- Lider tablosunda bulunan özellikler ile ilgili mekaniklerin fonksiyonları

function functions.zamanArttirma(oyuncu)
    while wait(1) do
        oyuncu:FindFirstChild("leaderstats").Time.Value += 1
    end
end

-- Obby içerisinde bulunan ölümcül tuzaklar, hareketli parçalar için fonksiyonlar
return functions