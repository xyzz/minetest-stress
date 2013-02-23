--[[

Stress for Minetest

]]

stressEvents = {
    place = {}
}

local myPath = minetest.get_modpath(minetest.get_current_modname())

dofile(myPath .. "/stressedPosition.lua")
dofile(myPath .. "/stressedNodeDef.lua")
dofile(myPath .. "/stressedNode.lua")
dofile(myPath .. "/stressedStack.lua")
dofile(myPath .. "/stressedInventory.lua")

Stress = {}

function Stress.__call(self, something)
    if type(something) == "string" then
        return stressedNodeDef(something)
    end
end

Stress.on = function(self, event, func, name)
    name = name or ""

    if stressEvents[event] ~= nil then
        if stressEvents[event][name] == nil then
            stressEvents[event][name] = {}
        end
        table.insert(stressEvents[event][name], func)
    end
end

Stress.firePlaceEvent = function(name, pos)
    if stressEvents["place"][name] ~= nil then
        for _, v in ipairs(stressEvents["place"][name]) do
            if v(stressedNode(stressedPosition(pos))) then
                return true
            end
        end
    end
    return false
end

setmetatable(Stress, { __call = Stress.__call })

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
    if not Stress.firePlaceEvent(newnode.name, pos) then
        Stress.firePlaceEvent("", pos)
    end
end)

_ = Stress
