class DibelsResult < ApplicationRecord
  belongs_to :student

  validates :date, presence: :true

  [:grade, :dibels, :accuracy].each do |field|
    validates field, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  end
end
