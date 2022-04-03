--latest main code in raw : https://raw.githubusercontent.com/jturnism/ComputerCraftScripts/main/reactorcontrol.lua
--connect modem to any computer side, connect modem to reactor computer port, connect modem to monitor, connect all with network cable, rightclick each modem to activate

--setup monitor for redirection (6monitors in 2x3 works best)
--term.redirect(peripheral.wrap("monitor_0"))

--initalize global variables
reactor = peripheral.wrap("BiggerReactors_Reactor_0")

--fuction to get reactor active status and return true or false depending on status
function getreactoractive()
    local activestatus = reactor.active()
    if (activestatus) then
        return(true)
    else
        return(false)
    end 
end

--function to print reactor status
function printreactoractive()
    if (getreactoractive()) then
        print("Reactor is active")
    else
        print("Reactor is inactive")
    end
end

--function to get reactor battery precent
function getreactorbattpercent()
    local battobj = reactor.battery()
    local battcap = battobj.capacity()
    local battstoredcap = battobj.stored()
    local battpercent = math.floor((battstoredcap/battcap)*100)
    return(battpercent)
end

function printreactorbattpercent()
    print("Reactor battery is at : "..getreactorbattpercent().."%")
end

--visuals
function clear()
    term.setBackgroundColor(colours.black)
    term.clear()
    term.setCursorPos(1,1)
end

--visuals
function line()
    print("-----------------------------")
end

while true do --loop the main code
    clear()
    line()
    printreactoractive()
    printreactorbattpercent()
    if (getbattpercent()>=30) then -- if battery is over 30%, turn off nuclear reactor as its not really needed
        reactor.setActive(false)
        print("Deactivating reactor since sufficient battery capacity")
    elseif (getbattpercent()<30) then -- if battery is less than 30% turn on nuclear reactor to fill up
        reactor.setActive(true)
        print("Activating reactor for power production")
        while (getbattpercent()<=70) do -- continue filling up until 70%
            clear()
            line()
            printreactoractive()
            printreactorbattpercent()
            line()
            print("Producing Power")
            sleep(1)
        end
    else
        print("Error")
    end
    sleep(1)
end