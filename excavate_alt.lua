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

function turtle_asend()
    local block, block_data = turtle.inspectUp()
    if block then -- Block is detected by the Turtle
        local block_name = block_data["name"]
        if (string.find(block_name,"obsidian")) then
            turtle.dig()
            turtle.up()
        else
            mining = False
        end
    else
        turtle.up()
    end
end

function bedrock_check()
    local block, block_data = turtle.inspectDown()
    if block then -- Block is detected by the Turtle
        local block_name = block_data["name"]
        if (string.find(block_name,"bedrock")) then
            while true do
                turtle_asend()
            end
        else
            turtle.digDown()
            turtle.down()
        end
    else
        turtle.down()
    end
end
mining = True
while mining == True do
    bedrock_check()
    for i=1,4 do -- checks all 4 sides of the Turtle
        check_block()
        turtle.turnRight()
    end
end
