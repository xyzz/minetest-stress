stressedNodeDef = { __type = "stressedNodeDef" }

function stressedNodeDef.__call(self, name)
    assert(type(name) == "string", "name must be of type string")
    self = {
        name = name
    }
    setmetatable(self, stressedNodeDef.__meta)
    return self
end

function stressedNodeDef.on(self, event, func)
    Stress.on(event, func, self.name)
end

stressedNodeDef.__meta = {
    __index = stressedNodeDef
}

setmetatable(stressedNodeDef, { __call = stressedNodeDef.__call })
