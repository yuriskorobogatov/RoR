# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, *opts)
      @validations ||= []
      @validations << { name: name, type: type, opts: opts }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        send (validation[:type]).to_s, validation[:name], validation[:opts]
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def presence(name, *_opts)
      raise 'Имя/номер равно nil, или пустой строке' if send(name.to_s).to_s.empty?
    end

    def type(name, type)
      raise 'Не совпадение класса объекта с заданным классом' unless send(name.to_s).is_a?(type[0])
    end

    def format(name, format)
      raise 'Имя/номер не соответствует заданному формату' unless format[0].match?(send(name.to_s))
    end
  end
end
