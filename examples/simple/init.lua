_("default:dirt"):on("place", function(me)
    _(me.pos + {0,1,0}):name("default:dirt")
    me:name("air")
end)

_("default:cobble"):on("place", function(me)
    me:meta("formspec", "size[8,9]list[current_name;main;0,0;8,4;]list[current_player;main;0,5;8,4;]")
    me:inventory("main"):size(8*4)
    me:inventory("main"):stack(1):value("default:dirt 5")
end)

_:on("place", function()
    _({0,0,0}):name("default:dirt")
end)

for pos in _:iterate({0, 0, 0}, {1, 1, 1}) do
    print(dump(node))
end

_("default:wood"):on("place", function(me)
    _(me.pos - {1, 1, 1}, me.pos + {1, 1, 1}):name("default:mese")
    _(me.pos, me.pos + {2, 2, 2}):each(function(node)
        node:name("air")
    end)
end)
