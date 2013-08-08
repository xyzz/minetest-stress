local Area = { __type = "Area" }

function Area.__call(self, first, second)
    self = {
        first = first,
        second = second
    }
    setmetatable(self, Area.__meta)
    return self
end

function Area.name(self, change)
    for pos in Stress:iterate(self.first, self.second) do
        stressedNode(pos):name(change)
    end
    return self
end

function Area.meta(self, name, value)
    for pos in Stress:iterate(self.first, self.second) do
        stressedNode(pos):meta(name, value)
    end
    return self
end

function Area.each(self, func)
    for pos in Stress:iterate(self.first, self.second) do
        func(stressedNode(pos))
    end
    return self
end

Area.__meta = {
    __index = Area
}

setmetatable(Area, { __call = Area.__call })


Stress.Area = Area
