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
    if type(a) ~= "table" then
        return false
    end
    if a.x and a.y and a.z then
        return type(a.x) == "number" and type(a.y) == "number" and type(a.z) == "number"
    else
        return type(a[1]) == "number" and type(a[2]) == "number" and type(a[3]) == "number"
    end
end

function stressedPosition.__add(a, b)
    sa = stressedPosition(a)
    sb = stressedPosition(b)
    return stressedPosition({sa.x + sb.x, sa.y + sb.y, sa.z + sb.z})
end

function stressedPosition.__sub(a, b)
    return stressedPosition(a) + (-stressedPosition(b))
end

function stressedPosition.__unm(a)
    return stressedPosition({-a.x, -a.y, -a.z})
end

function stressedPosition.__eq(a, b)
    return a.x == b.x and a.y == b.y and a.z == b.z
end

stressedPosition.__meta = {
    __index = stressedPosition,
    __unm = stressedPosition.__unm,
    __add = stressedPosition.__add,
    __sub = stressedPosition.__sub,
    __eq = stressedPosition.__eq
}

setmetatable(stressedPosition, { __call = stressedPosition.__call })

function stressedPosition.test()
    assert_equal(stressedPosition({1, 2, 3}), stressedPosition({x=1,y=2,z=3}))
    assert_equal(stressedPosition({1, 2, 3}), -stressedPosition({-1, -2, -3}))
    assert_equal(stressedPosition({1, 2, 3}) + stressedPosition({4, 5, 6}), stressedPosition({5, 7, 9}))
    assert_equal(stressedPosition({1, 2, 3}) - stressedPosition({3, 2, 1}), stressedPosition({-2, 0, 2}))
    assert_false(stressedPosition.__valid(nil))
    assert_true(stressedPosition.__valid({1, 2, 3}))
end
