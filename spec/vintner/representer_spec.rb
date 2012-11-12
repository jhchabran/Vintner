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

    describe "Importing :" do
      before :each do
        @hash = {
          :meta => {
            :main_title => 'bar'
          }
        }
        @model = BasicModel.new("foo")
        @dummy = Dummy.new(@model)
      end

      it "should import a main title" do
        @dummy.from_hash @hash
        @model.title.should ==("bar")
      end

      it "should not raise if the same value is providen for a static value" do
        expect {@dummy.from_hash :version => 4}.to_not raise_error
      end

      it "should raise if a different value is providen for a static value" do
        expect {@dummy.from_hash :version => 5}.to raise_error(Importer::StaticValueError)
      end

      it "should raise if a value is providen for a missing setter" do
        expect {@dummy.from_hash :meta => {:big_title => "BAR"}}.to raise_error(Importer::MissingSetterError)
      end
    end
  end
end
