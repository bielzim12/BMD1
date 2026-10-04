-- ========================================================
-- [[ BMD Hub - SCRIPT LUA OFICIAL AUTÔNOMO ]]
-- 100% Sem Erros de Conexão - Executa Direto em Qualquer Executor!
-- Celular / PC: Delta, Fluxus, Wave, Synapse, Solara, Arceus X
-- ========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Remover instâncias anteriores para não duplicar
pcall(function()
    if CoreGui:FindFirstChild("BMD_Official_Gui") then
        CoreGui.BMD_Official_Gui:Destroy()
    end
    if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("BMD_Official_Gui") then
        LocalPlayer.PlayerGui.BMD_Official_Gui:Destroy()
    end
end)

-- 1. CRIAÇÃO DO SCREENGUI PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BMD_Official_Gui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- ========================================================
-- 2. BOLA FLUTUANTE BMD (Arrastável, com Brilho e Coroa)
-- ========================================================
local OrbContainer = Instance.new("Frame")
OrbContainer.Name = "BMD_OrbContainer"
OrbContainer.Size = UDim2.new(0, 64, 0, 64)
OrbContainer.Position = UDim2.new(0, 25, 0.45, 0)
OrbContainer.BackgroundTransparency = 1
OrbContainer.Parent = ScreenGui

-- Halo de Brilho Vermelho Neon
local OrbAura = Instance.new("Frame")
OrbAura.Name = "OrbAura"
OrbAura.Size = UDim2.new(1, 14, 1, 14)
OrbAura.Position = UDim2.new(0, -7, 0, -7)
OrbAura.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
OrbAura.BackgroundTransparency = 0.65
OrbAura.BorderSizePixel = 0
OrbAura.Parent = OrbContainer
Instance.new("UICorner", OrbAura).CornerRadius = UDim.new(1, 0)

-- Botão Circular com Borda Vermelha
local OrbBtn = Instance.new("TextButton")
OrbBtn.Name = "OrbBtn"
OrbBtn.Size = UDim2.new(1, 0, 1, 0)
OrbBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
OrbBtn.BorderSizePixel = 0
OrbBtn.AutoButtonColor = false
OrbBtn.Text = ""
OrbBtn.Parent = OrbContainer
Instance.new("UICorner", OrbBtn).CornerRadius = UDim.new(1, 0)

local OrbStroke = Instance.new("UIStroke")
OrbStroke.Color = Color3.fromRGB(239, 68, 68)
OrbStroke.Thickness = 2.5
OrbStroke.Parent = OrbBtn

-- Coroa 👑
local CrownLabel = Instance.new("TextLabel")
CrownLabel.Size = UDim2.new(1, 0, 0, 20)
CrownLabel.Position = UDim2.new(0, 0, 0, 8)
CrownLabel.BackgroundTransparency = 1
CrownLabel.Text = "👑"
CrownLabel.TextSize = 16
CrownLabel.Parent = OrbBtn

-- Texto BMD
local BMDLabel = Instance.new("TextLabel")
BMDLabel.Size = UDim2.new(1, 0, 0, 22)
BMDLabel.Position = UDim2.new(0, 0, 0, 28)
BMDLabel.BackgroundTransparency = 1
BMDLabel.Text = "BMD"
BMDLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BMDLabel.Font = Enum.Font.GothamBlack
BMDLabel.TextSize = 16
BMDLabel.Parent = OrbBtn

-- Sistema de Arraste Touch e Mouse
local dragging, dragStart, startPos
OrbBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = OrbContainer.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
        local delta = input.Position - dragStart
        TweenService:Create(OrbContainer, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        }):Play()
    end
end)

-- ========================================================
-- 3. JANELA DO MENU BMD (Design Moderno Idêntico ao Site)
-- ========================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "BMD_MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 410)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -205)
MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(239, 68, 68)
MainStroke.Thickness = 1.6
MainStroke.Transparency = 0.3

-- Linha Neon no Topo
local LaserLine = Instance.new("Frame", MainFrame)
LaserLine.Size = UDim2.new(1, 0, 0, 2)
LaserLine.Position = UDim2.new(0, 0, 0, 0)
LaserLine.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
LaserLine.BorderSizePixel = 0

-- Header
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 46)
Header.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Header.BorderSizePixel = 0

-- Logo no Header
local HeaderLogo = Instance.new("Frame", Header)
HeaderLogo.Size = UDim2.new(0, 28, 0, 28)
HeaderLogo.Position = UDim2.new(0, 12, 0, 9)
HeaderLogo.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
HeaderLogo.BorderSizePixel = 0
Instance.new("UICorner", HeaderLogo).CornerRadius = UDim.new(1, 0)
local HStroke = Instance.new("UIStroke", HeaderLogo)
HStroke.Color = Color3.fromRGB(239, 68, 68)
HStroke.Thickness = 1.5

local HCrown = Instance.new("TextLabel", HeaderLogo)
HCrown.Size = UDim2.new(1, 0, 1, 0)
HCrown.BackgroundTransparency = 1
HCrown.Text = "👑"
HCrown.TextSize = 13

-- Título
local TitleLabel = Instance.new("TextLabel", Header)
TitleLabel.Size = UDim2.new(0, 180, 0, 20)
TitleLabel.Position = UDim2.new(0, 48, 0, 6)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "BMD Hub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local SubLabel = Instance.new("TextLabel", Header)
SubLabel.Size = UDim2.new(0, 180, 0, 14)
SubLabel.Position = UDim2.new(0, 48, 0, 26)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "v2.4 | Red Edition"
SubLabel.TextColor3 = Color3.fromRGB(161, 161, 170)
SubLabel.Font = Enum.Font.Gotham
SubLabel.TextSize = 10
SubLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Botão Fechar
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -34, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Alternar Abertura / Fechamento
local isMenuOpen = true
local function ToggleMenu()
    isMenuOpen = not isMenuOpen
    if isMenuOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 500, 0, 360)
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 560, 0, 410)
        }):Play()
    else
        local tw = TweenService:Create(MainFrame, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 470, 0, 340)
        })
        tw:Play()
        tw.Completed:Connect(function()
            if not isMenuOpen then MainFrame.Visible = false end
        end)
    end
end

OrbBtn.MouseButton1Click:Connect(ToggleMenu)
CloseBtn.MouseButton1Click:Connect(ToggleMenu)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightShift then
        ToggleMenu()
    end
end)

-- Barra Lateral (Abas)
local Sidebar = Instance.new("ScrollingFrame", MainFrame)
Sidebar.Size = UDim2.new(0, 136, 1, -46)
Sidebar.Position = UDim2.new(0, 0, 0, 46)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 2
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y

local SLayout = Instance.new("UIListLayout", Sidebar)
SLayout.Padding = UDim.new(0, 4)
local SPadding = Instance.new("UIPadding", Sidebar)
SPadding.PaddingTop = UDim.new(0, 8)
SPadding.PaddingLeft = UDim.new(0, 6)
SPadding.PaddingRight = UDim.new(0, 6)

-- Conteúdo Principal
local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -136, 1, -46)
ContentArea.Position = UDim2.new(0, 136, 0, 46)
ContentArea.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
ContentArea.BorderSizePixel = 0

-- ========================================================
-- 4. CONSTRUTOR DE ELEMENTOS (BMD Engine)
-- ========================================================
local BMD_Engine = {}
local TabPages = {}
local TabBtns = {}

function BMD_Engine:CreateTab(name, icon)
    local tabIdx = #TabPages + 1

    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Size = UDim2.new(1, 0, 0, 34)
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    Btn.Text = "  " .. name
    Btn.TextColor3 = Color3.fromRGB(161, 161, 170)
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 11
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.BorderSizePixel = 0
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

    local Line = Instance.new("Frame", Btn)
    Line.Size = UDim2.new(0, 3, 0, 18)
    Line.Position = UDim2.new(0, 3, 0.5, -9)
    Line.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    Line.BorderSizePixel = 0
    Line.Visible = false
    Instance.new("UICorner", Line).CornerRadius = UDim.new(1, 0)

    local Page = Instance.new("ScrollingFrame", ContentArea)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(239, 68, 68)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false

    local PLayout = Instance.new("UIListLayout", Page)
    PLayout.Padding = UDim.new(0, 7)
    local PPadding = Instance.new("UIPadding", Page)
    PPadding.PaddingTop = UDim.new(0, 10)
    PPadding.PaddingLeft = UDim.new(0, 10)
    PPadding.PaddingRight = UDim.new(0, 10)
    PPadding.PaddingBottom = UDim.new(0, 10)

    -- Banner de Destaque
    local Banner = Instance.new("Frame", Page)
    Banner.Size = UDim2.new(1, 0, 0, 30)
    Banner.BackgroundColor3 = Color3.fromRGB(30, 16, 20)
    Banner.BorderSizePixel = 0
    Instance.new("UICorner", Banner).CornerRadius = UDim.new(0, 8)
    local BStroke = Instance.new("UIStroke", Banner)
    BStroke.Color = Color3.fromRGB(239, 68, 68)
    BStroke.Transparency = 0.6

    local BannerText = Instance.new("TextLabel", Banner)
    BannerText.Size = UDim2.new(1, 0, 1, 0)
    BannerText.BackgroundTransparency = 1
    BannerText.Text = name
    BannerText.TextColor3 = Color3.fromRGB(255, 255, 255)
    BannerText.Font = Enum.Font.GothamBold
    BannerText.TextSize = 13

    table.insert(TabPages, Page)
    table.insert(TabBtns, { btn = Btn, line = Line })

    local function activateTab()
        for i, p in ipairs(TabPages) do
            p.Visible = (p == Page)
            local item = TabBtns[i]
            if item then
                item.btn.TextColor3 = (p == Page) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(161, 161, 170)
                item.btn.BackgroundColor3 = (p == Page) and Color3.fromRGB(239, 68, 68) or Color3.fromRGB(20, 20, 26)
                item.line.Visible = (p == Page)
            end
        end
    end

    Btn.MouseButton1Click:Connect(activateTab)

    if tabIdx == 1 then
        activateTab()
    end

    return Page
end

-- Section
function BMD_Engine:AddSection(tab, title)
    local Sec = Instance.new("Frame", tab)
    Sec.Size = UDim2.new(1, 0, 0, 20)
    Sec.BackgroundTransparency = 1

    local Lbl = Instance.new("TextLabel", Sec)
    Lbl.Size = UDim2.new(1, 0, 1, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = title
    Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextSize = 11
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
end

-- Toggle
function BMD_Engine:AddToggle(tab, opt)
    local title = opt.Title or "Toggle"
    local desc = opt.Description or ""
    local state = opt.Default or false
    local cb = opt.Callback or function() end

    local Card = Instance.new("TextButton", tab)
    Card.Size = UDim2.new(1, 0, 0, 42)
    Card.BackgroundColor3 = Color3.fromRGB(25, 25, 31)
    Card.BorderSizePixel = 0
    Card.AutoButtonColor = false
    Card.Text = ""
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

    local TText = Instance.new("TextLabel", Card)
    TText.Size = UDim2.new(1, -60, 0, 18)
    TText.Position = UDim2.new(0, 10, 0, 5)
    TText.BackgroundTransparency = 1
    TText.Text = title
    TText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TText.Font = Enum.Font.GothamBold
    TText.TextSize = 11
    TText.TextXAlignment = Enum.TextXAlignment.Left

    local DText = Instance.new("TextLabel", Card)
    DText.Size = UDim2.new(1, -60, 0, 14)
    DText.Position = UDim2.new(0, 10, 0, 22)
    DText.BackgroundTransparency = 1
    DText.Text = desc
    DText.TextColor3 = Color3.fromRGB(161, 161, 170)
    DText.Font = Enum.Font.Gotham
    DText.TextSize = 9
    DText.TextXAlignment = Enum.TextXAlignment.Left

    local Switch = Instance.new("Frame", Card)
    Switch.Size = UDim2.new(0, 38, 0, 20)
    Switch.Position = UDim2.new(1, -48, 0.5, -10)
    Switch.BackgroundColor3 = state and Color3.fromRGB(239, 68, 68) or Color3.fromRGB(42, 42, 50)
    Switch.BorderSizePixel = 0
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

    local Knob = Instance.new("Frame", Switch)
    Knob.Size = UDim2.new(0, 16, 0, 16)
    Knob.Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.BorderSizePixel = 0
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    Card.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(Switch, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(239, 68, 68) or Color3.fromRGB(42, 42, 50)
        }):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        }):Play()
        pcall(cb, state)
    end)
end

-- Slider
function BMD_Engine:AddSlider(tab, opt)
    local title = opt.Title or "Slider"
    local min = opt.Min or 0
    local max = opt.Max or 100
    local val = opt.Default or min
    local suffix = opt.Suffix or ""
    local cb = opt.Callback or function() end

    local Card = Instance.new("Frame", tab)
    Card.Size = UDim2.new(1, 0, 0, 46)
    Card.BackgroundColor3 = Color3.fromRGB(25, 25, 31)
    Card.BorderSizePixel = 0
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

    local TText = Instance.new("TextLabel", Card)
    TText.Size = UDim2.new(1, -70, 0, 16)
    TText.Position = UDim2.new(0, 10, 0, 5)
    TText.BackgroundTransparency = 1
    TText.Text = title
    TText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TText.Font = Enum.Font.GothamBold
    TText.TextSize = 11
    TText.TextXAlignment = Enum.TextXAlignment.Left

    local VText = Instance.new("TextLabel", Card)
    VText.Size = UDim2.new(0, 50, 0, 16)
    VText.Position = UDim2.new(1, -60, 0, 5)
    VText.BackgroundTransparency = 1
    VText.Text = tostring(val) .. suffix
    VText.TextColor3 = Color3.fromRGB(239, 68, 68)
    VText.Font = Enum.Font.GothamBold
    VText.TextSize = 11
    VText.TextXAlignment = Enum.TextXAlignment.Right

    local Track = Instance.new("Frame", Card)
    Track.Size = UDim2.new(1, -20, 0, 4)
    Track.Position = UDim2.new(0, 10, 0, 30)
    Track.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
    Track.BorderSizePixel = 0
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame", Track)
    local pct = math.clamp((val - min) / (max - min), 0, 1)
    Fill.Size = UDim2.new(pct, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    Fill.BorderSizePixel = 0
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local sliding = false
    local function updateSlide(input)
        local posX = math.clamp(input.Position.X - Track.AbsolutePosition.X, 0, Track.AbsoluteSize.X)
        local newPct = posX / Track.AbsoluteSize.X
        Fill.Size = UDim2.new(newPct, 0, 1, 0)
        local rawVal = math.floor(min + ((max - min) * newPct))
        VText.Text = tostring(rawVal) .. suffix
        pcall(cb, rawVal)
    end

    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            updateSlide(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlide(input)
        end
    end)
end

-- Button
function BMD_Engine:AddButton(tab, opt)
    local title = opt.Title or "Button"
    local desc = opt.Description or ""
    local cb = opt.Callback or function() end

    local Card = Instance.new("TextButton", tab)
    Card.Size = UDim2.new(1, 0, 0, 42)
    Card.BackgroundColor3 = Color3.fromRGB(25, 25, 31)
    Card.BorderSizePixel = 0
    Card.Text = ""
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)

    local TText = Instance.new("TextLabel", Card)
    TText.Size = UDim2.new(1, -85, 0, 18)
    TText.Position = UDim2.new(0, 10, 0, 5)
    TText.BackgroundTransparency = 1
    TText.Text = title
    TText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TText.Font = Enum.Font.GothamBold
    TText.TextSize = 11
    TText.TextXAlignment = Enum.TextXAlignment.Left

    local DText = Instance.new("TextLabel", Card)
    DText.Size = UDim2.new(1, -85, 0, 14)
    DText.Position = UDim2.new(0, 10, 0, 22)
    DText.BackgroundTransparency = 1
    DText.Text = desc
    DText.TextColor3 = Color3.fromRGB(161, 161, 170)
    DText.Font = Enum.Font.Gotham
    DText.TextSize = 9
    DText.TextXAlignment = Enum.TextXAlignment.Left

    local Tag = Instance.new("TextLabel", Card)
    Tag.Size = UDim2.new(0, 64, 0, 22)
    Tag.Position = UDim2.new(1, -74, 0.5, -11)
    Tag.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    Tag.Text = "Executar >"
    Tag.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tag.Font = Enum.Font.GothamBold
    Tag.TextSize = 10
    Instance.new("UICorner", Tag).CornerRadius = UDim.new(0, 6)

    Card.MouseButton1Click:Connect(function()
        pcall(cb)
    end)
end

-- ========================================================
-- 5. ABAS PADRÃO DO BMD HUB
-- ========================================================
local Tab_1 = BMD_Engine:CreateTab("Principal", "Home")
BMD_Engine:AddSection(Tab_1, "Recursos Automáticos")
BMD_Engine:AddToggle(Tab_1, {
    Title = "Auto Farm Moedas",
    Description = "Coleta moedas e baús automaticamente pelo mapa",
    Default = true
})
BMD_Engine:AddToggle(Tab_1, {
    Title = "Kill Aura Instantâneo",
    Description = "Elimina inimigos próximos dentro do alcance",
    Default = false
})
BMD_Engine:AddSlider(Tab_1, {
    Title = "Velocidade do Jogador (WalkSpeed)",
    Description = "Ajusta a velocidade de corrida do seu personagem",
    Min = 16,
    Max = 200,
    Default = 64,
    Suffix = " spd"
})
BMD_Engine:AddButton(Tab_1, {
    Title = "Teleportar para o Spawn",
    Description = "Retorna instantaneamente para a área segura",
    Callback = function()
        pcall(function()
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        end)
    end
})

local Tab_2 = BMD_Engine:CreateTab("Combate & PvP", "Crosshair")
BMD_Engine:AddToggle(Tab_2, {
    Title = "Aimbot na Cabeça",
    Description = "Mira automática travada no alvo mais próximo",
    Default = true
})

local Tab_3 = BMD_Engine:CreateTab("Visuals & ESP", "Eye")
BMD_Engine:AddToggle(Tab_3, {
    Title = "ESP Caixas nos Inimigos",
    Description = "Mostra caixas 2D ao redor de todos os jogadores",
    Default = true
})

local Tab_4 = BMD_Engine:CreateTab("Teleportes", "MapPin")
BMD_Engine:AddButton(Tab_4, {
    Title = "Teleportar para Chefe",
    Description = "Vai direto para a arena do Boss"
})

print("[BMD Hub] Executado com sucesso no Roblox!")
