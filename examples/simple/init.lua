_("default:dirt"):on("place", function(me)
    me:value("default:dirt_with_grass")
    -- stop even propagation
    return true
end)

-- turn everything (except default:dirt) into dirt
_.on("place", function(me)
    me:value("default:dirt")
    me:meta("infotext", "hello, world!")
end)
