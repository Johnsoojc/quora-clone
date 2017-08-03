class Question < ActiveRecord::Base
  # This is Sinatra! Remember to create a migration!
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :question_votes
end
