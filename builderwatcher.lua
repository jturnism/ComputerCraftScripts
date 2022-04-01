--https://raw.githubusercontent.com/jturnism/ComputerCraftScripts/main/builderwatcher.lua

--[[
    pseudo code


(most of the same as reactorcontrol.lua)

if (builder.active) then
    reactor.active(true) && override others
elseif (not builder.active) then
    reactor.active(false)
else
    print("Error or something IDK")
end

]]