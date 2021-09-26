local styles = require 'styles'

function getn (t)
	if type(t.n) == "number" then return t.n end
	local max = 0
	for i, _ in t do
		if type(i) == "number" and i>max then max=i end
	end
	return max
end

local Orbit = {
	style = styles.line
}

function Orbit:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self

	return o
end

function Orbit:start()
	local cur = 1
	self.spin = interval(function()
		io.write('\27[1D' .. self.style.stages[cur])
		cur = (cur % 4) + 1
	end, self.style.interval)
	return self.spin
end

function Orbit:stop()
	self.spin:send(true) -- interval() returns a gopher-lua channel, on data it stops the interval
	io.write '\27[2K'
end

return Orbit
