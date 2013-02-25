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

function Stress.test()
    stressedPosition.test()
end

minetest.after(0, Stress.test)
