require 'singleton'

module Vintner
  class Representation < Hash
    class PlaceHolder
      include ::Singleton
    end

    def initialize representer
      @representer = representer
    end

    def method_missing method_id, *args, &block
      if block_given?
        self[method_id] = yield Representation.new(@representer)
      else
        if method_id[-1] == '='
          self[method_id[0..-2].to_sym] = args.first
        else
          self[method_id] = PlaceHolder.instance
        end
      end

      self
    end
  end
end
