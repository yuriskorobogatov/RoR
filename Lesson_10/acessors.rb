# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*methods)
    methods.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        arr_values = instance_variable_get(var_name_history) || []
        instance_variable_set(var_name_history, arr_values << value)
      end
      define_method("#{name}_history".to_sym) { instance_variable_get(var_name_history) }
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Не соответствие типа атрибута заданному классу' if value.class != class_name
      instance_variable_set(var_name, value)
    end
  end
end
