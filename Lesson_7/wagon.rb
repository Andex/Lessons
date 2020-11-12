require_relative 'modules.rb'

class Wagon
  include ManufacturerCompany
  
  attr_reader :type
  attr_accessor :is_coupled
  
  def initialize(type)
    @type = type
    @is_coupled = false
  end
end
