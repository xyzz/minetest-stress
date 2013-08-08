Stack = { __type = "Stack" }

function Stack.__call(self, inventory, number)
    self = {
        inventory = inventory,
        number = number
    }
    setmetatable(self, Stack.__meta)
    return self
end

function Stack.__modify_or_access(self, property, change)
    local itemstack = self.inventory.invref:get_stack(self.inventory.list, self.number):to_table()
    if not change then
        return itemstack[property]
    else
        itemstack[property] = change
        self.inventory.invref:set_stack(self.inventory.list, self.number, itemstack)
    end
end

function Stack.name(self, change)
    return self:__modify_or_access("name", change)
end

function Stack.count(self, change)
    return self:__modify_or_access("count", change)
end

function Stack.wear(self, change)
    return self:__modify_or_access("wear", change)
end

function Stack.take(self, number)
    number = number or 1
    local itemstack = self.inventory.invref:get_stack(self.inventory.list, self.number):to_table()
    itemstack.count = math.max(0, itemstack.count - number)
    self.inventory.invref:set_stack(self.inventory.list, self.number, itemstack)
end

function Stack.value(self, change)
    if not change then
        return self.inventory.invref:get_stack(self.inventory.list, self.number):to_table()
    else
        self.inventory.invref:set_stack(self.inventory.list, self.number, ItemStack(change))
    end
end

Stack.__meta = {
    __index = Stack
}

setmetatable(Stack, { __call = Stack.__call })


Stress.Stack = Stack
