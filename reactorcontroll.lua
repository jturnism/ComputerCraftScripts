reactor = peripheral.wrap("right")
strbattpercent = ""
function getactive()
    activestatus = reactor.active()
    if (activestatus) then
        print("Reactor is active")
    else
        print("Reactor is inactive")
    end 
end
function getbattpercent()
    battobj = reactor.battery()
    battcap = battobj.capacity()
    battstoredcap = battobj.stored()
    strbattpercent = math.floor((battstoredcap/battcap)*100)
    print("The battery percentage is : ", strbattpercent)
end
function line()
    print("---------------------------------------------------")
end
function clear()
    term.setBackgroundColor(colours.black)
    term.clear()
    term.setCursorPos(1,1)
end
while true do
    clear()
    line()
    getactive()
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