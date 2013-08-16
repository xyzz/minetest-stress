local escape = minetest.formspec_escape

local function process_xy(item)
    return string.format("%g,%g;", item.x or 0, item.y or 0)
end

local function process_wh(item)
    return string.format("%g,%g;", item.w or 0, item.h or 0)
end

local function process_xy_wh(item)
    return process_xy(item) .. process_wh(item)
end

local function process_item(item)
    local item_name = item[1]
    if item_name == "input" then
        if item.password then
            -- pwdfield
            return string.format("pwdfield[%s%s;%s]", process_xy_wh(item), escape(item.name or ""), escape(item.label or ""))
        elseif item.multiline then
            -- textarea
            return string.format("textarea[%s%s;%s;%s]", process_xy_wh(item), escape(item.name or ""), escape(item.label or ""), escape(item.default or ""))
        else
            -- field
            return string.format("field[%s%s;%s;%s]", process_xy_wh(item), escape(item.name or ""), escape(item.label or ""), escape(item.default or ""))
        end
    elseif item_name == "label" then
        local name = nil
        if item.vertical then
            name = "vertlabel"
        else
            name = "label"
        end
        return string.format("%s[%s%s]", name, process_xy(item), escape(item.value or ""))
    elseif item_name == "image" or item_name == "background" then
        return string.format("%s[%s%s]", item_name, process_xy_wh(item), escape(item.image or ""))
    end
end

-- Processes table-based formspec (see docs) and returns string
function Stress.formspec(width, height, ...)
    local arg = {...}  -- wtf, pil?
    local output = string.format("size[%g,%g]", width, height)
    for i, v in ipairs(arg) do
        output = output .. process_item(v)
    end
    return output
end

-- global shortcut, use it!
-- blah blah global blah namespace blah pollution
formspec = Stress.formspec
