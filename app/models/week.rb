class Week < ActiveRecord::Base
  belongs_to :program

  def number_and_cost
    self.number + ' | $' + self.cost.to_s
  end

end
