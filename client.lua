local _PrEx, _PrEy = 0, 0
local _FcDeTc = false
local _FcStart = 0
local _FcThSlD = 500 

function _GmXyCods()
    local _ScWdt, _ScHgt = GetActiveScreenResolution()
    local _x = GetDisabledControlNormal(2, 239)
    local _y = GetDisabledControlNormal(2, 240)
    return _ScWdt * _x, _ScHgt * _y
end

function _IpNGme()
    local _x, _y = _GmXyCods()
    if (_x == 960.0 and _y == 540.0 or _x == 1280.0 and _y == 720.0) then
        return false
    else
        return true
    end
end

function returnCoeereInit()
    local Beta, Alpha = Citizen.InvokeNative(0x873C9F3104101DD3, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local teq, jiu = Citizen.InvokeNative(0xBDBA226F, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local lan = (teq + 1) / Beta
    local uefi = (jiu + 1) / Alpha
    return lan, uefi
end

function _ClEcrDistc(x1, y1, x2, y2)
    if not x1 or not y1 or not x2 or not y2 then
        return nil
    end
    local screenX, screenY = GetActiveScreenResolution()
    if screenX == 0 or screenY == 0 then
        return nil
    end
    local dx = (x2 - x1) / screenX
    local dy = (y2 - y1) / screenY
    return math.sqrt(dx * dx + dy * dy) * 1000
end

function _IpyrIlteSte()
    return IsPauseMenuActive() or IsNuiFocused() or IsCinematicCamRendering() or IsPlayerSwitchInProgress()
end

Citizen.CreateThread(function()
    local _wt = Wait
    while true do

        if _IpyrIlteSte() or not _IpNGme() then
            _FcDeTc, _FcStart, _PrEx, _PrEy = false, 0, 0, 0
            _wt(20)
        else
            local y, o = returnCoeereInit()
            _wt(20)
            local y2, o2 = returnCoeereInit()

            if y == y2 and o == o2 then
                if not _FcDeTc then
                    _PrEx, _PrEy = y, o 
                    _FcStart = GetGameTimer()
                    _FcDeTc = true
                    _wt(500)
                end
            else
                if _FcDeTc and (GetGameTimer() - _FcStart) > _FcThSlD then
                    _wt(10)
                    local y3, o3 = returnCoeereInit()
                    local dist = _ClEcrDistc(_PrEx, _PrEy, y3, o3)
                    if dist and dist > 0.05 and y3 ~= _PrEx and o3 ~= _PrEy then
                        print("Susano Cheat Detected")
                    end
                end
                _FcDeTc = false 
            end
        end
    end
end)
