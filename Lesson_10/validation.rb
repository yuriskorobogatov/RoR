# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validation_rules

    def validate(attr_name, validation_type, *opts)
      @validation_rules ||= []
      @validation_rules << { attr_name: attr_name, rule: validation_type, opts: opts }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validation_rules.each do |rule|
        name_value = instance_variable_get("@#{rule[:attr_name]}")
        send rule[:rule], name_value, rule[:opts]
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private
    def validate_presence(name_value, opts)
      raise 'Имя/номер равно nil, или пустой строке' if name_value.to_s.empty?
    end

    def validate_type(name_value, attr_type)
      raise 'Не совпадение класса объекта с заданным классом' unless name_value.is_a?(attr_type[0])
    end

    def validate_format(name_value, format)
      raise 'Имя/номер не соответствует заданному формату' unless format[0].match?(name_value.to_s)
    end
  end
end
