require 'vintner/representation'

module Vintner
  module Exporter
    def to_hash
      export representation
    end

    def export representation
      store = {}

      representation.each do |key,value|
        if value.is_a? Representation

          store[key] = export(value)
        elsif value == Representation::PlaceHolder.instance
          store[key] = send(key)
        else
          store[key] = value
        end
      end

      store
    end
  end
end
