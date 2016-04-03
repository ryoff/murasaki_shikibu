module MurasakiShikibu
  class Type < ActiveRecord::Type::String
    def initialize(*args, &block)
      fail LocalJumpError unless block_given?

      @converter = block

      super(*args)
    end

    def type
      :string
    end

    def type_cast_from_user(value)
      if value.nil?
        nil
      elsif value.respond_to?(:to_s)
        super(@converter.call(value.to_s))
      else
        super
      end
    end

    def type_cast_for_database(value)
      if value.nil?
        nil
      elsif value.respond_to?(:to_s)
        super(@converter.call(value.to_s))
      else
        super
      end
    end
  end
end
