class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :question_tags
  has_many :tags , through: :question_tags
  accepts_nested_attributes_for :question_tags, :allow_destroy => true
end