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
      raise TypeError, 'Variable type mismatch' if value.class != class_attr

      instance_variable_set(var_name, value)
    end
  end
end

module Validation
  def self.included(base)
    base.include(InstanceMethods)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_accessor :validates

    def validate(attr_name, *args)
      @validates ||= []
      @validates << [attr_name, args]
    end
  end

  module InstanceMethods
    def validate!
      self.class.validates.each do |validation|
        send("validate_#{validation[1][0]}", validation[0], validation[1])
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    protected

    def validate_presence(attr_name, _args)
      value = instance_variable_get("@#{attr_name}")
      raise ArgumentError, 'Empty string or nil' if value.nil? || value == ''
    end

    def validate_format(attr_name, args)
      raise ArgumentError, 'Regex not passed' if args[1].nil?
      raise ArgumentError, 'Regex mismatch' unless instance_variable_get("@#{attr_name}") =~ args[1]
    end

    def validate_type(attr_name, args)
      value = instance_variable_get("@#{attr_name}")
      raise ArgumentError, 'Class name not passed' if args[1].nil?
      raise TypeError, 'Variable type mismatch' unless value.instance_of?(args[1]) || value.instance_of?(args[-1])
    end
  end
end
