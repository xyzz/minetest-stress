local Node = { __type = "Node" }

function Node.__call(self, pos)
    assert(pos.__type == "Position", "pos must be of type Position")
    self = {
        pos = pos
    }
    setmetatable(self, Node.__meta)
    return self
end

function Node.name(self, change)
    if change == nil then
        return minetest.env:get_node(self.pos).name
    else
        minetest.env:set_node(self.pos, {name = change})
        return self
    end
end

function Node.meta(self, name, change)
    if change == nil then
        return minetest.env:get_meta(self.pos):get_string(name)
    else
        minetest.env:get_meta(self.pos):set_string(name, change)
        return self
    end
end

function Node.inventory(self, name)
    return stressedInventory(minetest.get_inventory({type="node",pos=self.pos}), name)
end

Node.__meta = {
    __index = Node
}

setmetatable(Node, { __call = Node.__call })


Stress.Node = Node
