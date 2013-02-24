stressedArea = { __type = "stressedArea" }

function stressedArea.__call(self, first, second)
    self = {
        first = first,
        second = second
    }
    setmetatable(self, stressedArea.__meta)
    return self
end

function stressedArea.name(self, change)
    for pos in Stress:iterate(self.first, self.second) do
        stressedNode(pos):name(change)
    end
end

function stressedArea.meta(self, name, value)
    for pos in Stress:iterate(self.first, self.second) do
        stressedNode(pos):meta(name, value)
    end
end

function stressedArea.each(self, func)
    for pos in Stress:iterate(self.first, self.second) do
        func(stressedNode(pos))
    end
end

stressedArea.__meta = {
    __index = stressedArea
}

setmetatable(stressedArea, { __call = stressedArea.__call })
