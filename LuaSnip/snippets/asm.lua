local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local i = ls.insert_node
local s = ls.snippet

return {
  s("label", fmt("{}:\n\t{}", { i(1, "label"), i(0) })),
  s("func", fmt([[
.global {}
.type {}, @function
{}:
	{}
	ret
.size {}, .-{}
]], { i(1, "function_name"), rep(1), rep(1), i(0), rep(1), rep(1) })),
  s("start64", fmt([[
.global _start
.text

_start:
	{}
	mov $60, %rax
	xor %rdi, %rdi
	syscall
]], { i(0) })),
}
