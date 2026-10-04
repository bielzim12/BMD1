
--[[
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
  DELTA  ×  MM2   •   Crimson Night  v6.0
  O menu mais bonito que você vai ver no Delta
▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
]]

local Plr  = game:GetService("Players")
local Run  = game:GetService("RunService")
local Tw   = game:GetService("TweenService")
local Inp  = game:GetService("UserInputService")
local CG   = game:GetService("CoreGui")
local LP   = Plr.LocalPlayer

pcall(function()
    if CG:FindFirstChild("DX_MM2") then CG.DX_MM2:Destroy() end
end)

-- ─── screen ───────────────────────────────────────────────────
local VP = workspace.CurrentCamera.ViewportSize
local SW,SH = VP.X, VP.Y

-- ─── shortcuts ────────────────────────────────────────────────
local function rgb(r,g,b) return Color3.fromRGB(r,g,b) end
local function u(a,b,c,d) return UDim2.new(a,b,c,d)   end
local function ud(s,o)    return UDim.new(s,o)          end

local function tween(obj,props,t,s,d)
    return Tw:Create(obj,TweenInfo.new(
        t or .25,
        Enum.EasingStyle[s or "Quart"],
        Enum.EasingDirection[d or "Out"]
    ),props)
end

local function make(cls,props,children)
    local o = Instance.new(cls)
    for k,v in pairs(props or {}) do
        if k~="Parent" then o[k]=v end
    end
    for _,c in ipairs(children or {}) do c.Parent=o end
    if props and props.Parent then o.Parent=props.Parent end
    return o
end

local function rnd(r,p)
    make("UICorner",{CornerRadius=ud(0,r),Parent=p})
end

local function shadow(parent,alpha,sz)
    make("ImageLabel",{
        Size=u(1,sz or 80,1,sz or 80),
        Position=u(0,-(sz or 80)/2,0,-(sz or 80)/2),
        BackgroundTransparency=1,
        Image="rbxassetid://5028857084",
        ImageColor3=rgb(0,0,0),
        ImageTransparency=alpha or 0.7,
        ZIndex=(parent.ZIndex or 2)-1,
        Parent=parent,
    })
end

local function glowImg(parent,color,alpha,sz)
    make("ImageLabel",{
        Size=u(1,sz or 60,1,sz or 60),
        Position=u(0,-(sz or 60)/2,0,-(sz or 60)/2),
        BackgroundTransparency=1,
        Image="rbxassetid://5028857084",
        ImageColor3=color,
        ImageTransparency=alpha or 0.8,
        ZIndex=(parent.ZIndex or 2)+1,
        Parent=parent,
    })
end

local function gradient(c1,c2,rot,parent)
    make("UIGradient",{
        Color=ColorSequence.new{
            ColorSequenceKeypoint.new(0,c1),
            ColorSequenceKeypoint.new(1,c2)},
        Rotation=rot or 90,Parent=parent,
    })
end

-- ═══════════════════════════════════════════════════════════════
--  PALETA  "Crimson Night"
-- ═══════════════════════════════════════════════════════════════
local P = {
    -- backgrounds
    void    = rgb(3,   2,  10),   -- mais escuro possível
    base    = rgb(7,   6,  18),   -- fundo do painel
    surface = rgb(11,  10, 26),   -- fundo de seções
    card    = rgb(15,  14, 34),   -- cards normais
    cardHov = rgb(21,  18, 44),   -- card hover / ativo
    -- acents
    red     = rgb(228, 28, 55),   -- crimson principal
    redDk   = rgb(140, 10, 28),   -- crimson escuro
    redGlow = rgb(255, 50, 80),   -- glow vermelho
    gold    = rgb(240,160, 20),   -- ouro
    goldGlw = rgb(255,200, 50),
    purple  = rgb(110, 55,255),   -- roxo
    teal    = rgb(0,  210,170),   -- verde-azul
    -- texto
    txtHi   = rgb(250,246,255),   -- branco puro quase
    txtMd   = rgb(150,140,185),   -- cinza médio
    txtLo   = rgb(65,  58, 95),   -- quase invisível
    -- utilidades
    white   = rgb(255,255,255),
    border  = rgb(28,  22, 60),
    sep     = rgb(20,  16, 46),
}

-- ─── estado ───────────────────────────────────────────────────
local ST = {
    open=false, tab=1,
    espMurd=false, espSher=false, espAll=false,
    speed=false, fly=false, noclip=false, infJmp=false,
    antiAfk=false, coinFarm=false,
    walkSpeed=85, fov=70,
}

-- ═══════════════════════════════════════════════════════════════
--  ROOT
-- ═══════════════════════════════════════════════════════════════
local GUI = make("ScreenGui",{
    Name="DX_MM2",ResetOnSpawn=false,
    IgnoreGuiInset=true,
    ZIndexBehavior=Enum.ZIndexBehavior.Sibling,
})
if not pcall(function() GUI.Parent=CG end) then
    GUI.Parent=LP.PlayerGui
end

-- ─── overlay escuro (fundo) ───────────────────────────────────
local Overlay = make("Frame",{
    Size=u(1,0,1,0), BackgroundColor3=P.void,
    BackgroundTransparency=1,
    BorderSizePixel=0,
    ZIndex=40, Visible=false, Parent=GUI,
})

-- ═══════════════════════════════════════════════════════════════
--  FLOATING BUTTON  
-- ═══════════════════════════════════════════════════════════════
local FAB = make("Frame",{
    Size=u(0,58,0,58),
    Position=u(1,-72,1,-110),
    BackgroundColor3=P.red,
    BorderSizePixel=0,
    ZIndex=200, Parent=GUI,
})
rnd(18,FAB)
gradient(P.red, P.redDk, 135, FAB)
make("UIStroke",{
    Thickness=1.5,Color=P.redGlow,
    ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
    Parent=FAB,
})
glowImg(FAB, P.redGlow, 0.65, 70)

local FabIcon = make("TextLabel",{
    Size=u(1,0,1,0), BackgroundTransparency=1,
    Text="🔪", TextSize=26,
    Font=Enum.Font.GothamBold,
    TextColor3=P.white, ZIndex=201,Parent=FAB,
})

-- badge
local FBadge = make("Frame",{
    Size=u(0,20,0,20),Position=u(1,-6,0,-6),
    BackgroundColor3=P.gold, ZIndex=202,
    Visible=false, Parent=FAB,
})
rnd(10,FBadge)
local FBLbl = make("TextLabel",{
    Size=u(1,0,1,0), BackgroundTransparency=1,
    Text="0", TextSize=11,
    Font=Enum.Font.GothamBold,
    TextColor3=P.void, ZIndex=203,Parent=FBadge,
})

-- drag FAB
local fd,fdS,fdP=false,nil,nil
local fabMov=false
FAB.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch
    or i.UserInputType==Enum.UserInputType.MouseButton1 then
        fd=true fdS=i.Position fdP=FAB.Position fabMov=false
    end
end)
FAB.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch
    or i.UserInputType==Enum.UserInputType.MouseButton1 then
        fd=false
    end
end)
Inp.InputChanged:Connect(function(i)
    if fd and (i.UserInputType==Enum.UserInputType.Touch
    or i.UserInputType==Enum.UserInputType.MouseMoved) then
        fabMov=true
        local d=i.Position-fdS
        FAB.Position=u(fdP.X.Scale,fdP.X.Offset+d.X,
                       fdP.Y.Scale,fdP.Y.Offset+d.Y)
    end
end)

local function updateBadge()
    local n=0
    for _,k in ipairs{"espMurd","espSher","espAll",
            "speed","fly","noclip","infJmp","antiAfk","coinFarm"} do
        if ST[k] then n=n+1 end
    end
    FBadge.Visible=n>0
    FBLbl.Text=tostring(n)
end

-- ═══════════════════════════════════════════════════════════════
--  PAINEL PRINCIPAL  (modal central, abre com escala)
-- ═══════════════════════════════════════════════════════════════
local PW = math.min(420, SW-20)
local PH = math.min(680, SH-32)

local Panel = make("Frame",{
    Name="Panel",
    Size=u(0,PW,0,PH),
    Position=u(0.5,-PW/2,0.5,-PH/2),
    BackgroundColor3=P.base,
    BorderSizePixel=0,
    ZIndex=50, Visible=false,Parent=GUI,
})
rnd(24,Panel)
shadow(Panel,0.88,100)
make("UIStroke",{
    Thickness=1,Color=P.border,
    ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
    Parent=Panel,
})
-- Glow roxo sutil no painel
glowImg(Panel, P.purple, 0.92, 120)

-- borda gradiente animada
local BorderGrad = make("Frame",{
    Size=u(1,4,1,4), Position=u(0,-2,0,-2),
    BackgroundTransparency=1,
    ZIndex=49,Parent=Panel,
})
rnd(26,BorderGrad)
local BG_UIGrad = make("UIGradient",{
    Color=ColorSequence.new{
        ColorSequenceKeypoint.new(0,   P.red),
        ColorSequenceKeypoint.new(0.33,P.purple),
        ColorSequenceKeypoint.new(0.66,P.teal),
        ColorSequenceKeypoint.new(1,   P.red),
    },
    Rotation=0, Parent=BorderGrad,
})

-- ─── HEADER  ──────────────────────────────────────────────────
local HDR = make("Frame",{
    Size=u(1,0,0,88), BackgroundColor3=P.surface,
    BorderSizePixel=0, ZIndex=52,Parent=Panel,
})
rnd(24,HDR)
make("Frame",{
    Size=u(1,0,0,24), Position=u(0,0,1,-24),
    BackgroundColor3=P.surface,
    BorderSizePixel=0, ZIndex=52,Parent=HDR,
})
-- gradiente header
gradient(rgb(90,10,25), rgb(8,6,22), 170, HDR)

-- Logo animado (círculo com faca)
local LogoRing = make("Frame",{
    Size=u(0,52,0,52), Position=u(0,16,0.5,-26),
    BackgroundColor3=P.red, ZIndex=53,Parent=HDR,
})
rnd(16,LogoRing)
gradient(P.redGlow, P.redDk, 135, LogoRing)
glowImg(LogoRing, P.redGlow, 0.55, 50)
make("TextLabel",{
    Size=u(1,0,1,0), BackgroundTransparency=1,
    Text="🔪", TextSize=28,
    Font=Enum.Font.GothamBold,
    TextColor3=P.white, ZIndex=55,Parent=LogoRing,
})

-- Título
make("TextLabel",{
    Size=u(1,-150,0,32), Position=u(0,80,0,14),
    BackgroundTransparency=1,
    Text="DELTA  MM2",
    TextColor3=P.txtHi, TextSize=21,
    Font=Enum.Font.GothamBold,
    TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=53,Parent=HDR,
})
-- subtítulo com gradiente de cor
local subtitleLbl = make("TextLabel",{
    Size=u(1,-150,0,20), Position=u(0,80,0,48),
    BackgroundTransparency=1,
    Text="Murder Mystery 2  •  v6.0",
    TextColor3=P.txtMd, TextSize=12,
    Font=Enum.Font.Gotham,
    TextXAlignment=Enum.TextXAlignment.Left,
    ZIndex=53,Parent=HDR,
})

-- Dots de status (decoração)
for i=1,3 do
    local dot=make("Frame",{
        Size=u(0,7,0,7),
        Position=u(1,-44,0,14+(i-1)*14),
        BackgroundColor3=i==1 and P.red or i==2 and P.gold or P.teal,
        ZIndex=53,Parent=HDR,
    })
    rnd(4,dot)
    glowImg(dot, i==1 and P.red or i==2 and P.gold or P.teal, 0.5, 16)
end

-- Botão X
local CloseX = make("TextButton",{
    Size=u(0,32,0,32),Position=u(1,-52,0,12),
    BackgroundColor3=rgb(30,14,36),
    BorderSizePixel=0,
    Text="✕",TextColor3=rgb(200,100,120),
    TextSize=15,Font=Enum.Font.GothamBold,
    ZIndex=54,Parent=HDR,
})
rnd(10,CloseX)
make("UIStroke",{
    Thickness=1,Color=P.red,
    ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
    Parent=CloseX,
})

-- linha rainbow animada
local RLine = make("Frame",{
    Size=u(1,-32,0,2), Position=u(0,16,1,-2),
    BackgroundTransparency=1, ZIndex=54,Parent=HDR,
})
rnd(1,RLine)
local RGrad = make("UIGradient",{
    Color=ColorSequence.new{
        ColorSequenceKeypoint.new(0,   P.red),
        ColorSequenceKeypoint.new(0.25,P.purple),
        ColorSequenceKeypoint.new(0.5, P.teal),
        ColorSequenceKeypoint.new(0.75,P.gold),
        ColorSequenceKeypoint.new(1,   P.red),
    },Parent=RLine,
})
make("Frame",{
    Size=u(1,0,1,0), BackgroundColor3=P.red,
    BackgroundTransparency=0.2,
    ZIndex=53,Parent=RLine,
})

-- drag pelo header
local hd,hdS,hdP=false,nil,nil
HDR.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch
    or i.UserInputType==Enum.UserInputType.MouseButton1 then
        hd=true hdS=i.Position hdP=Panel.Position
    end
end)
HDR.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch
    or i.UserInputType==Enum.UserInputType.MouseButton1 then
        hd=false
    end
end)
Inp.InputChanged:Connect(function(i)
    if hd and (i.UserInputType==Enum.UserInputType.Touch
    or i.UserInputType==Enum.UserInputType.MouseMoved) then
        local d=i.Position-hdS
        Panel.Position=u(Panel.Position.X.Scale,
            hdP.X.Offset+d.X,
            Panel.Position.Y.Scale,
            hdP.Y.Offset+d.Y)
    end
end)

-- ─── TAB BAR ──────────────────────────────────────────────────
local TabBar = make("Frame",{
    Size=u(1,-24,0,42), Position=u(0,12,0,92),
    BackgroundColor3=P.surface,
    BorderSizePixel=0, ZIndex=52,Parent=Panel,
})
rnd(21,TabBar)
make("UIStroke",{Thickness=1,Color=P.sep,
    ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
    Parent=TabBar,
})

local TAB_DEFS={
    {n="🔪  Assassino", c=P.red,  g=P.redDk},
    {n="💨  Movimento",  c=P.purple,g=rgb(60,20,180)},
    {n="⚙  Extra",      c=P.teal, g=rgb(0,120,100)},
}
local tabW=math.floor((PW-24-8)/#TAB_DEFS)
local TabButtons={}
for i,td in ipairs(TAB_DEFS) do
    local btn=make("TextButton",{
        Size=u(0,tabW-4,1,-8),
        Position=u(0,(i-1)*tabW+2,0,4),
        BackgroundColor3=i==1 and td.c or rgb(0,0,0),
        BackgroundTransparency=i==1 and 0 or 1,
        BorderSizePixel=0,
        Text=td.n, TextColor3=i==1 and P.white or P.txtMd,
        TextSize=12, Font=Enum.Font.GothamBold,
        ZIndex=53,Parent=TabBar,
    })
    rnd(17,btn)
    if i==1 then gradient(td.c,td.g,90,btn) end
    TabButtons[i]={btn=btn,def=td}
end

-- ─── CONTENT ──────────────────────────────────────────────────
local ContentArea = make("Frame",{
    Size=u(1,-20,1,-148), Position=u(0,10,0,142),
    BackgroundColor3=P.surface,
    BorderSizePixel=0,
    ClipsDescendants=true,
    ZIndex=51,Parent=Panel,
})
rnd(18,ContentArea)

local TabScrolls={}
for i=1,3 do
    local sc=make("ScrollingFrame",{
        Size=u(1,0,1,0),
        BackgroundTransparency=1,
        BorderSizePixel=0,
        ScrollBarThickness=2,
        ScrollBarImageColor3=rgb(60,50,100),
        CanvasSize=u(0,0,0,0),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,
        Visible=i==1, ZIndex=52,Parent=ContentArea,
    })
    make("UIListLayout",{
        Padding=ud(0,6),
        SortOrder=Enum.SortOrder.LayoutOrder,
        Parent=sc,
    })
    make("UIPadding",{
        PaddingTop=ud(0,8),PaddingBottom=ud(0,10),
        PaddingLeft=ud(0,8),PaddingRight=ud(0,8),
        Parent=sc,
    })
    TabScrolls[i]=sc
end

-- ═══════════════════════════════════════════════════════════════
--  WIDGETS
-- ═══════════════════════════════════════════════════════════════

-- SECTION
local function Section(parent,title,lo)
    local row=make("Frame",{
        Size=u(1,-4,0,30),BackgroundTransparency=1,
        LayoutOrder=lo or 0,Parent=parent,
    })
    make("TextLabel",{
        Size=u(1,-4,1,0),Position=u(0,2,0,0),
        BackgroundTransparency=1,
        Text=title:upper(),
        TextColor3=P.txtLo,TextSize=10,
        Font=Enum.Font.GothamBold,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=53,Parent=row,
    })
    make("Frame",{
        Size=u(1,-4,0,1),Position=u(0,2,1,-1),
        BackgroundColor3=P.sep,
        ZIndex=53,Parent=row,
    })
end

-- TOGGLE
local function Toggle(parent,icon,label,desc,accent,glo,lo,cb)
    local card=make("Frame",{
        Size=u(1,-4,0,66),BackgroundColor3=P.card,
        BorderSizePixel=0,LayoutOrder=lo or 0,Parent=parent,
    })
    rnd(14,card)

    -- sombra interna sutil
    make("UIGradient",{
        Color=ColorSequence.new{
            ColorSequenceKeypoint.new(0,rgb(255,255,255)),
            ColorSequenceKeypoint.new(1,rgb(0,0,0)),
        },
        Transparency=NumberSequence.new{
            NumberSequenceKeypoint.new(0,0.97),
            NumberSequenceKeypoint.new(1,0.99),
        },
        Rotation=90,Parent=card,
    })

    -- barra lateral (só aparece quando ON)
    local lbar=make("Frame",{
        Size=u(0,3,1,-20),Position=u(0,0,0,10),
        BackgroundColor3=accent,
        Visible=false,ZIndex=53,Parent=card,
    })
    rnd(2,lbar)
    glowImg(lbar,glo or accent,0.3,20)

    -- ícone
    local ic=make("Frame",{
        Size=u(0,42,0,42),Position=u(0,14,0.5,-21),
        BackgroundColor3=P.surface,
        ZIndex=53,Parent=card,
    })
    rnd(13,ic)
    make("UIStroke",{Thickness=1,Color=P.sep,
        ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=ic})
    local icEmoji=make("TextLabel",{
        Size=u(1,0,1,0),BackgroundTransparency=1,
        Text=icon,TextSize=20,
        Font=Enum.Font.GothamBold,
        TextColor3=P.txtMd,ZIndex=54,Parent=ic,
    })

    -- textos
    make("TextLabel",{
        Size=u(1,-126,0,24),Position=u(0,66,0,12),
        BackgroundTransparency=1,Text=label,
        TextColor3=P.txtHi,TextSize=14,
        Font=Enum.Font.GothamBold,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=53,Parent=card,
    })
    make("TextLabel",{
        Size=u(1,-126,0,18),Position=u(0,66,0,36),
        BackgroundTransparency=1,Text=desc,
        TextColor3=P.txtLo,TextSize=11,
        Font=Enum.Font.Gotham,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=53,Parent=card,
    })

    -- switch track
    local track=make("Frame",{
        Size=u(0,50,0,26),Position=u(1,-64,0.5,-13),
        BackgroundColor3=P.sep,ZIndex=53,Parent=card,
    })
    rnd(13,track)
    make("UIStroke",{Thickness=1,Color=P.border,
        ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=track})
    local knob=make("Frame",{
        Size=u(0,20,0,20),Position=u(0,3,0.5,-10),
        BackgroundColor3=P.txtLo,ZIndex=55,Parent=track,
    })
    rnd(10,knob)

    -- status text dentro do switch
    local stLbl=make("TextLabel",{
        Size=u(1,0,1,0),BackgroundTransparency=1,
        Text="OFF",TextSize=8,
        Font=Enum.Font.GothamBold,
        TextColor3=P.txtLo,ZIndex=54,Parent=track,
    })

    local on=false
    local animating=false
    local function flip()
        if animating then return end
        animating=true
        on=not on
        -- track
        tween(track,{BackgroundColor3=on and accent or P.sep},.2):Play()
        -- knob position + color
        tween(knob,{
            Position=on and u(1,-23,0.5,-10) or u(0,3,0.5,-10),
            BackgroundColor3=on and P.white or P.txtLo,
        },.2,"Back","Out"):Play()
        -- card background
        tween(card,{BackgroundColor3=on and P.cardHov or P.card},.2):Play()
        -- icon tint
        tween(icEmoji,{TextColor3=on and accent or P.txtMd},.2):Play()
        tween(ic,{BackgroundColor3=on and P.void or P.surface},.2):Play()
        -- status text
        stLbl.Text=on and "ON" or "OFF"
        tween(stLbl,{TextColor3=on and P.white or P.txtLo},.2):Play()
        -- barra lateral
        lbar.Visible=on
        task.delay(.22,function() animating=false end)
        if cb then cb(on) end
        updateBadge()
    end

    make("TextButton",{
        Size=u(1,0,1,0),BackgroundTransparency=1,
        Text="",ZIndex=56,Parent=card,
    }).MouseButton1Click:Connect(flip)
    return card
end

-- SLIDER
local function Slider(parent,icon,label,mn,mx,def,accent,lo,cb)
    local card=make("Frame",{
        Size=u(1,-4,0,82),BackgroundColor3=P.card,
        BorderSizePixel=0,LayoutOrder=lo or 0,Parent=parent,
    })
    rnd(14,card)
    make("UIGradient",{
        Color=ColorSequence.new{
            ColorSequenceKeypoint.new(0,rgb(255,255,255)),
            ColorSequenceKeypoint.new(1,rgb(0,0,0)),
        },
        Transparency=NumberSequence.new{
            NumberSequenceKeypoint.new(0,0.97),
            NumberSequenceKeypoint.new(1,0.99),
        },
        Rotation=90,Parent=card,
    })

    make("TextLabel",{
        Size=u(1,-80,0,22),Position=u(0,14,0,10),
        BackgroundTransparency=1,
        Text=icon.."  "..label,
        TextColor3=P.txtHi,TextSize=13,
        Font=Enum.Font.GothamBold,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=53,Parent=card,
    })
    local vLbl=make("TextLabel",{
        Size=u(0,65,0,22),Position=u(1,-79,0,10),
        BackgroundTransparency=1,Text=tostring(def),
        TextColor3=accent,TextSize=15,
        Font=Enum.Font.GothamBold,
        TextXAlignment=Enum.TextXAlignment.Right,
        ZIndex=53,Parent=card,
    })

    -- track bg
    local trk=make("Frame",{
        Size=u(1,-28,0,6),Position=u(0,14,0,52),
        BackgroundColor3=P.sep,ZIndex=53,Parent=card,
    })
    rnd(3,trk)

    local fr0=(def-mn)/(mx-mn)
    local fill=make("Frame",{
        Size=u(fr0,0,1,0),BackgroundColor3=accent,
        ZIndex=54,Parent=trk,
    })
    rnd(3,fill)
    gradient(accent,P.purple,0,fill)

    local knb=make("Frame",{
        Size=u(0,18,0,18),Position=u(fr0,-9,0.5,-9),
        BackgroundColor3=P.white,ZIndex=55,Parent=trk,
    })
    rnd(9,knb)
    make("UIStroke",{Thickness=2,Color=accent,
        ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=knb})
    glowImg(knb,accent,0.6,22)

    local sliding=false
    local function upd(x)
        local ax=trk.AbsolutePosition.X
        local aw=trk.AbsoluteSize.X
        local f=math.clamp((x-ax)/aw,0,1)
        local v=math.floor(mn+f*(mx-mn))
        fill.Size=u(f,0,1,0)
        knb.Position=u(f,-9,0.5,-9)
        vLbl.Text=tostring(v)
        if cb then cb(v) end
    end
    trk.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch
        or i.UserInputType==Enum.UserInputType.MouseButton1 then
            sliding=true upd(i.Position.X)
        end
    end)
    Inp.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.Touch
        or i.UserInputType==Enum.UserInputType.MouseButton1 then
            sliding=false
        end
    end)
    Inp.InputChanged:Connect(function(i)
        if sliding and(i.UserInputType==Enum.UserInputType.Touch
        or i.UserInputType==Enum.UserInputType.MouseMoved) then
            upd(i.Position.X)
        end
    end)
end

-- ACTION BUTTON
local function ActionBtn(parent,icon,label,desc,accent,lo,cb)
    local card=make("TextButton",{
        Size=u(1,-4,0,60),BackgroundColor3=P.card,
        BorderSizePixel=0,Text="",
        LayoutOrder=lo or 0,ZIndex=52,Parent=parent,
    })
    rnd(14,card)
    make("UIGradient",{
        Color=ColorSequence.new{
            ColorSequenceKeypoint.new(0,rgb(255,255,255)),
            ColorSequenceKeypoint.new(1,rgb(0,0,0)),
        },
        Transparency=NumberSequence.new{
            NumberSequenceKeypoint.new(0,0.97),
            NumberSequenceKeypoint.new(1,0.99),
        },
        Rotation=90,Parent=card,
    })

    local ic=make("Frame",{
        Size=u(0,38,0,38),Position=u(0,12,0.5,-19),
        BackgroundColor3=accent,ZIndex=53,Parent=card,
    })
    rnd(12,ic)
    gradient(accent,rgb(
        math.max(0,math.floor(accent.R*255)-60),
        math.max(0,math.floor(accent.G*255)-20),
        math.max(0,math.floor(accent.B*255)-20)
    ),135,ic)
    make("TextLabel",{
        Size=u(1,0,1,0),BackgroundTransparency=1,
        Text=icon,TextSize=18,
        Font=Enum.Font.GothamBold,
        TextColor3=P.white,ZIndex=54,Parent=ic,
    })

    make("TextLabel",{
        Size=u(1,-100,0,22),Position=u(0,62,0,8),
        BackgroundTransparency=1,Text=label,
        TextColor3=P.txtHi,TextSize=13,
        Font=Enum.Font.GothamBold,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=53,Parent=card,
    })
    make("TextLabel",{
        Size=u(1,-100,0,18),Position=u(0,62,0,32),
        BackgroundTransparency=1,Text=desc,
        TextColor3=P.txtLo,TextSize=11,
        Font=Enum.Font.Gotham,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=53,Parent=card,
    })
    -- seta
    make("TextLabel",{
        Size=u(0,22,0,22),Position=u(1,-30,0.5,-11),
        BackgroundTransparency=1,Text="›",
        TextColor3=P.txtLo,TextSize=22,
        Font=Enum.Font.GothamBold,ZIndex=53,Parent=card,
    })

    card.MouseButton1Click:Connect(function()
        tween(card,{BackgroundColor3=P.cardHov},.08):Play()
        task.delay(.15,function()
            tween(card,{BackgroundColor3=P.card},.15):Play()
        end)
        if cb then cb() end
    end)
end

-- ═══════════════════════════════════════════════════════════════
--  CONTEÚDO DAS ABAS
-- ═══════════════════════════════════════════════════════════════

-- ── ABA 1: ASSASSINO ──────────────────────────────────────────
do
    local t=TabScrolls[1]
    Section(t,"  Detecção de Papéis",1)

    Toggle(t,"🔴","Murderer ESP","Contorna o assassino em VERMELHO",
        P.red,P.redGlow,2,function(on)
        ST.espMurd=on
        for _,pl in pairs(Plr:GetPlayers()) do
            if pl~=LP then pcall(function()
                local ch=pl.Character
                if ch then
                    if on and ch:FindFirstChild("Knife") then
                        if not ch:FindFirstChild("_mESP") then
                            local s=Instance.new("SelectionBox")
                            s.Name="_mESP"
                            s.Color3=rgb(255,20,40)
                            s.SurfaceColor3=rgb(255,20,40)
                            s.SurfaceTransparency=0.55
                            s.LineThickness=0.1
                            s.Adornee=ch s.Parent=ch
                        end
                    elseif not on then
                        local s=ch:FindFirstChild("_mESP")
                        if s then s:Destroy() end
                    end
                end
            end) end
        end
    end)

    Toggle(t,"⭐","Sheriff ESP","Contorna o xerife em DOURADO",
        P.gold,P.goldGlw,3,function(on)
        ST.espSher=on
        for _,pl in pairs(Plr:GetPlayers()) do
            if pl~=LP then pcall(function()
                local ch=pl.Character
                if ch then
                    if on and(ch:FindFirstChild("Gun")
                    or ch:FindFirstChild("Sheriff")) then
                        if not ch:FindFirstChild("_sESP") then
                            local s=Instance.new("SelectionBox")
                            s.Name="_sESP"
                            s.Color3=rgb(240,160,20)
                            s.SurfaceColor3=rgb(240,160,20)
                            s.SurfaceTransparency=0.6
                            s.LineThickness=0.08
                            s.Adornee=ch s.Parent=ch
                        end
                    elseif not on then
                        local s=ch:FindFirstChild("_sESP")
                        if s then s:Destroy() end
                    end
                end
            end) end
        end
    end)

    Toggle(t,"🔮","All Players ESP","Vê todos os jogadores no mapa",
        P.purple,P.purple,4,function(on)
        ST.espAll=on
        for _,pl in pairs(Plr:GetPlayers()) do
            if pl~=LP then pcall(function()
                local ch=pl.Character
                if ch then
                    if on and not ch:FindFirstChild("_aESP") then
                        local s=Instance.new("SelectionBox")
                        s.Name="_aESP"
                        s.Color3=rgb(110,55,255)
                        s.SurfaceColor3=rgb(110,55,255)
                        s.SurfaceTransparency=0.72
                        s.LineThickness=0.05
                        s.Adornee=ch s.Parent=ch
                    elseif not on then
                        local s=ch:FindFirstChild("_aESP")
                        if s then s:Destroy() end
                    end
                end
            end) end
        end
    end)

    Section(t,"  Teleporte Rápido",5)

    ActionBtn(t,"🎯","TP ao Assassino",
        "Teleporta até quem tem a faca",P.red,6,function()
        pcall(function()
            for _,pl in pairs(Plr:GetPlayers()) do
                if pl~=LP then
                    local ch=pl.Character
                    if ch and ch:FindFirstChild("Knife") then
                        LP.Character.HumanoidRootPart.CFrame=
                            ch.HumanoidRootPart.CFrame*CFrame.new(5,0,0)
                        break
                    end
                end
            end
        end)
    end)

    ActionBtn(t,"⭐","TP ao Xerife",
        "Teleporta até quem tem a arma",P.gold,7,function()
        pcall(function()
            for _,pl in pairs(Plr:GetPlayers()) do
                if pl~=LP then
                    local ch=pl.Character
                    if ch and(ch:FindFirstChild("Gun")
                    or ch:FindFirstChild("Sheriff")) then
                        LP.Character.HumanoidRootPart.CFrame=
                            ch.HumanoidRootPart.CFrame*CFrame.new(5,0,0)
                        break
                    end
                end
            end
        end)
    end)
end

-- ── ABA 2: MOVIMENTO ──────────────────────────────────────────
do
    local t=TabScrolls[2]
    Section(t,"  Movimentação",1)

    Toggle(t,"⚡","Speed Hack","Move na velocidade do slider abaixo",
        P.teal,P.teal,2,function(on)
        ST.speed=on
        pcall(function()
            LP.Character.Humanoid.WalkSpeed=on and ST.walkSpeed or 16
        end)
    end)

    Slider(t,"🏃","Velocidade",16,250,85,P.teal,3,function(v)
        ST.walkSpeed=v
        if ST.speed then
            pcall(function() LP.Character.Humanoid.WalkSpeed=v end)
        end
    end)

    Toggle(t,"🦅","Fly Mode","Voa pelo mapa (WASD + Espaço)",
        P.purple,P.purple,4,function(on)
        ST.fly=on
        pcall(function()
            local r=LP.Character.HumanoidRootPart
            if on then
                local g=Instance.new("BodyGyro")
                g.Name="_FG" g.MaxTorque=Vector3.new(9e9,9e9,9e9)
                g.D=100 g.Parent=r
                local v2=Instance.new("BodyVelocity")
                v2.Name="_FV" v2.Velocity=Vector3.zero
                v2.MaxForce=Vector3.new(9e9,9e9,9e9) v2.Parent=r
            else
                local g=r:FindFirstChild("_FG")
                local v2=r:FindFirstChild("_FV")
                if g then g:Destroy() end
                if v2 then v2:Destroy() end
            end
        end)
    end)

    Toggle(t,"∞","Infinite Jump","Continua pulando no ar",
        P.gold,P.goldGlw,5,function(on) ST.infJmp=on end)

    Toggle(t,"👻","Noclip","Atravessa paredes e obstáculos",
        P.red,P.redGlow,6,function(on) ST.noclip=on end)

    Section(t,"  Câmera",7)
    Slider(t,"📷","Campo de Visão",40,120,70,P.red,8,function(v)
        ST.fov=v
        pcall(function() workspace.CurrentCamera.FieldOfView=v end)
    end)
end

-- ── ABA 3: EXTRA ──────────────────────────────────────────────
do
    local t=TabScrolls[3]
    Section(t,"  Automação",1)

    Toggle(t,"🤖","Anti-AFK","Nunca toma kick por inatividade",
        P.teal,P.teal,2,function(on)
        ST.antiAfk=on
        if on then
            local vu=Instance.new("VirtualUser") vu.Parent=LP
            Run.Heartbeat:Connect(function()
                if ST.antiAfk then
                    pcall(function()
                        vu:CaptureController()
                        vu:ClickButton2(Vector2.zero)
                    end)
                end
            end)
        end
    end)

    Toggle(t,"💰","Auto Coin Farm","Coleta moedas automaticamente",
        P.gold,P.goldGlw,3,function(on) ST.coinFarm=on end)

    Section(t,"  Ações",4)

    ActionBtn(t,"💀","Resetar Personagem",
        "Morre e volta ao spawn",P.red,5,function()
        pcall(function() LP.Character:BreakJoints() end)
    end)

    ActionBtn(t,"📋","Copiar meu UserID",
        "Salva ID no clipboard",P.purple,6,function()
        pcall(function() setclipboard(tostring(LP.UserId)) end)
    end)

    ActionBtn(t,"🏠","TP ao Lobby","Teleporta para área de espera",
        P.teal,7,function()
        pcall(function()
            local r=LP.Character.HumanoidRootPart
            if r then r.CFrame=CFrame.new(0,10,0) end
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════════
--  TABS SWITCH
-- ═══════════════════════════════════════════════════════════════
local function switchTab(idx)
    ST.tab=idx
    for i,sc in ipairs(TabScrolls) do sc.Visible=i==idx end
    for i,d in ipairs(TabButtons) do
        local a=i==idx
        tween(d.btn,{
            BackgroundColor3=a and d.def.c or rgb(0,0,0),
            BackgroundTransparency=a and 0 or 1,
            TextColor3=a and P.white or P.txtMd,
        },.2):Play()
        if a then
            -- re-aplica gradiente
            for _,ch in d.btn:GetChildren() do
                if ch:IsA("UIGradient") then ch:Destroy() end
            end
            gradient(d.def.c,d.def.g,90,d.btn)
        else
            for _,ch in d.btn:GetChildren() do
                if ch:IsA("UIGradient") then ch:Destroy() end
            end
        end
    end
end
for i,d in ipairs(TabButtons) do
    d.btn.MouseButton1Click:Connect(function() switchTab(i) end)
end

-- ═══════════════════════════════════════════════════════════════
--  ABRIR / FECHAR
-- ═══════════════════════════════════════════════════════════════
local function openMenu()
    ST.open=true
    Overlay.Visible=true
    Panel.Visible=true
    Panel.Size=u(0,PW*0.85,0,PH*0.85)
    Panel.BackgroundTransparency=1
    tween(Overlay,{BackgroundTransparency=0.45},.3):Play()
    tween(Panel,{
        Size=u(0,PW,0,PH),
        BackgroundTransparency=0,
    },.3,"Back","Out"):Play()
    FabIcon.Text="✕"
    tween(FAB,{BackgroundColor3=P.redDk},.2):Play()
end

local function closeMenu()
    ST.open=false
    tween(Overlay,{BackgroundTransparency=1},.25):Play()
    local t2=tween(Panel,{
        Size=u(0,PW*0.88,0,PH*0.88),
        BackgroundTransparency=1,
    },.22,"Quart","In")
    t2:Play()
    t2.Completed:Connect(function()
        Panel.Visible=false
        Overlay.Visible=false
    end)
    FabIcon.Text="🔪"
    tween(FAB,{BackgroundColor3=P.red},.2):Play()
end

local function toggle()
    if ST.open then closeMenu() else openMenu() end
end

FAB.InputEnded:Connect(function(i)
    if (i.UserInputType==Enum.UserInputType.Touch
    or i.UserInputType==Enum.UserInputType.MouseButton1)
    and not fabMov then
        toggle()
    end
end)
CloseX.MouseButton1Click:Connect(closeMenu)
Overlay.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch
    or i.UserInputType==Enum.UserInputType.MouseButton1 then
        closeMenu()
    end
end)

-- ═══════════════════════════════════════════════════════════════
--  RUNTIME
-- ═══════════════════════════════════════════════════════════════
Run.Heartbeat:Connect(function()
    pcall(function()
        local ch=LP.Character if not ch then return end
        local hum=ch:FindFirstChildOfClass("Humanoid")
        local root=ch:FindFirstChild("HumanoidRootPart")
        if hum then
            if ST.speed  then hum.WalkSpeed=ST.walkSpeed end
            if ST.noclip then
                for _,p in ch:GetDescendants() do
                    if p:IsA("BasePart") then p.CanCollide=false end
                end
            end
        end
        if ST.fly and root then
            local bv=root:FindFirstChild("_FV")
            if bv then
                local cam=workspace.CurrentCamera
                local spd=55 local dir=Vector3.zero
                if Inp:IsKeyDown(Enum.KeyCode.W) then dir=dir+cam.CFrame.LookVector  end
                if Inp:IsKeyDown(Enum.KeyCode.S) then dir=dir-cam.CFrame.LookVector  end
                if Inp:IsKeyDown(Enum.KeyCode.A) then dir=dir-cam.CFrame.RightVector end
                if Inp:IsKeyDown(Enum.KeyCode.D) then dir=dir+cam.CFrame.RightVector end
                if Inp:IsKeyDown(Enum.KeyCode.Space)     then dir=dir+Vector3.new(0,1,0) end
                if Inp:IsKeyDown(Enum.KeyCode.LeftShift) then dir=dir-Vector3.new(0,1,0) end
                bv.Velocity=dir.Magnitude>0 and dir.Unit*spd or Vector3.zero
            end
        end
        if ST.coinFarm and root then
            for _,o in workspace:GetDescendants() do
                if o.Name:lower():find("coin") then
                    pcall(function() root.CFrame=o.CFrame end)
                    break
                end
            end
        end
    end)
end)

-- Infinite jump
Inp.JumpRequest:Connect(function()
    if ST.infJmp then pcall(function()
        LP.Character.Humanoid:ChangeState(
            Enum.HumanoidStateType.Jumping)
    end) end
end)

-- ESP contínuo
Run.Heartbeat:Connect(function()
    if not(ST.espMurd or ST.espSher or ST.espAll) then return end
    pcall(function()
        for _,pl in pairs(Plr:GetPlayers()) do
            if pl~=LP then
                local ch=pl.Character
                if ch then
                    if ST.espMurd and ch:FindFirstChild("Knife")
                    and not ch:FindFirstChild("_mESP") then
                        local s=Instance.new("SelectionBox")
                        s.Name="_mESP" s.Color3=rgb(255,20,40)
                        s.SurfaceColor3=rgb(255,20,40)
                        s.SurfaceTransparency=0.55
                        s.LineThickness=0.1
                        s.Adornee=ch s.Parent=ch
                    end
                    if ST.espAll and not ch:FindFirstChild("_aESP") then
                        local s=Instance.new("SelectionBox")
                        s.Name="_aESP" s.Color3=rgb(110,55,255)
                        s.SurfaceColor3=rgb(110,55,255)
                        s.SurfaceTransparency=0.72
                        s.LineThickness=0.05
                        s.Adornee=ch s.Parent=ch
                    end
                end
            end
        end
    end)
end)

-- Animações contínuas
local rt=0
Run.RenderStepped:Connect(function(dt)
    rt=rt+dt
    -- rainbow line
    RGrad.Color=ColorSequence.new{
        ColorSequenceKeypoint.new(0,   rgb(
            math.floor(math.abs(math.sin(rt))*200+55),20,60)),
        ColorSequenceKeypoint.new(0.25,P.purple),
        ColorSequenceKeypoint.new(0.5, P.teal),
        ColorSequenceKeypoint.new(0.75,P.gold),
        ColorSequenceKeypoint.new(1,   rgb(
            math.floor(math.abs(math.sin(rt))*200+55),20,60)),
    }
    -- borda gradiente rotacionando
    BG_UIGrad.Rotation=(rt*18)%360
    -- pulso do logo
    local p=math.abs(math.sin(rt*1.5))
    LogoRing.Size=u(0,50+p*4,0,50+p*4)
    LogoRing.Position=u(0,16-(p*2),0.5,-25-p*2)
end)

print("🔪 Delta MM2 Crimson Night v6.0 — Pronto!")
EOF
echo "✅ $(wc -l < /mnt/user-data/outputs/mm2_ui_v6.lua) linhas"