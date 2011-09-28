require 'minitest/spec'
require 'minitest/autorun'

describe "def_fluently" do
	describe "for instance methods" do
		it "defines a single word method" do
			instance = Class.new do 
				def_fluently 'foo' do
					"Bar!"
				end
			end.new

			instance.foo.must_equal "Bar!"
		end
		
		it "defines a method with normal parameters" do
			instance = Class.new do 
				def_fluently 'foo' do |name|
					"Hello, #{name}!"
				end
			end.new

			instance.foo("rauchy").must_equal "Hello, rauchy!"
		end

		it "defines a multi-word method" do
			instance = Class.new do
				def_fluently 'beware of mercury poisoning' do
					"Bar!"
				end
			end.new

			instance.beware_of_mercury_poisoning.must_equal "Bar!"
		end

		it "defines a method with a single inline parameter" do
			instance = Class.new do
				def_fluently 'multiply $n by two' do |n|
					n * 2
				end
			end.new

			instance.multiply(21).by_two.must_equal 42
		end
	end
end	
