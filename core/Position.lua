Position = { __type = "Position" }

function Position.__call(self, something)
    if something.__type == "Position" then
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
    assert(Position.__valid(self))
    setmetatable(self, Position.__meta)
    return self
end

function Position.__valid(a)
    if type(a) ~= "table" then
        return false
    end
    if a.x and a.y and a.z then
        return type(a.x) == "number" and type(a.y) == "number" and type(a.z) == "number"
    else
        return type(a[1]) == "number" and type(a[2]) == "number" and type(a[3]) == "number"
    end
end

function Position.__add(a, b)
    sa = Position(a)
    sb = Position(b)
    return Position({sa.x + sb.x, sa.y + sb.y, sa.z + sb.z})
end

function Position.__sub(a, b)
    return Position(a) + (-Position(b))
end

function Position.__unm(a)
    return Position({-a.x, -a.y, -a.z})
end

function Position.__eq(a, b)
    return a.x == b.x and a.y == b.y and a.z == b.z
end

Position.__meta = {
    __index = Position,
    __unm = Position.__unm,
    __add = Position.__add,
    __sub = Position.__sub,
    __eq = Position.__eq
}

setmetatable(Position, { __call = Position.__call })


Stress.Position = Position
