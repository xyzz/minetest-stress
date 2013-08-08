Inventory = { __type = "Inventory" }

function Inventory.__call(self, invref, list)
    self = {
        invref = invref,
        list = list
    }
    setmetatable(self, Inventory.__meta)
    return self
end

function Inventory.stack(self, number)
    return Stress.Stack(self, number)
end

function Inventory.size(self, change)
    if not change then
        return self.invref:get_size(self.list)
    else
        self.invref:set_size(self.list, change)
        return self
    end
end

Inventory.__meta = {
    __index = Inventory
}

setmetatable(Inventory, { __call = Inventory.__call })


Stress.Inventory = Inventory
