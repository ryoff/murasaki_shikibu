module MurasakiShikibu
  class Type < ActiveRecord::Type::String
    def initialize(*args, &block)
      @converter = block

      super(*args)
    end

    def type
      :string
    end

    def type_cast_from_user(value)
      super(@converter.call(value))
    end

    def type_cast_for_database(value)
      super(@converter.call(value))
    end
  end
end
