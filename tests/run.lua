--[[

To be able to run tests and see coverage:
download luacov from https://github.com/norman/luacov
download lunatest from https://github.com/silentbicycle/lunatest
place them into your minetest directory
Copy luacov from luacov/src/bin/luacov to minetest/luacov_s
Your directory structure should look like
luacov
├── defaults.lua
├── reporter.lua
├── runner.lua
├── stats.lua
└── tick.lua
luacov_s
lunatest.lua
report.sh

report.sh:
if [ -f luacov.stats.out ]; then
	lua luacov_s
	rm luacov.stats.out
fi
vim luacov.report.out

]]

require "luacov"
require "lunatest"

local stress_root = minetest.get_modpath(minetest.get_current_modname())

local function test()
	package.path = package.path .. ";" .. stress_root .. "/tests/?.lua"

	-- "hack" to make Minetest load some blocks into memory
	VoxelManip():read_from_map({x=-16, y=-16, z=-16}, {x=15, y=15, z=15})

	lunatest.suite("test_position")
	lunatest.suite("test_node")
	lunatest.suite("test_formspice")
	lunatest.run()

	minetest.request_shutdown()
end

minetest.after(0, test)
