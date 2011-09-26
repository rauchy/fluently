require 'minitest/spec'
require 'minitest/autorun'

describe "def_fluently" do
  it "defines a simple instance method" do
		instance = Class.new do 
			def_fluently 'foo' do
				"Bar!"
			end
		end.new

		instance.foo.must_equal "Bar!"
	end
end	
