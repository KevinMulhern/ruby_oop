class Cell

  attr_accessor :value

  def value
    @value ||= ""
  end

  def taken?
    value != ""
  end
end