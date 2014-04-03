# Implements randomization of weighted objects.
# Constructor expects a hash of object => weight pairs where the
# weight represents the probability of the corresponding
# object being selected. follows specification of ryanlecompte's
# WeightedDistributionizer[link:https://github.com/ryanlecompte/weighted_randomizer]
# reimplements the sample function to run in O(log(n)) rather than O(n).
#
# @example Usage
#  suit_dist = WeightedDistribution.new({heart: 12, spade: 11, diamond: 10, club:13})
#  puts "you picked a #{suit_dist.sample}"
#
# @note Mostly adapted from recipe 5.11 from the Ruby Cookbook.
class WeightedDistribution

  # Creates a new instance of the WeightedDistributionizer Class
  #
  # @param [Hash] object_weights objects with their corresponding
  # weights(key object, value weight)
  # @return [WeightedDistributionizer]
  def initialize(object_weights)
    @len = object_weights.length
    @keys = object_weights.keys
    @orig_values = @keys.map{|x| object_weights[x]}
    @values = normalize(@orig_values)
    @csum = cumulative_sum(@values)
  end

  # Samples from the WeightedDistribution. Each object has a
  # probability of being selected equal to its weight over the
  # total sum of all the object weights. Can specify a number of samples
  # to obtain from distribution with the num argument.
  #
  # @param [Integer] num the number of samples to return (optional)
  # @return [Object, Array<Object>] one or more sampled objects.
  def sample(num = nil)
    return _sample unless num
    num = 0 if num < 0
    Array.new(num) { _sample }
  end

  private

  # Returns a single sample from the WeightedDistribution. Preforms altered binary
  # search in order to find the corresponding object in O(log(n)) time.
  #
  # @return [Object] sampled object from distribution
  def _sample
    random = Kernel.rand
    lhs, rhs = 0, @len - 1

    while rhs >= lhs
      ptr = (lhs + rhs) / 2
      if @csum[ptr] < random
        lhs = ptr + 1
      elsif @csum[ptr] - @values[ptr] > random
        rhs = ptr - 1
      else
        return @keys[ptr]
      end
    end

    nil
  end

  # Computes the CDF of the weighted distribution which will be sorted
  # to facilitate the binary search.
  #
  # @param [Array<Float>] object_distribution normalized weights
  # @return [Array<Float>] cumulative distribution of weights
  def cumulative_sum(object_distribution)
    sum = 0
    object_distribution.map{|x| sum += x}
  end

  # Normalizes the weights to create probability distribution that sums
  # to 1.0
  def normalize(array)
    sum = array.reduce(:+)
    array.map{|x| x.to_f/sum}
  end
end
