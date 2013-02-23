_("default:dirt"):on("place", function(me)
    me:value("default:dirt_with_grass")
end)

_("default:cobble"):on("place", function(me)
    me:meta("formspec", "size[8,9]list[current_name;main;0,0;8,4;]list[current_player;main;0,5;8,4;]")
    me:inventory("main"):size(8*4)
    me:inventory("main"):stack(1):value("default:dirt 5")
end)

_:on("place", function()
    _({0,0,0}):value("default:dirt")
end)
