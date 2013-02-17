stressedNodeDef = {}

function stressedNodeDef.__call(self, name)
    self = {}
    self.name = name
    setmetatable(self, { __index = stressedNodeDef })
    return self
end

function stressedNodeDef.on(self, event, func)
    if stressEvents[event] ~= nil then
        if stressEvents[event][self.name] == nil then
            stressEvents[event][self.name] = {}
        end
        table.insert(stressEvents[event][self.name], func)
    end
end

setmetatable(stressedNodeDef, { __call = stressedNodeDef.__call })
