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

    define_method(ActiveRecord::VERSION::MAJOR >= 5 ? 'cast' : 'type_cast_from_user') do |value|
      if value.nil?
        nil
      elsif value.respond_to?(:to_s)
        super(@converter.call(value.to_s))
      else
        super
      end
    end

    define_method(ActiveRecord::VERSION::MAJOR >= 5 ? 'serialize' : 'type_cast_for_database') do |value|
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
