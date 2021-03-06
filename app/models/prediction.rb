class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :match
  has_one :result, class_name: 'PredictionResult'

  validate :match_available?
  validates_presence_of :home_score, :away_score, if: -> { home_score.present? || away_score.present? }
  validates_presence_of :home_penalty, :away_penalty, if: -> { home_penalty.present? || away_penalty.present? }

  private
  def match_available?
    errors.add(:match, :invalid) unless match.predictable?
  end
end
