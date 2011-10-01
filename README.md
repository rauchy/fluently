#fluently

fluently is a small gem for creating fluent interfaces.

Method parameters in Ruby are always supplied at the end of the sentence. For example, if you were to write a method that transfers a certain amount of money from one account to another, you would probably do something like:

    transfer(5.0, 'buyer@example.com', 'seller@example.com')

What the hell is "**transfer 5.0 buyer@example.com seller@example.com**"? A readable alternative to this would be **transfer 5.0 from buyer@example.com to seller@example.com**. Well, with fluently, you can easily declare such an interface, using this syntax:

    class Foo
      def_fluently 'transfer $price from $buyer to $seller' do |price, buyer, seller|
        # ...
      end
    end

And then use it this way:

    foo.transfer(5.0).from('buyer@example.com').to('seller@example.com')

### deff

If you find ```def_fluently``` too verbose, you can use a synonym called ```deff```:

    class Foo
      deff 'multiply $n by two' do |n|
        n * 2
      end
    end
