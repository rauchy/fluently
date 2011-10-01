require 'pry'

class Temp
	attr_accessor :saved_params

	def initialize
		@saved_params = []
	end
end

module Kernel
	def def_fluently(method_name, &block)
		current_object = self

		methods = split_methods(method_name)
		methods.reverse.each_with_index do |method, index|
			is_first = index == methods.size - 1
			is_last = index == 0
			is_single = is_first && is_last

			if is_single
				self.send(:define_method, method, block)
			elsif is_first
				self.send(:define_method, method) do |*params|
					current_object.saved_params = params
					current_object
				end
			elsif is_last
				current_object = Temp.new
				(class << current_object ; self ; end).instance_eval do
					define_method(method) do |*params|
						block.call(*self.saved_params)
					end
				end
		else
			obj = Temp.new
			next_object = current_object.clone
			(class << obj; self; end).instance_eval do
				define_method(method) do |*params|
					next_object.saved_params = self.saved_params + params
					next_object
				end
			end
			current_object = obj
	end
end
	end

	private

	def split_methods(complete_method_declaration)
		method_declarations = complete_method_declaration.split(/((?:.*?\s)(?:\$\S*\s)+|.*$)/).reject {|x| x == ""}
		method_declarations.map { |x| x.split(' $').first.strip.gsub(' ', '_') }
	end

	alias_method :deff, :def_fluently
end
