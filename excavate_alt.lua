good_items = {"diamond","gold","lapis","iron","emerald","uranium","obsidian","coal","redstone","torch","copper","tin","ore"}

print("Checking for updated script..")
paste_id = "http://pastebin.com/raw.php?i=ranQP0a1"
pasteContent = http.get(paste_id)
Paste = pasteContent.readAll()
pasteContent.close()

file = fs.open("smartMiner","r")
contents = file.readAll()
file.close()
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
        if string.match(value, string) then
            return "True"
        end
    end
end

function check_block()
    local block, block_data = turtle.inspect()
    if block then -- Block is detected by the Turtle
        local block_name = block_data["name"]
        if (string.find(block_name,"diamond")) then
            turtle.dig()
            ntfy_message(block_name)
        elseif (string.find(block_name,"iron")) then
            turtle.dig()
            ntfy_message(block_name)
        elseif (string.find(block_name,"lapis")) then
            turtle.dig()
            ntfy_message(block_name)
        elseif (string.find(block_name,"gold")) then
            turtle.dig()
            ntfy_message(block_name)
        elseif (string.find(block_name,"tin")) then
            turtle.dig()
            ntfy_message(block_name)
        elseif (string.find(block_name,"coal")) then
            turtle.dig()
            ntfy_message(block_name)
        elseif (string.find(block_name,"coal")) then
            turtle.dig()
            ntfy_message(block_name)
        elseif (string.find(block_name,"obsidian")) then
            turtle.dig()
            ntfy_message(block_name)
        elseif (string.find(block_name,"redstone")) then
            turtle.dig()
            ntfy_message(block_name)
        elseif (string.find(block_name,"ore")) then
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
            return "True"
        else
            return "False"
        end
    else
        return "True"
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
            return "True"
        else
            return "False"
        end
    else
        return "False"
    end
end
mining = "True"
while mining == "True" do
    if (bedrock_check() == "True") then -- We've hit bedrock, go back up...
        while true do
            if (turtle_UpInspect() == "False") then
                mining = "False"
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
    end
    
end
-- Inventory Check
for i = 1, 16 do
    turtle.select(i)
    block_data = turtle.getItemDetail()
    block_name = block_data["name"]
    if string_contains(block_name,good_items) then
        print("yay")
    else
        print("nope")
    end
  end