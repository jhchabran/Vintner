module Vintner
  module Importer
    StaticValueError   = Class.new(Exception)
    MissingSetterError = Class.new(Exception)

    def from_hash hash
      import representation, hash

      self
    end

    def import representation, hash
      hash.each do |key, value|
        if value.is_a? Hash
          import(representation[key], value)
        elsif representation[key] == Representation::PlaceHolder.instance
          if respond_to? "#{key}="
            send "#{key}=", value
          else
            raise MissingSetterError
          end
        else
          unless value == representation[key]
            raise StaticValueError
          end
        end
      end
    end
  end
end
