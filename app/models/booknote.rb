class Booknote  < ActiveRecord::Base
  belongs_to :book

  validate :not_all_empty?

  def not_all_empty?
    if summary.blank? && quotes.blank? && research.blank?
      errors[:base] << "You must fill in at least one field"
    end
  end

end
