-- add custom aliases
local aliases = {e="edit", cls="clear", man="help",
    screen="monitor", rn="rename",
    tree="/"..fs.combine(fs.getDir(fs.getDir(shell.getRunningProgram())), "/programs/tree.lua")}

for key, value in pairs(aliases) do
    shell.setAlias(key, value)
end
