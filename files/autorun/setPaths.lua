-- -- add internal program path to path list
-- local path = shell.path()..":/"..fs.combine(fs.getDir(fs.getDir(shell.getRunningProgram())), "/programs")
-- --write(path)
-- shell.setPath(path)
-- write(shell.path())

-- add internal help path to help path
local helpPath = help.path()..":"..fs.combine(fs.getDir(fs.getDir(shell.getRunningProgram())),"/help")
help.setPath(helpPath)