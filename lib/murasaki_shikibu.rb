require "murasaki_shikibu/version"
require "murasaki_shikibu/type"

module MurasakiShikibu
  extend ActiveSupport::Concern

  module ClassMethods
    def murasaki_shikibu(attribute_name, &block)
      attribute_name = attribute_name.to_sym

      attribute attribute_name, MurasakiShikibu::Type.new(&block)
    end
  end
end
