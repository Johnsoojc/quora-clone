helpers do

  def total_q_votes(question)
    total_upvotes =(QuestionVote.where(question_id: question.id, vote_count: 1)).count
    total_downvotes =(QuestionVote.where(question_id: question.id, vote_count: -1)).count
    total_upvotes - total_downvotes
  end

  def total_a_votes(answer)
    total_upvotes =(AnswerVote.where(answer_id: answer.id, vote_count: 1)).count
    total_downvotes =(AnswerVote.where(answer_id: answer.id, vote_count: -1)).count
    total_upvotes - total_downvotes
  end
end
