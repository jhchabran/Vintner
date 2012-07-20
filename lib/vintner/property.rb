module Vintner
  class Property
    attr_reader :name

    def initialize name, &block
      @name = name

      instance_eval &block if block_given?
    end

    def import model, value
      if setter_defined?
        @setter.call mode, value
      else
        model.send "#{name}=", value
      end
    end

    def export model
      if getter_defined?
        @getter.call model
      else
        model.send name
      end
    end

    def getter_defined?
      !!@getter
    end

    def setter_defined?
      !!@setter
    end

    private
    def get &block
      @getter = block
    end

    def set &block
      @setter = block
    end
  end
end
