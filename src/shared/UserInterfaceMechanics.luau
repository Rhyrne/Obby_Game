local tweenService = game:GetService("TweenService")

local functions = {}

-- Kullanıcı arayüzlerinde bulunan aç, kapa ve satış gibi işlemlerin fonksiyonları

function functions.OpenUserInterface(IstenilenUI, tweenBilgi, konum)
    local targetPosition = konum
	local tween = tweenService:Create(IstenilenUI.cerceve, tweenBilgi, {Position = targetPosition})
	
	if IstenilenUI.cerceve.Visible == false then
		IstenilenUI.cerceve.Visible = true
		tween:Play()
	else
		functions.CloseUserInterface(IstenilenUI, tweenBilgi, UDim2.new(0.9, 0,0.146, 0))
	end
end

function functions.CloseUserInterface(IstenilenUI, tweenBilgi, konum)
	local targetPosition = konum
	local tween = tweenService:Create(IstenilenUI.cerceve, tweenBilgi, {Position = targetPosition})
	
	tween:Play()
	wait(0.7)
	IstenilenUI.cerceve.Visible = false
end



return functions