require 'pry'

module Kernel
	def def_fluently(method_name, &block)
		words = method_name.split(' ')

		method_name = ""
		while words.first =~ /^[^\$]/
			method_name += "#{words.delete_at(0)} "
		end
		method_name =	method_name.strip.gsub(/\s/,'_').downcase

		if words.any?
			words.delete_at(0) while words.any? && words.first =~ /^\$/
			sub_method_name = words.join(' ')

			obj = Class.new do
				def initialize(params)
					@params = params
				end

				def_fluently(sub_method_name, &lambda { block.curry[*@params] })
			end

			inner_block = lambda { |*params| obj.new(params) }
		else
			inner_block = block
		end
		self.send :define_method, method_name, inner_block
	end
	alias_method :deff, :def_fluently
end
