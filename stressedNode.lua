stressedNode = { __type = "stressedNode" }

function stressedNode.__call(self, pos)
    assert(pos.__type == "stressedPosition", "pos must be of type stressedNodePosition")
    self = {
        pos = pos
    }
    setmetatable(self, stressedNode.__meta)
    return self
end

function stressedNode.value(self, change)
    if change == nil then
        return minetest.env:get_node(self.pos).name
    else
        minetest.env:set_node(self.pos, {name = change})
    end
end

function stressedNode.meta(self, name, change)
    if change == nil then
        return minetest.env:get_meta(self.pos):get_string(name)
    else
        minetest.env:get_meta(self.pos):set_string(name, change)
    end
end

stressedNode.__meta = {
    __index = stressedNode
}

setmetatable(stressedNode, { __call = stressedNode.__call })
