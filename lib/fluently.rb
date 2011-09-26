module Kernel
	def fluently_def(method_name, &block)
		self.send :define_method, method_name, &block
	end
end
