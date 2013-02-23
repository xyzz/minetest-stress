stressedPosition = { __type = "stressedPosition" }

function stressedPosition.__call(self, something)
    if something.__type == "stressedPosition" then
        return something
    end
    if something.x and something.y and something.z then
        self = {x = something.x,
                y = something.y,
                z = something.z}
    else
        self = {x = something[1],
                y = something[2],
                z = something[3]}
    end
    assert(stressedPosition.__valid(self))
    setmetatable(self, stressedPosition.__meta)
    return self
end

function stressedPosition.__valid(a)
    if a.x and a.y and a.z then
        return type(a.x) == "number" and type(a.y) == "number" and type(a.z) == "number"
    else
        return type(a[1]) == "number" and type(a[2]) == "number" and type(a[3]) == "number"
    end
end

function stressedPosition.__add(a, b)
    sa = stressedPosition(a)
    sb = stressedPosition(b)
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
