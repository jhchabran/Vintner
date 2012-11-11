require 'spec_helper'

module Vintner
  describe Representation do
    before :each do
      @representer = Representer.new(BasicModel.new)
    end

    it "should expects a block to be given" do
      expect { Representation.new(@representer) }.to raise_error(Representation::MissingBlockError)
    end
  end
end
