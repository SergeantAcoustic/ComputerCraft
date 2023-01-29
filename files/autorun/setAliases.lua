-- add custom aliases
local aliases = {e="edit", cls="clear", man="help",
    screen="monitor", rn="rename"}

-- program path bodge though aliases
local programPath = fs.combine(fs.getDir(fs.getDir(shell.getRunningProgram())), "/programs/")
local programList = fs.list(programPath)
-- aliases[tree] = "/"..fs.combine(fs.getDir(fs.getDir(shell.getRunningProgram())), "/programs/tree.lua")
for _, programName in ipairs(programList) do
	if not (fs.isDir(fs.combine(programPath, programName))) then
		aliases[string.sub(programName, 1, -5)] = "/"..fs.combine(programPath, programName)
	end
end

for key, value in pairs(aliases) do
    shell.setAlias(key, value)
end
