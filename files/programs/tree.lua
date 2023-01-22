local tArgs = { ... }

local function makeTree(dir, args)
    --dir = dir or "/"
    --textutils.pagedPrint("DIR: "..dir.."\n")
    
    local root = fs.list(dir)
    --write(textutils.serialise(root))
    local tree = {}
	for _, fileName in ipairs(root) do
        local filePath = fs.combine(dir, fileName)
        if not(string.sub(fs.getName(filePath), 1, 1) == "." and not(args["a"])) then 
            if fs.isDir(filePath) then
                tree[fileName] = makeTree(filePath, args)
            else
                if not(args["d"]) then tree[fileName] = "" end
            end
        end
    end
        
    --write(textutils.serialize(tree))
    return tree
end

local function recursiveDisplayTree(tree, indent)
    indent = indent or 1
    
    local out = ""
    for file, subfiles in pairs(tree) do
        if type(subfiles) == "string" then
            out = out..string.rep("  ", indent)
        else
            out = out..string.rep("--", indent)
        end
        out = out..file.."\n"
        if type(subfiles) == "table" then
            out = out..recursiveDisplayTree(subfiles, indent+1)
        end
    end
    return out
end

local function displayTree(tree, dir)
    dir = dir or "/"
    local text = dir.."\n"
    text = text..recursiveDisplayTree(tree)
    textutils.pagedPrint(text)
end

local function formatArgs(args)
    local dir = ""
    local argsStr = ""
    if type(args) == "string" then
        if string.sub(args, 1, 1) == "-" then
            argsStr = argsStr..string,sub(args, 2, -1)
        else dir = args end
    else
        for i=1, #args do
            local arg = args[i]
        
            if string.sub(arg, 1, 1) == "-" then
                argsStr = argsStr..string.sub(arg, 2, -1)
            else
                if dir == "" then dir = arg
                else dir = dir..";"..arg end
            end
        end
    end

    if dir == "" then dir = "/" end
    local args = {a = false, d = false} -- default args, set all to false
    
    -- set each arg in string to true
    for i=1, #argsStr do
        arg = string.sub(argsStr, i, i)
        args[arg] = true
    end
    
    return dir, args
end


local function main(argsStr)
    local dir, args = formatArgs(argsStr)
    if args == -1 then return end
    local tree = makeTree(dir, args)
    displayTree(tree, dir)
end

if #tArgs == 0 then
    main(shell.dir())
else
    main(tArgs)
end
