require 'minitest/spec'
require 'minitest/autorun'

describe "def_fluently" do
	describe "for instance methods" do
		it "defines a single word method" do
			instance = Class.new do 
				deff 'foo' do
					"Bar!"
				end
			end.new

			instance.foo.must_equal "Bar!"
		end
		
		it "defines a method with normal parameters" do
			instance = Class.new do 
				deff 'say_hello_to' do |name|
					"Hello, #{name}!"
				end
			end.new

			instance.say_hello_to("rauchy").must_equal "Hello, rauchy!"
		end

		it "defines a multi-word method" do
			instance = Class.new do
				deff 'beware of mercury poisoning' do
					"Bar!"
				end
			end.new

			instance.beware_of_mercury_poisoning.must_equal "Bar!"
		end

		it "defines a method with a single inline parameter" do
			instance = Class.new do
				deff 'multiply $n by two' do |n|
					n * 2
				end
			end.new

			instance.multiply(21).by_two.must_equal 42
		end

		it "defines a method with two consecutive inline parameters" do 
			instance = Class.new do
				deff 'concat $first_name $last_name and capitalize' do |first_name, last_name|
					"#{first_name.capitalize} #{last_name.capitalize}"
				end
			end.new

			instance.concat('omer', 'rauchwerger').and_capitalize.must_equal 'Omer Rauchwerger'
		end

#		it "defines a method with two inconsecutive inline parameters" do 
#			instance = Class.new do
#				deff 'concat $first_name and $last_name and capitalize' do |first_name, last_name|
#					"#{first_name.capitalize} #{last_name.capitalize}"
#				end
#			end.new
#
#			instance.concat('omer').and('rauchwerger').and_capitalize.must_equal 'Omer Rauchwerger'
#		end
	end
end	
