
module AddCompany
  attr_accessor :company

  def add_company
    puts "Введите название производителя:"
    @company = gets.chomp
  end

  def get_company
    self.company
  end
end

=begin
Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются автоматически
при вызове include в классе:
Методы класса:
  - instances, который возвращает кол-во экземпляров данного класса
Инастанс-методы:
  - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из конструктора.
При этом данный метод не должен быть публичным.
Подключить этот модуль в классы поезда, маршрута и станции.
=end

  module InstanceCounter

    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end

    module ClassMethods
      attr_writer :instances

      def instances
        @instances ||= 0
      end
    end

    module InstanceMethods

      protected
      def register_instance
        self.class.instances += 1
      end
    end

  end

