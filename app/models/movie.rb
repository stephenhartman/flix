class Movie < ApplicationRecord
  def flop?
    if total_gross.blank? || total_gross < 50000000
      true
    end
  end
end
