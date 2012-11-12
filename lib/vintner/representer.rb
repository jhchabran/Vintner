require 'active_support/concern'
require 'active_support/core_ext'
require 'vintner/exporter'
require 'vintner/importer'
require 'vintner/representation'

module Vintner
  class Representer
    include Exporter
    include Importer

    attr_accessor :model

    def initialize model
      @model = model
    end

    def representation
      self.class.representation
    end

    def self.representation &block
      if block_given?
        @representation = yield Representation.new(self)
      else
        @representation
      end
    end
  end
end
