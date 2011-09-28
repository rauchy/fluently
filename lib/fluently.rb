require 'pry'

module Kernel
	def def_fluently(method_name, &block)
	  words = method_name.split(' ')

		method_name = ""
		while words.first =~ /^[^\$]/
			method_name += "#{words.delete_at(0)} "
		end
		method_name.strip!

		if words.any?
			parameter_name = words.delete_at(0)[1..-1]
			sub_method_name = words.join(' ')

			obj = Class.new do
				def initialize(param)
					@param = param
				end

				def_fluently(sub_method_name, &proc { block.curry[@param] })
			end

		  method_name =	method_name.strip.gsub(/\s/,'_').downcase
			self.send :define_method, method_name, proc { |x| obj.new(x) }
		else
		  method_name =	method_name.strip.gsub(/\s/,'_').downcase
			self.send :define_method, method_name, &block
		end
	end
end
