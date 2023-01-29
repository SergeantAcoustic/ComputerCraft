local args = { ... } or {""}
local out = table.concat(args, " ")
out = string.gsub(out, "\\n", "\n")
print(out)