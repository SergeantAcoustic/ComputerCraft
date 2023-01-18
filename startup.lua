-- runs all folders called autorun

local function runFolder(path)
    local prevPath = shell.path()
    shell.setPath(path)
    
    local execList = fs.list(path)

    for i=1, #execList do
        local toRun = execList[i]
        shell.run(toRun)
    end
    
    shell.setPath(prevPath)
end

local folders = fs.list("/")
for i=1, #folders do
    if fs.isDir(folders[i]) then
        autorunPath = fs.combine(folders[i], "/autorun/")
        if fs.exists(autorunPath) and folders[i] ~= "rom" then
            runFolder(autorunPath)
        end
    end
end
