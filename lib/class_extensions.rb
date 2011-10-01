module Fluently
	module ClassExtensions
		def def_fluently(method_name, &block)
			current_object = self

			methods = Fluently.split_methods(method_name)
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
				next_object = current_object
				current_object = Temp.new
				(class << current_object; self; end).instance_eval do
					define_method(method) do |*params|
						next_object.saved_params = self.saved_params + params
						next_object
					end
				end
		end
	end
end

alias_method :deff, :def_fluently
	end
end
