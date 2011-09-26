module Kernel
	def def_fluently(method_name, &block)
		self.send :define_method, method_name, &block
	end
end
