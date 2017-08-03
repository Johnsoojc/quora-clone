post '/questions/:id/answers' do

  @question = Question.find(params[:id])
  @answer = current_user.answers.new(description: params[:description], question_id: @question.id)
  @answers = @question.answers
  if @answer.save
    erb :"/questions/show"
  else
    erb :"/questions/index"
  end
end

get '/answers/:id/edit' do
 @answer = Answer.find(params[:id])
   erb :"answers/edit"
end

patch '/answers/:id' do
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
    @answers = @question.answers.all.order("updated_at DESC")
  if @answer.update(params[:answer])
    erb :"questions/show"
  else
    erb :"answer/edit"
  end
end

delete '/questions/:question_id/answers/:id' do
  # find which question i m in
  @question = Question.find(params[:question_id])
  # find which answer i want to delete
  @answer = Answer.find(params[:id])
  @answer.destroy
  # goes back to the particular question
  redirect "/questions/#{@question.id}"
end

post '/questions/:question_id/answers/:id/upvote' do
  answer_vote = AnswerVote.find_by(user_id: current_user.id, answer_id: params[:id])
  if !answer_vote.nil?
    if answer_vote.vote_count == 1
      answer_vote.destroy

    else
      answer_vote.update(vote_count: 1)
    end
  else
    @answer_votes = AnswerVote.new(user_id: current_user.id, answer_id: params[:id], vote_count: 1)
    @answer_votes.save

  end
  @answers = Answer.all
  @question = Question.find(params[:question_id])
  redirect "/questions/#{@question.id}"
end


post '/questions/:question_id/answers/:id/downvote' do
   answer_vote = AnswerVote.find_by(user_id: current_user.id, answer_id: params[:id])
   if !answer_vote.nil? #this line telling whether you have an object ornot
     if answer_vote.vote_count == -1
       answer_vote.destroy

     else
       answer_vote.update(vote_count: -1)
     end
     #this 'if' use it when object existed
   else
     @answer_votes = AnswerVote.new(user_id: current_user.id, answer_id: params[:id], vote_count: -1)
     @answer_votes.save
     #this 'if ' use it when object is not exisited, and create a new one
   end
   @answers = Answer.all
   @question = Question.find(params[:question_id])
   redirect "/questions/#{@question.id}"
   #however it 2 if statement will still finally go through here
 end
