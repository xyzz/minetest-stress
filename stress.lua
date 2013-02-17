--[[

Stress for Minetest

]]

stressEvents = {
    place = {}
}

local myPath = minetest.get_modpath(minetest.get_current_modname())

dofile(myPath .. "/stressedNodeDef.lua")
dofile(myPath .. "/stressedNode.lua")

Stress = {}

function Stress.__call(self, something)
    if type(something) == "string" then
        return stressedNodeDef(something)
    end
end

Stress.on = function(event)
end

Stress.place = function(what, where)
    if stressEvents["place"][what] ~= nil then
        for _, v in ipairs(stressEvents["place"][what]) do
            v(stressedNode(where))
        end
    end
end

setmetatable(Stress, { __call = Stress.__call })

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
    Stress.place(newnode.name, pos)
end)

_ = Stress
