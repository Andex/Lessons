require_relative 'modules.rb'

class Wagon
  include ManufacturerCompany
  
  attr_reader :type
  attr_accessor :is_coupled
  
  def initialize(type)
    @type = type
    @is_coupled = false
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Wrong type of wagon" unless type == :cargo || type == :passenger
  end
end
