stressedNode = {}

function stressedNode.__call(self, pos)
    self = {}
    self.pos = pos
    setmetatable(self, { __index = stressedNode })
    return self
end

function stressedNode.value(self, change)
    if change == nil then
        return minetest.env:get_node(self.pos).name
    else
        minetest.env:set_node(self.pos, {name = change})
    end
end

setmetatable(stressedNode, { __call = stressedNode.__call })
