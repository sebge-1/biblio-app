class Booknote  < ActiveRecord::Base
  belongs_to :book

  validate :not_all_empty?

  def not_all_empty?
    def empty?
    attributes.all? do |k, v|
      ['summary', 'quotes', 'research'].include?(k) || v.nil? || v == [] || v == [""]
    end
  end
  end
end
