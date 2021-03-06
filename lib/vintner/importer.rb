module Vintner
  class Importer
    include DSLMethods

    def import representer, model, hash
      @store = {}
      @representer = representer
      @model = model

      # Registering keys and properties
      @block.call(self, @model) if @block

      # Then we play the score accordingly
      @store.each do |key, object|
        if object.is_a? Importer
          object.import representer, model, hash[key.to_s]
        else
          if hash && hash.has_key?(key) && object.respond_to?(:import)
            object.import model, hash[key]
          end
        end
      end

      hash
    end
  end
end
