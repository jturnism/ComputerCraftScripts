--https://raw.githubusercontent.com/jturnism/ComputerCraftScripts/main/builderwatcher.lua

--set output to monitor and set peripherals as global
builder = peripheral.wrap("rftoolsbuilder:builder_0")
reactor = peripheral.wrap("BiggerReactors_Reactor_2")
term.redirect(peripheral.wrap("monitor_3"))

--poorly made funciton to tell if builder is active by seeing if its energy is full or not (if not then probably active, if full then probably inactive), if ends up being wrong, not too big of deal it will just charge builder/quarry until full
function isbuilderactive()
    local energy = builder.getEnergy()
    local capacity = builder.getEnergyCapacity()
    if (energy == capacity) then
        return(true)
    else
        return(false)
    end
end

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
    local battpercent = tonumber(math.floor((battstoredcap/battcap)*100))
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
    if (isbuilderactive()) then -- if builder/quarry is running, nuclear reactor should be as well to power it
        reactor.active(true)
        print("Activating reactor for power production for Quarry")
        while (isbuilderactive()) do -- keep running until builder is not active
            clear()
            line()
            printreactoractive()
            printreactorbattpercent()
            line()
            print("Producing Power for Quarry")
            sleep(1)
        end
    elseif (getbattpercent()>=30) then -- if battery is over 30%, turn off nuclear reactor as its not really needed
        reactor.setActive(false)
        print("Deactivating reactor since sufficient battery capacity")
    else (getbattpercent()<30) -- if battery is less than 30% turn on nuclear reactor to fill up
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
    end
    sleep(1)
end

    
