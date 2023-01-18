-- -- add internal program path to path list
-- local path = shell.path()..":/"..fs.combine(fs.getDir(fs.getDir(shell.getRunningProgram())), "/programs")
-- --write(path)
-- shell.setPath(path)
-- write(shell.path())

-- add internal help path to help path
local helpPath = help.path()..":"..fs.combine(fs.getDir(fs.getDir(shell.getRunningProgram())),"/help")
help.setPath(helpPath)

-- adds apis
local function addAPIFolder(path)
    local prevPath = shell.path()
    shell.setPath(path)
    
    local APIList = fs.list(path)

    for i=1, #APIList do
        local API = APIList[i]
        os.loadAPI(API)
    end
    
    shell.setPath(prevPath)
end

local folders = fs.list("/")
for i=1, #folders do
    if fs.isDir(folders[i]) then
        APIPath = fs.combine(folders[i], "/apis/")
        if fs.exists(APIPath) and folders[i] ~= "rom" then
            addAPIFolder(APIPath)
        end
    end
end
