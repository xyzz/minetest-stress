module(..., package.seeall)

function test_constructor()
    assert_equal(Stress.Position({1, 2, 3}), Stress.Position({x=1,y=2,z=3}))
end

function test_unary_minus()
    assert_equal(Stress.Position({1, 2, 3}), -Stress.Position({-1, -2, -3}))
end

function test_sum()
    assert_equal(Stress.Position({1, 2, 3}) + Stress.Position({4, 5, 6}), Stress.Position({5, 7, 9}))
end

function test_sub()
    assert_equal(Stress.Position({1, 2, 3}) - Stress.Position({3, 2, 1}), Stress.Position({-2, 0, 2}))
end

function test_validness()
    assert_false(Stress.Position.__valid(nil))
    assert_true(Stress.Position.__valid({1, 2, 3}))
end
