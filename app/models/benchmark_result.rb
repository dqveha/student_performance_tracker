class BenchmarkResult < ApplicationRecord
  belongs_to :student

  validates :date, presence: :true

  # validates_uniqueness_of :date, :message => "Student already has an established benchmark for this date. Please update it instead."

  [:ge, :vocab_ge, :reading_comp_ge, :lnf, :snf, :orf_grade_lvl, :orf_cwpm, :orf_accuracy].each do |field|
    validates field, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  end

  def season
    month = self.date.month
    if (8..11).include?(month)
      season = "Fall"
    elsif [12, 1, 2, 3].include?(month)
      season = "Winter"
    elsif month.between?(4, 6)
      season = "Spring"
    elsif month === 7
      season = "Summer"
    else
      season = "Month Value: #{month}"
    end
    return "#{season} #{self.date.year}"
  end
end
