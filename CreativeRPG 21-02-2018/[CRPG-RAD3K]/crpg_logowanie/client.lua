--[[
  Autor: Asper
  Dla servera: .newMode
  Skrypt: Logowanie
]]

if getElementData(localPlayer, "zalogowany") then return end

local screenW, screenH = guiGetScreenSize()

local muzyka = false
local uzytkownik = guiCreateEdit(0.406, 0.395, 0.1976, 0.06, "", true)
local haslo = guiCreateEdit(0.406, 0.506, 0.1976, 0.06, "", true)
guiEditSetMaxLength(uzytkownik, 10)
guiEditSetMaxLength(haslo, 25)
guiSetAlpha(uzytkownik, 0.5)
guiSetAlpha(haslo, 0.5)
guiEditSetMasked(haslo, true)

local c = guiCreateFont( "cz.ttf", 10 )
guiSetFont(uzytkownik, c)
guiSetFont(haslo, c)

guiSetVisible(uzytkownik, false)
guiSetVisible(haslo, false)

local sx, sy = guiGetScreenSize()

function mysz(psx,psy,pssx,pssy,abx,aby)
    if not isCursorShowing() then return end
    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

local logowanie = true
local rejestracja = false

addEventHandler("onClientClick", root, function(button, state)
  local login = guiGetText(uzytkownik)
  local haslo = guiGetText(haslo)
  if button == "left" and state == "down" and mysz(screenW * 0.5161, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612) and logowanie == true then
    logowanie = false
    rejestracja = true
    removeEventHandler("onClientRender", root, gui)
    addEventHandler("onClientRender", root, gui3)
  elseif button == "left" and state == "down" and mysz(screenW * 0.5161, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612) and rejestracja == true then
    logowanie = true
    rejestracja = false
    addEventHandler("onClientRender", root, gui)
    removeEventHandler("onClientRender", root, gui3)
  elseif button == "left" and state == "down" and mysz(screenW * 0.3163, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612) and logowanie == true then
    if login:len() < 3 then
      zmienPowiadomienie("Podany login ma za mało znaków.")
      return
    end
    if haslo:len() < 3 then
      zmienPowiadomienie("Podane hasło ma za mało znaków.")
      return
    end
    login = string.gsub(login, "[ ]", "")
    haslo = string.gsub(haslo, "[ ]", "")
    triggerServerEvent("zaloguj", localPlayer, login, haslo)
  elseif button == "left" and state == "down" and mysz(screenW * 0.3163, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612) and rejestracja == true then
    if login:len() < 3 then
      zmienPowiadomienie("Podany login ma za mało znaków.")
      return
    end
    if haslo:len() < 3 then
      zmienPowiadomienie("Podany hasło ma za mało znaków.")
      return
    end
    login = string.gsub(login, "[ ]", "")
    haslo = string.gsub(haslo, "[ ]", "")
    triggerServerEvent("zarejestruj", localPlayer, login, haslo)
  end
end)

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

local czcionka = dxCreateFont(":crpg_fonty/f.ttf", 10)
local czcionka2 = dxCreateFont(":crpg_fonty/f.ttf", 15)
local czcionka3 = dxCreateFont(":crpg_fonty/f.ttf", 10)
if not czcionka then czcionka = "default-bold" end
if not czcionka2 then czcionka2 = "default-bold" end
if not czcionka3 then czcionka3 = "default-bold" end

function gui()
        setCameraMatrix(1699.6131591797, 1371.0799560547, 71.030899047852, 1700.0849609375, 1371.9223632813, 70.770652770996)
        dxDrawRectangle(screenW * 0.2972, screenH * 0.2930, screenW * 0.4114, screenH * 0.4388, tocolor(15, 15, 15, 175))
        dxDrawRectangle(screenW * 0.2804, screenH * 0.2930, screenW * 0.4414, screenH * 0.0534, tocolor(0, 94, 254, 255), false)
        dxDrawText("Panel logowania", (screenW * 0.2804) + 1, (screenH * 0.2917) + 1, (screenW * 0.7218) + 1, (screenH * 0.3464) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Panel logowania", screenW * 0.2804, screenH * 0.2917, screenW * 0.7218, screenH * 0.3464, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Login", (screenW * 0.3089) + 1, (screenH * 0.3841) + 1, (screenW * 0.3946) + 1, (screenH * 0.4596) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Login", screenW * 0.3089, screenH * 0.3841, screenW * 0.3946, screenH * 0.4596, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Hasło", (screenW * 0.3089) + 1, (screenH * 0.4961) + 1, (screenW * 0.3946) + 1, (screenH * 0.5716) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Hasło", screenW * 0.3089, screenH * 0.4961, screenW * 0.3946, screenH * 0.5716, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        if mysz(screenW * 0.3163, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612) then
        	dxDrawButton(screenW * 0.3163, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612, tocolor(0, 94, 254, 125), false)
        else
        	dxDrawButton(screenW * 0.3163, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612, tocolor(15, 15, 15, 125), false)
        end
        if mysz(screenW * 0.5161, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612) then
        	dxDrawButton(screenW * 0.5161, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612, tocolor(0, 94, 254, 125), false)
        else
        	dxDrawButton(screenW * 0.5161, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612, tocolor(15, 15, 15, 125), false)
        end
        dxDrawText("Zaloguj", (screenW * 0.3155) + 1, (screenH * 0.6810) + 1, (screenW * 0.4898) + 1, (screenH * 0.7448) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Zaloguj", screenW * 0.3155, screenH * 0.6810, screenW * 0.4898, screenH * 0.7448, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Rejestracja", (screenW * 0.5161) + 1, (screenH * 0.6810) + 1, (screenW * 0.6903) + 1, (screenH * 0.7448) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Rejestracja", screenW * 0.5161, screenH * 0.6810, screenW * 0.6903, screenH * 0.7448, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.4078, screenH * 0.3971, screenW * 0.1955, screenH * 0.0560, tocolor(255, 255, 255, 200), false)
        dxDrawRectangle(screenW * 0.4078, screenH * 0.5091, screenW * 0.1955, screenH * 0.0560, tocolor(255, 255, 255, 200), false)
end

function gui3()
        setCameraMatrix(1699.6131591797, 1371.0799560547, 71.030899047852, 1700.0849609375, 1371.9223632813, 70.770652770996)
        dxDrawRectangle(screenW * 0.2972, screenH * 0.2930, screenW * 0.4114, screenH * 0.4388, tocolor(15, 15, 15, 175))
        dxDrawRectangle(screenW * 0.2804, screenH * 0.2930, screenW * 0.4414, screenH * 0.0534, tocolor(0, 94, 254, 255), false)
        dxDrawText("Panel rejestracji", (screenW * 0.2804) + 1, (screenH * 0.2917) + 1, (screenW * 0.7218) + 1, (screenH * 0.3464) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Panel rejestracji", screenW * 0.2804, screenH * 0.2917, screenW * 0.7218, screenH * 0.3464, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Login", (screenW * 0.3089) + 1, (screenH * 0.3841) + 1, (screenW * 0.3946) + 1, (screenH * 0.4596) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Login", screenW * 0.3089, screenH * 0.3841, screenW * 0.3946, screenH * 0.4596, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Hasło", (screenW * 0.3089) + 1, (screenH * 0.4961) + 1, (screenW * 0.3946) + 1, (screenH * 0.5716) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Hasło", screenW * 0.3089, screenH * 0.4961, screenW * 0.3946, screenH * 0.5716, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        if mysz(screenW * 0.3163, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612) then
        	dxDrawButton(screenW * 0.3163, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612, tocolor(0, 94, 254, 125), false)
        else
        	dxDrawButton(screenW * 0.3163, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612, tocolor(15, 15, 15, 125), false)
        end
        if mysz(screenW * 0.5161, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612) then
        	dxDrawButton(screenW * 0.5161, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612, tocolor(0, 94, 254, 125), false)
        else
        	dxDrawButton(screenW * 0.5161, screenH * 0.6836, screenW * 0.1735, screenH * 0.0612, tocolor(15, 15, 15, 125), false)
        end
        dxDrawText("Zarejestruj", (screenW * 0.3155) + 1, (screenH * 0.6810) + 1, (screenW * 0.4898) + 1, (screenH * 0.7448) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Zarejestruj", screenW * 0.3155, screenH * 0.6810, screenW * 0.4898, screenH * 0.7448, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Logowanie", (screenW * 0.5161) + 1, (screenH * 0.6810) + 1, (screenW * 0.6903) + 1, (screenH * 0.7448) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawText("Logowanie", screenW * 0.5161, screenH * 0.6810, screenW * 0.6903, screenH * 0.7448, tocolor(255, 255, 255, 255), 1.00, czcionka2, "center", "center", false, false, false, false, false)
        dxDrawRectangle(screenW * 0.4078, screenH * 0.3971, screenW * 0.1955, screenH * 0.0560, tocolor(255, 255, 255, 200), false)
        dxDrawRectangle(screenW * 0.4078, screenH * 0.5091, screenW * 0.1955, screenH * 0.0560, tocolor(255, 255, 255, 200), false)
end

local napisy = "?"
local spawn = 2
local gui2s = false
local mspawn = 3
local spawn3 = "Mechanik, San Fierro"
local spawn2 = "Przechowywalnia, Las Venturas"
local spawn1 = "Urząd miasta, Las Venturas"

bindKey("arrow_l", "both", function(k, s)
  if s ~= "down" then return end
  if gui2s ~= true then return end
  if spawn == 1 then return end
  spawn = spawn-1
end)

bindKey("arrow_r", "both", function(k, s)
  if s ~= "down" then return end
  if gui2s ~= true then return end
  if spawn == 4 then return end
  spawn = spawn+1
end)

bindKey("space", "down", function()
  if gui2s ~= true then return end
  removeEventHandler("onClientRender", root, gui2)
  gui2s = false
  showChat(true)
  showCursor(false)
  stopSound(muzyka)
  if spawn == 1 then
    triggerServerEvent("spawn", localPlayer, "ratusz")
  elseif spawn == 2 then
    triggerServerEvent("spawn", localPlayer, "przechowywalnia")
  elseif spawn == 3 then
    triggerServerEvent("spawn", localPlayer, "mechanik")
  end
end)

function gui2()
  if spawn == 1 then 
    napisy = spawn1 
    setCameraMatrix(2128.6645507813, 2328.6245117188, 16.409599304199, 2128.6455078125, 2329.6140136719, 16.267116546631)
  end
  if spawn == 2 then 
    napisy = spawn2 
    setCameraMatrix(1940.1501464844, 2161.6770019531, 12.747699737549, 1941.1472167969, 2161.6760253906, 12.670433044434)
  end
  if spawn == 3 then 
    napisy = spawn3 
    setCameraMatrix(-1987.4357910156, 157.00520324707, 30.318300247192, -1988.4041748047, 156.91841125488, 30.084545135498)
  end
    dxDrawButton(screenW * 0.3715, screenH * 0.0260, screenW * 0.2130, screenH * 0.0794, tocolor(30, 30, 30, 100))
    dxDrawText(napisy.."\nAby zarządać użyj strzałek\nAby zatwierdzić opcje użyj spacji", (screenW * 0.2050) + 1, (screenH * 0.0117) + 1, (screenW * 0.7555) + 1, (screenH * 0.1211) + 1, tocolor(0, 0, 0, 255), 1.00, czcionka3, "center", "center", false, false, false, false, false)
    dxDrawText(napisy.."\nAby zarządać użyj strzałek\nAby zatwierdzić opcje użyj spacji", screenW * 0.2050, screenH * 0.0117, screenW * 0.7555, screenH * 0.1211, tocolor(255, 255, 255, 255), 1.00, czcionka3, "center", "center", false, false, false, false, false)
end

addEventHandler("onClientResourceStart", resourceRoot, function()
  guiSetVisible(uzytkownik, true)
  guiSetVisible(haslo, true)
  addEventHandler("onClientRender", root, gui)
  showChat(false)
  showCursor(true)
  showPlayerHudComponent("all", false)
  muzyka = playSound("muzyka.mp3", true)
  fadeCamera(true)
  triggerServerEvent("sprawdzBana", localPlayer)
end)

addEvent("bShowedLogin", true)
addEventHandler("bShowedLogin", root, function()
  guiSetVisible(uzytkownik, false)
  guiSetVisible(haslo, false)
  removeEventHandler("onClientRender", root, gui)
  logowanie = false
end)

addEvent("usunElementyLogowania", true)
addEventHandler("usunElementyLogowania", root, function(domy)
  guiSetVisible(uzytkownik, false)
  guiSetVisible(haslo, false)
  removeEventHandler("onClientRender", root, gui)
  removeEventHandler("onClientRender", root, gui3)
  addEventHandler("onClientRender", root, gui2)
  gui2s = true
  logowanie = false
  rejestracja = false
end)

function zmienPowiadomienie(text)
  exports["crpg_powiadomienia"]:noti(text)
end
addEvent("zmienPowiadomienie", true)
addEventHandler("zmienPowiadomienie", root, zmienPowiadomienie)
