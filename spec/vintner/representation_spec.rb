require 'spec_helper'

module Vintner
  describe Representation do
    before :each do
      @representer    = Representer.new(BasicModel.new)
      @representation = Representation.new(@representer)

      @representation.meta do |meta|
        meta.version = 4
        meta.title
      end
    end

    it "should have a sub representation named 'meta'" do
      @representation[:meta].should be_a(Representation)
    end

    it "should have a static 'version' nested in 'meta'" do
      @representation[:meta][:version].should ==(4)
    end

    it "should have a dynamic title nested in meta" do
      @representation[:meta][:title].should ==(:dynamic)
    end
  end
end
