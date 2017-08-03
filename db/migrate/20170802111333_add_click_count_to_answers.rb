class AddClickCountToAnswers < ActiveRecord::Migration[5.1]
	def change
		create_table :answer_votes do |t|
			t.integer :user_id
			t.integer :answer_id
			t.integer :vote_count, :default => 0
		end
	end
end
