--[[

Stress for Minetest

]]

Stress = {}

stressEvents = {
    place = {}
}

local myPath = minetest.get_modpath(minetest.get_current_modname())

dofile(myPath .. "/config.lua")
dofile(myPath .. "/config.local.lua")

if Stress.config.debug then
    print("Stress.config.debug is enabled. *Never* use this in production!")
    dofile(myPath .. "/tests/run.lua")
end

dofile(myPath .. "/core/Position.lua")
dofile(myPath .. "/core/Area.lua")
dofile(myPath .. "/core/NodeDef.lua")
dofile(myPath .. "/core/Node.lua")
dofile(myPath .. "/core/Stack.lua")
dofile(myPath .. "/core/Inventory.lua")

function Stress.__call(self, first, second)
    if Stress.Position.__valid(first) and Stress.Position.__valid(second) then
        return Stress.Area(Stress.Position(first), Stress.Position(second))
    elseif type(first) == "string" then
        return Stress.NodeDef(first)
    elseif Stress.Position.__valid(first) then
        local pos = Stress.Position(first)
        return Stress.Node(pos)
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

function Stress.fireEvent(event_name, node_name, args)
    if stressEvents[event_name][name] ~= nil then
        for _, v in ipairs(stressEvents[event_name][name]) do
            local r = false
            if args.pos then
                r = v(Stress.Node(Stress.Position(args.pos)), args)
            else
                r = v(args)
            end
            if r then
                return true
            end
        end
    end
    return false
end

function Stress.iterate(self, a, b)
    assert(Stress.Position.__valid(a) and Stress.Position.__valid(b), "both arguments to iterate should be positions")
    local sa = Stress.Position(a)
    local sb = Stress.Position(b)
    local first = Stress.Position({math.min(sa.x, sb.x), math.min(sa.y, sb.y), math.min(sa.z, sb.z)})
    local second = Stress.Position({math.max(sa.x, sb.x), math.max(sa.y, sb.y), math.max(sa.z, sb.z)})
    local current = Stress.Position({first.x - 1, first.y, first.z})
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

function Stress.fireEventEx(event, node, args)
    if not Stress.fireEvent(event, node, args) then
        Stress.fireEvent(event, "", args)
    end
end

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
    local args = {pos = pos, actor = placer}
    Stress.fireEventEx("place", newnode.name, args)
end)

minetest.register_on_dignode(function(pos, oldnode, digger)
    local args = {pos = pos, actor = digger}
    Stress.fireEventEx("dig", oldnode.name, args)
end)

minetest.register_on_punchnode(function(pos, node, puncher)
    local args = {pos = pos, actor = puncher}
    Stress.fireEventEx("punch", node.name, args)
end)

minetest.register_on_chat_message(function(name, message)
    -- umm..
    -- well
end)

_ = Stress
