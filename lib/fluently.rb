module Fluently
	def self.split_methods(complete_method_declaration)
		method_declarations = complete_method_declaration.split(/((?:.*?\s)(?:\$\S*\s)+|.*$)/).reject {|x| x == ""}
		method_declarations.map { |x| x.split(' $').first.strip.gsub(' ', '_') }
	end

	class Temp
		attr_accessor :saved_params

		def initialize
			@saved_params = []
		end
	end
end
