--[[

Stress for Minetest

]]

Stress = {}

stressEvents = {
    place = {}
}

local myPath = minetest.get_modpath(minetest.get_current_modname())

dofile(myPath .. "/config.lua")

if Stress.config.debug then
    print("Stress.config.debug is enabled. *Never* use this in production!")
    dofile(myPath .. "/tests.lua")
end

dofile(myPath .. "/stressedPosition.lua")
dofile(myPath .. "/stressedArea.lua")
dofile(myPath .. "/stressedNodeDef.lua")
dofile(myPath .. "/stressedNode.lua")
dofile(myPath .. "/stressedStack.lua")
dofile(myPath .. "/stressedInventory.lua")

function Stress.__call(self, first, second)
    if stressedPosition.__valid(first) and stressedPosition.__valid(second) then
        return stressedArea(stressedPosition(first), stressedPosition(second))
    elseif type(first) == "string" then
        return stressedNodeDef(first)
    elseif stressedPosition.__valid(first) then
        local pos = stressedPosition(first)
        return stressedNode(pos)
    end
end

function Stress.on(self, event, func, name)
    name = name or ""

    if stressEvents[event] ~= nil then
        if stressEvents[event][name] == nil then
            stressEvents[event][name] = {}
        end
        table.insert(stressEvents[event][name], func)
    end
end

function Stress.firePlaceEvent(name, pos)
    if stressEvents["place"][name] ~= nil then
        for _, v in ipairs(stressEvents["place"][name]) do
            if v(stressedNode(stressedPosition(pos))) then
                return true
            end
        end
    end
    return false
end

function Stress.iterate(self, a, b)
    assert(stressedPosition.__valid(a) and stressedPosition.__valid(b), "both arguments to iterate should be positions")
    local sa = stressedPosition(a)
    local sb = stressedPosition(b)
    local first = stressedPosition({math.min(sa.x, sb.x), math.min(sa.y, sb.y), math.min(sa.z, sb.z)})
    local second = stressedPosition({math.max(sa.x, sb.x), math.max(sa.y, sb.y), math.max(sa.z, sb.z)})
    local current = stressedPosition({first.x - 1, first.y, first.z})
    return function()
        current.x = current.x + 1
        if current.x > second.x then
            current.x = first.x
            current.y = current.y + 1
        end
        if current.y > second.y then
            current.y = first.y
            current.z = current.z + 1
        end
        if current.z <= second.z then
            return current
        end
    end
end

setmetatable(Stress, { __call = Stress.__call })

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
    if not Stress.firePlaceEvent(newnode.name, pos) then
        Stress.firePlaceEvent("", pos)
    end
end)

_ = Stress
