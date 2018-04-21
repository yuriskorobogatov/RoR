# frozen_string_literal: true
=begin
Содержит метод класса validate. Этот метод принимает в качестве параметров имя проверяемого атрибута, а также тип
валидации и при необходимости дополнительные параметры.Возможные типы валидаций:
   - presence - требует, чтобы значение атрибута было не nil и не пустой строкой. Пример использования:
validate :name, :presence
  - format (при этом отдельным параметром задается регулярное выражение для формата). Треубет соответствия значения
атрибута заданному регулярному выражению. Пример:
validate :number, :format, /A-Z{0,3}/
 - type (третий параметр - класс атрибута). Требует соответствия значения атрибута заданному классу. Пример:
validate :station, :type, RailwayStation
 Содержит инстанс-метод validate!, который запускает все проверки (валидации), указанные в классе через метод класса
validate. В случае ошибки валидации выбрасывает исключение с сообщением о том, какая именно валидация не прошла
Содержит инстанс-метод valid? который возвращает true, если все проверки валидации прошли успешно и false, если есть
ошибки валидации.
К любому атрибуту можно применить несколько разных валидаторов, например
validate :name, :presence
validate :name, :format, /A-Z/
validate :name, :type, String
 Все указанные валидаторы должны применяться к атрибуту
Допустимо, что модуль не будет работать с наследниками.
Подключить эти модули в свои классы и продемонстрировать их использование. Валидации заменить на методы из модуля
Validation.
=end

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
    rescue
      false
    end

    private

    def presence(name, *_opts)
      raise RuntimeError, "Имя/номер равно nil, или пустой строке" if send(name.to_s).to_s.empty?
    end

    def type(name, type)
      raise RuntimeError, "Не совпадение класса объекта с заданным классом" unless send(name.to_s).is_a?(type[0])
    end

    def format(name, format)
      raise RuntimeError, "Имя/номер не соответствует заданному формату" unless send(name.to_s) =~ format[0]
    end
  end
end
