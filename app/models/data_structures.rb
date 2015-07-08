class DataStructures
  attr_reader :provider

  def initialize
    @provider = "# what provider?"
  end

  def self.get
    new.provider
  end
end
