module(..., package.seeall)

function test_set()
	_({0, 0, 0}):name("default:mese")
	assert_equal("default:mese", minetest.env:get_node({x=0, y=0, z=0}).name)
end
