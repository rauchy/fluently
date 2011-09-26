require 'minitest/spec'
require 'minitest/autorun'

describe "def_fluently" do
	describe "for instance methods" do
		it "defines a simple method" do
			instance = Class.new do 
				def_fluently 'foo' do
					"Bar!"
				end
			end.new

			instance.foo.must_equal "Bar!"
		end
		
		it "defines a method with parameters" do
			instance = Class.new do 
				def_fluently 'foo' do |name|
					"Hello, #{name}!"
				end
			end.new

			instance.foo("rauchy").must_equal "Hello, rauchy!"
		end
	end
end	
