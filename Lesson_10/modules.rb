module ManufacturerCompany
  attr_accessor :manufacturer_company
end

module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances += 1
    end
  end
end

module Accessors
  def attr_accessor_with_history(*attrs)
    attrs.each do |name_attr|
      var_name = "@#{name_attr}".to_sym
      var_history = "@#{name_attr}_history"
      define_method(name_attr) { instance_variable_get(var_name) }

      define_method("#{name_attr}=".to_sym) do |value|
        instance_variable_set(var_history, []) unless instance_variable_get(var_history)
        instance_variable_get(var_history) << value
        instance_variable_set(var_name, value)
      end

      define_method("#{name_attr}_history".to_sym) { instance_variable_get(var_history) }
    end
  end

  def strong_attr_accessor(name_attr, class_attr)
    var_name = "@#{name_attr}".to_sym
    define_method(name_attr) { instance_variable_get(var_name) }
    define_method("#{name_attr}=".to_sym) do |value|
      raise TypeError, 'Несоответсвие типа переменной' if value.class != class_attr

      instance_variable_set(var_name, value)
    end
  end
end
