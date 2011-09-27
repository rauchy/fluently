module Kernel
	def def_fluently(method_name, &block)
		method_name.gsub!(/\s/,'_')
		method_name.downcase!
		self.send :define_method, method_name, &block
	end
end
