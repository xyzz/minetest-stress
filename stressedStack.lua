stressedStack = { __type = "stressedStack" }

function stressedStack.__call(self, inventory, number)
    self = {
        inventory = inventory,
        number = number
    }
    setmetatable(self, stressedStack.__meta)
    return self
end

function stressedStack.__modify_or_access(self, property, change)
    local itemstack = self.inventory.invref:get_stack(self.inventory.list, self.number):to_table()
    if not change then
        return itemstack[property]
    else
        itemstack[property] = change
        self.inventory.invref:set_stack(self.inventory.list, self.number, itemstack)
    end
end

function stressedStack.name(self, change)
    return self:__modify_or_access("name", change)
end

function stressedStack.count(self, change)
    return self:__modify_or_access("count", change)
end

function stressedStack.wear(self, change)
    return self:__modify_or_access("wear", change)
end

function stressedStack.take(self, number)
    number = number or 1
    local itemstack = self.inventory.invref:get_stack(self.inventory.list, self.number):to_table()
    itemstack.count = math.max(0, itemstack.count - number)
    self.inventory.invref:set_stack(self.inventory.list, self.number, itemstack)
end

function stressedStack.value(self, change)
    if not change then
        return self.inventory.invref:get_stack(self.inventory.list, self.number):to_table()
    else
        self.inventory.invref:set_stack(self.inventory.list, self.number, ItemStack(change))
    end
end

stressedStack.__meta = {
    __index = stressedStack
}

setmetatable(stressedStack, { __call = stressedStack.__call })
