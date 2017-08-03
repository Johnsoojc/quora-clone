class CreateAnswers < ActiveRecord::Migration[5.1]
	def change
		create_table :answers do |t|
			t.string :description
			t.integer :upvote_count, :default => 0
			t.integer :downvote_count, :default => 0
			t.integer :user_id
			t.integer :question_id
			t.timestamps
		end
	end
end
