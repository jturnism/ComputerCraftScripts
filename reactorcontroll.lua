--latest main code in raw : https://raw.githubusercontent.com/jturnism/ComputerCraftScripts/main/reactorcontroll.lua
--connect modem to any computer side, connect modem to Activating reactor for power production
reactor = peripheral.wrap("BiggerReactors_Reactor_0")

--something
strbattpercent = ""

--fuction to get reactor active status and return true or false depending on status
function getactive()
    local activestatus = reactor.active()
    if (activestatus) then
        return("Reactor is active")
    else
        return("Reactor is inactive")
    end 
end

function getbattpercent()
    battobj = reactor.battery()
    battcap = battobj.capacity()
    battstoredcap = battobj.stored()
    strbattpercent = math.floor((battstoredcap/battcap)*100)
    print("The battery percentage is : ", strbattpercent)
end

--visuals
function line()
    print("---------------------------------------------------")
end

--visuals
function clear()
    term.setBackgroundColor(colours.black)
    term.clear()
    term.setCursorPos(1,1)
end


while true do
    clear()
    line()
    print(getactive())
    getbattpercent()
    intbattpercent = tonumber(strbattpercent)
    line()
    if (intbattpercent<10) then
        reactor.setActive(true)
        print("Activating reactor for power production")
        while (intbattpercent<90) do
            clear()
            line()
            getactive()
            getbattpercent()
            line()
            print("Producing Power")
            sleep(5)
        end
        line()
    elseif (intbattpercent>=10 and reactor.active()) then
        reactor.setActive(false)
        print("Deactivating reactor since sufficient battery capacity")
        line()
    elseif (intbattpercent>=10 and not reactor.active()) then
        reactor.setActive(false)
        print("Reactor stable and monitoring active")
        line()
    else
        print("Error")
        print("intbattpercent : ", intbattpercent)
        line()
    end
    sleep(5)
end