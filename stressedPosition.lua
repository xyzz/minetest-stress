stressedPosition = { __type = "stressedPosition" }

function stressedPosition.__call(self, something)
    if something.x and something.y and something.z then
        self = {x = something.x,
                y = something.y,
                z = something.z}
    else
        self = {x = something[1],
                y = something[2],
                z = something[3]}
    end
    assert(type(self.x) == "number" and type(self.y) == "number" and type(self.z) == "number", "stressedPosition can only accept numbers")
    setmetatable(self, stressedPosition.__meta)
    return self
end

function stressedPosition.__add(a, b)
    assert(a.__type == "stressedPosition" and b.__type == "stressedPosition", "both arguments to add must be of type stressedPosition")
    return stressedPosition({a.x + b.x, a.y + b.y, a.z + b.z})
end

function stressedPosition.__eq(a, b)
    return a.x == b.x and a.y == b.y and a.z == b.z
end

stressedPosition.__meta = {
    __index = stressedPosition,
    __add = stressedPosition.__add,
    __eq = stressedPosition.__eq
}

setmetatable(stressedPosition, { __call = stressedPosition.__call })
