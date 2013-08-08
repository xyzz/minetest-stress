local NodeDef = { __type = "NodeDef" }

function NodeDef.__call(self, name)
    assert(type(name) == "string", "name must be of type string")
    self = {
        name = name
    }
    setmetatable(self, NodeDef.__meta)
    return self
end

function NodeDef.on(self, event, func)
    Stress:on(event, func, self.name)
end

NodeDef.__meta = {
    __index = NodeDef
}

setmetatable(NodeDef, { __call = NodeDef.__call })


Stress.NodeDef = NodeDef
