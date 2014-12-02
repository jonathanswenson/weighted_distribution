# Weighted Distribution

Weighted Distribution is used to sample from a distribution of objects with different
weights. Sampling from this distribution will randomly select an object with a
probability proportional to its weight. I followed the specification used by Ryan Lecompte's
[Weighted Randomizer](https://github.com/ryanlecompte/weighted_randomizer). I have improved on the
runtime efficiency of the sampling algorithm to run in O(log(n)) time rather then O(n). This will
be useful for higher performance distribution sampling from distributions with many objects.

## Installation

Add this line to your application's Gemfile:

    gem 'weighted_distribution'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install weighted_distribution

## Usage

To sample from a distribution:

```ruby

  suits = {'heart' => 12, 'spade' => 11, 'diamond' => 10, 'club' => 13}
  suit_distribution = WeightedDistribution.new(suits)

  # Fetch a single random object.
  suit_distribution.sample # => single object

  # Fetch the next 10 weighted random objects.
  suit_distribution.sample(10) # => array of objects
```

## License

Licensed with the MIT license (see LICENSE)

## Acknowledgements

The design of the gem and its specification was based largely on
Ryan Lecompte's [Weighted Randomizer](https://github.com/ryanlecompte/weighted_randomizer)
which was based on recipe 5.11 from the
[Ruby Cookbook](http://shop.oreilly.com/product/9780596523695.do)
