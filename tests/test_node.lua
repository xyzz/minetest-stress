module(..., package.seeall)

function test_set()
	_({0, 0, 0}):name("default:mese")
	assert_equal("default:mese", minetest.env:get_node({x=0, y=0, z=0}).name)
	assert_equal("default:mese", _({0, 0, 0}):name())
end

function test_set_chain()
	_({0, 0, 0}):name("default:glass"):name("default:mese"):name("default:bookshelf")
	assert_equal("default:bookshelf", _({0, 0, 0}):name())
end

function test_meta()
	_({0, 0, 0}):meta("some", "value")
	assert_equal("value", _({0, 0, 0}):meta("some"))
end
