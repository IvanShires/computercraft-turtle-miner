good_items = {"diamond","gold","lapis","iron","emerald","silver","lead","bauxite","raw","uranium","obsidian","coal","redstone","nickel","torch","copper","tin","ore"}
building_blocks = {"stone","granite","tuff","wood","log","andesite","cobble"}

print("Checking for updated script..")
paste_id = "http://pastebin.com/raw.php?i=ranQP0a1"
pasteContent = http.get(paste_id)
Paste = pasteContent.readAll()
pasteContent.close()

file = fs.open("smartMiner","r")
contents = file.readAll()
file.close()

mining_depth = 0

if (Paste ~= contents) then
        print("Updating program...")
        shell.run("delete","smartMiner")
        wFile = fs.open("smartMiner","w")
        wFile.write(Paste)
        wFile.close()
        sleep(2)
        os.reboot()
end

function ntfy_message(ore)
    local response = http.post("https://ntfy.sh/ishires_smartMiner",os.getComputerID() .. " - Just mined a "..ore)
end

function string_contains(string,good_items)
    for key,value in pairs(good_items) do
        if string.match(string, value) then
            return "True"
        end
    end
end

function check_block()
    local block, block_data = turtle.inspect()
    if block then -- Block is detected by the Turtle
        local block_name = block_data["name"]
        if string_contains(block_name,good_items) then
            print(block_name.." in list of items to mine!")
            turtle.dig()
            ntfy_message(block_name)
        end
    end
end

function turtle_UpInspect()
    local block, block_data = turtle.inspectUp()
    if block then -- Block is detected by the Turtle
        local block_name = block_data["name"]
        if (string.find(block_name,"obsidian")) then
            return true
        else
            return false
        end
    else
        return true
    end
end

function turtle_asend()
    turtle.digUp()
    turtle.up()
end

function bedrock_check()
    local block, block_data = turtle.inspectDown()
    if block then -- Block is detected by the Turtle
        local block_name = block_data["name"]
        if (string.find(block_name,"bedrock")) then
            return true
        else
            return false
        end
    else
        return false
    end
end

args = {...}
distance = args[1]

if (distance % 4 == 0) then
    
    depth_hole = 0

    holes = distance / 4
    for i=1,holes do
        mining = true
        while mining do
            fuel_level = turtle.getFuelLevel()    
            if (mining_depth == 0) then
                if (fuel_level <= 300) then
                    print("Not enough fuel!")
                end
            end

            if bedrock_check() then -- We've hit bedrock, go back up...
                while true do
                    if not turtle_UpInspect() then
                        mining = false
                        break
                    else
                        turtle_asend()
                    end
                end
            else
                for i=1,4 do -- checks all 4 sides of the Turtle
                    check_block()
                    turtle.turnRight()
                end
                turtle.digDown()
                turtle.down()
                depth_hole = depth_hole + 1
            end
        end
    
        
        -- selecting a building block

        building_block_slot = 0
        print("Selecting a building block")
        for i = 1, 16 do
            turtle.select(i)
            local block = turtle.getItemDetail()
            if (block) then
                local block_name = block["name"]
                if string_contains(block_name,building_blocks) then
                    if building_block_slot == 0 then
                        building_block_slot = i
                        break
                    end
                end
            end
        end
        -- Inventory Check
        print("Dumping unneeded inventory")
        for i = 1, 16 do
            if (i ~= building_block_slot) then
                turtle.select(i)
                local block = turtle.getItemDetail()
                if (block) then
                    local block_name = block["name"]
                    if not string_contains(block_name,good_items) then
                        print("Dumping "..block_name)
                        turtle.dropDown()
                    end
                end
            end
        end

        -- Leave no trace
        turtle.select(building_block_slot)
        item_count = turtle.getItemCount()
        item_drop_count = item_count - 1
        turtle.dropDown(item_drop_count)
        turtle.placeDown()

        -- Logic below moves to the next hole
        turtle.dig()
        turtle.forward()
        turtle.dig()
        turtle.forward()
        turtle.dig()
        turtle.forward()
    end

    -- Coming Home Function
    distance_home = holes + (holes * 2) - 2
    turtle.turnRight()
    turtle.turnRight()
    for i=1,distance_home do
        turtle.dig()
        turtle.forward()
    end

else
    print("Value not divisible by 4!")
end