require 'pry'

module Kernel
	def def_fluently(method_name, parameter_index=0, &block)
		words = method_name.split(' ')

		method_name = ""
		while words.first =~ /^[^\$]/
			method_name += "#{words.delete_at(0)} "
		end
		method_name =	method_name.strip.gsub(/\s/,'_').downcase

		if words.any?
			inner_arity = 0
			while words.any? && words.first =~ /^\$/
				words.delete_at(0)
				inner_arity += 1
			end

			sub_method_name = words.join(' ')

			obj = Class.new do
				def initialize(params)
					@params = params
				end

				def_fluently(sub_method_name, parameter_index+inner_arity, &lambda { block.curry[*(@params.take(inner_arity))] })
			end

			inner_block = lambda { |*params| obj.new(params) }
		else
			inner_block = block
		end
		self.send :define_method, method_name, inner_block
	end
	alias_method :deff, :def_fluently
end
