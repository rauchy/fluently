require 'minitest/spec'
require 'minitest/autorun'

describe "fluently_def" do
  it "defines a simple instance method" do
		instance = Class.new do 
			fluently_def 'foo' do
				"Bar!"
			end
		end.new

		instance.foo.must_equal "Bar!"
	end
end	
