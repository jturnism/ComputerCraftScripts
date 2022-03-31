--latest main code in raw : https://raw.githubusercontent.com/jturnism/ComputerCraftScripts/main/reactorcontroll.lua
--connect modem to any computer side, connect modem to Activating reactor for power production

--initalize global variables
reactor = peripheral.wrap("BiggerReactors_Reactor_0")
battpercent = 0

--fuction to get reactor active status and return true or false depending on status
function getactive()
    local activestatus = reactor.active()
    if (activestatus) then
        return("Reactor is active")
    else
        return("Reactor is inactive")
    end 
end

--function to get battery precent
function getbattpercent()
    local battobj = reactor.battery()
    local battcap = battobj.capacity()
    local battstoredcap = battobj.stored()
    battpercent = tonumber(math.floor((battstoredcap/battcap)*100))
    return("Battery is at : "..battpercent.."%")
end

--visuals
function clear()
    term.setBackgroundColor(colours.black)
    term.clear()
    term.setCursorPos(1,1)
end


while true do
    clear()
    print("---------------------------------------------------")
    print(getactive())
    print(getbattpercent())
    print("---------------------------------------------------")
    if (battpercent<30) then
        reactor.setActive(true)
        print("Activating reactor for power production")
        while (battpercent<70) do
            clear()
            print("---------------------------------------------------")
            print(getactive())
            print(getbattpercent())
            print("---------------------------------------------------")
            print("Producing Power")
            sleep(1)
        end
    elseif (battpercent>=30 and reactor.active()) then
        reactor.setActive(false)
        print("Deactivating reactor since sufficient battery capacity")
        print("---------------------------------------------------")
    elseif (battpercent>=30 and not reactor.active()) then
        reactor.setActive(false)
        print("Reactor stable and monitoring active")
        print("---------------------------------------------------")
    else
        print("Error")
        print(getactive())
        print(getbattpercent())
        print("---------------------------------------------------")
    end
    sleep(1)
end