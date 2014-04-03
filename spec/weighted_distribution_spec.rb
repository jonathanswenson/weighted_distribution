require 'rspec'
require 'weighted_distribution'

def create_wd
  items = {:one => 1, :two => 2, :three => 3, :four => 4, :five => 5}
  WeightedDistribution.new(items)
end

describe "WeightedDistribution" do
  it "Initialized Correctly" do
    wd = create_wd
    wd.instance_variable_get(:@len).should eq(5)
    wd.instance_variable_get(:@keys).should eq([:one, :two, :three, :four, :five])
    wd.instance_variable_get(:@orig_values).should eq([1, 2, 3, 4, 5])
    wd.instance_variable_get(:@values).should eq([1.0/15, 2.0/15, 3.0/15, 4.0/15, 5.0/15])
    wd.instance_variable_get(:@csum).should eq([1.0/15, (1.0/15) + (2.0/15), (1.0/15) + (2.0/15) + (3.0/15), (1.0/15) + (2.0/15) + (3.0/15) + (4.0/15), 15.0/15])
  end

  it "Sample produces the right type of outputs" do
    wd = create_wd
    wd.sample.should be_an_instance_of(Symbol)
    wd.sample(2).should be_an_instance_of(Array)
  end

  it "Sample productes the right number of outputs" do
    wd = create_wd
    wd.sample(0).length.should eq(0)
    wd.sample(-1).length.should eq(0)
    wd.sample(2).length.should eq(2)
    wd.sample(5).length.should eq(5)
    wd.sample(30).length.should eq(30)
  end

  it "Produces the correct output for boundary values (randomly generated)" do
    wd = create_wd
    test_values = [0.0, 0.99, 1.01, 2.99, 3.01, 5.99, 6.01, 9.99, 10.01, 14.99, 15.0]
    test_values = test_values.map{|x| x/15}
    Kernel.stub(:rand).and_return( *test_values )

    wd.sample.should eq(:one)
    wd.sample.should eq(:one)
    wd.sample.should eq(:two)
    wd.sample(2).should eq([:two, :three])
    wd.sample(3).should eq([:three, :four, :four,])
    wd.sample(3).should eq([:five, :five, :five])
  end
end


