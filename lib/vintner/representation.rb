require 'active_support/concern'
require 'active_support/core_ext'
require 'vintner/dsl_methods'
require 'vintner/builder'
require 'vintner/importer'

module Vintner
  class Representation
    MissingBlockError = Class.new(Exception)

    def initialize representer, &block
      raise MissingBlockError unless block_given?

      @representer = representer
      @tree = {}
    end

    def method_missing name, *args, &block
      if block_given?
        @tree[name] = block
      else
        @tree[name] = args.first
      end
    end
  end
end
