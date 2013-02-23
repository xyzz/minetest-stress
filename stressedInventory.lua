stressedInventory = { __type = "stressedInventory" }

function stressedInventory.__call(self, invref, list)
    self = {
        invref = invref,
        list = list
    }
    setmetatable(self, stressedInventory.__meta)
    return self
end

function stressedInventory.stack(self, number)
    return stressedStack(self, number)
end

function stressedInventory.size(self, change)
    if not change then
        return self.invref:get_size(self.list)
    else
        self.invref:set_size(self.list, change)
    end
end

stressedInventory.__meta = {
    __index = stressedInventory
}

setmetatable(stressedInventory, { __call = stressedInventory.__call })
