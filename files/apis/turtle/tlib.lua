-- turtle library
-- a few handy functions to save time

local function onSlot(slotNum, func, params)
    params = params or {}
    local prevSlot = turtle.getSelectedSlot()
    turtle.select(slotNum)
    out = func(unpack(params))
    turtle.select(prevSlot)
    return out
end

local function onAllSlots(exclude, func, params)
    exclude = exclude or {}
    local doExclude = false
    local prevSlot = turtle.getSelectedSlot()
    for slot=1, 16 do
        doExclude = false
        for i=1, #exclude do
            if exclude[i] == slot then
            doExclude = true end
        end
        if not doExclude then
            turtle.select(slot)
            func()
        end
    end
    turtle.select(prevSlot)
end

local function move(direction, count)
    count = count or 1
    local tbl = {
        forward = turtle.forward,
        back = turtle.back,
        up = turtle.up,
        down = turtle.down
    }
    for _=1, count do
        if turtle.getFuelLevel() == 0 then
            turtle.refuel()
        end
        if tbl[direction] then
            tbl[direction]()
        end
    end
end

local function turn(direction, count)
    count = count or 1
    local tbl = {
        left = turtle.turnLeft,
        right = turtle.turnRight,
    }
    for _=1, count do
        if tbl[direction] then
            tbl[direction]()
        end
    end
end

local function unload()
    local chestSlot = 13
    if onSlot(chestSlot, turtle.compare) then
        onAllSlots({1, 2, 3, chestSlot}, turtle.drop)
    end    
end

return {
    move = move;
    onSlot = onSlot;
	turn = turn;
    onAllSlots = onAllSlots;
}
    
