#CREATE-create
post '/users/:id/questions' do

  @question = current_user.questions.new(params[:question])
  if @question.save
    redirect '/questions'
  else
    erb :"/static/profile"
  end
end

#READ_index
get '/questions' do
  @questions = Question.all
  erb :"/questions/index"
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = Answer.where(question_id: (@question.id))
  erb :"/questions/show"
end

# UPDATE
get '/questions/:id/edit' do
  @question = Question.find(params[:id])
  erb :"/questions/edit"
end

patch '/questions/:id' do
  @question = Question.find(params[:id])
    if @question.update(params[:question])
      redirect '/questions'
    else
      erb :"/questions/edit"
    end
end


# DELETE
delete '/questions/:id' do
  @question = Question.find(params[:id])
  @question.destroy
  redirect '/questions'
end

post '/questions/:id/upvote' do
  @question =Question.find(params[:id])
  question_vote = QuestionVote.find_by(user_id: current_user.id, question_id: params[:id])
  if !question_vote.nil?
    if question_vote.vote_count == 1
      question_vote.destroy

    else
      question_vote.update(vote_count: 1)
    end
  else
    @question_votes = QuestionVote.new(user_id: current_user.id, question_id: params[:id], vote_count: 1)
    @question_votes.save

  end
  @questions = Question.all
  result = []
  result << total_q_votes(@question)
  result << @question.id
  return result.to_json
  # erb :'questions/index'
end


post '/questions/:id/downvote' do
  @question =Question.find(params[:id])
   question_vote = QuestionVote.find_by(user_id: current_user.id, question_id: params[:id])
   if !question_vote.nil? #this line telling whether you have an object ornot
     if question_vote.vote_count == -1
       question_vote.destroy

     else
       question_vote.update(vote_count: -1)
     end
     #this 'if' use it when object existed
   else
     @question_votes = QuestionVote.new(user_id: current_user.id, question_id: params[:id], vote_count: -1)
     @question_votes.save
     #this 'if ' use it when object is not exisited, and create a new one
   end
   @questions = Question.all
   result =[]
   result << total_q_votes(@question)
   result << @question.id
   return result.to_json
   #however it 2 if statement will still finally go through here
 end



#
# if person clicks vote button
#   is there an existing vote?
#     yes => update
#       is the person making the same vote?
#         yes => delete vote
#         no => change the vote to new value
#     no => create
#       use values to create vote
#   end
