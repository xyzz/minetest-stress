_("default:dirt"):on("place", function(me)
    me:value("default:dirt_with_grass")
    -- stop even propagation
    return true
end)

-- turn everything (except default:dirt) into dirt
_:on("place", function(me)
    me:value("default:dirt")
    me:meta("infotext", "hello, world!")
end)

_("default:cobble"):on("place", function(me)
    me:meta("formspec", "size[8,9]list[current_name;main;0,0;8,4;]list[current_player;main;0,5;8,4;]")
    me:inventory("main"):size(8*4)
    me:inventory("main"):stack(1):value("default:dirt 5")
    return true
end)
