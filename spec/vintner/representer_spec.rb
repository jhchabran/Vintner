require 'spec_helper'

module Vintner
  describe Representer do
    before :each do
      class Dummy < Vintner::Representer
        def main_title
          model.title
        end

        def main_title= title
          model.title = title
        end

        def big_title
          model.title.upcase
        end

        representation do |root|
          root.version = 4

          root.meta do |meta|
            meta.main_title
            meta.big_title
          end
        end
      end
    end

    describe "Exporting :" do
      before :each do
        @hash = Dummy.new(BasicModel.new("foo")).to_hash
      end

      it "should export a main title under meta key" do
        @hash[:meta][:main_title].should ==('foo')
      end

      it "should export a big title under meta key" do
        @hash[:meta][:big_title].should ==('FOO')
      end

      it "should export a version" do
        @hash[:version].should ==(4)
      end
    end

  end
end
