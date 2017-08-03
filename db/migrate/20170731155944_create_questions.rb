class CreateQuestions < ActiveRecord::Migration[5.1]
	def change
		create_table :questions do |t|
			t.string :title
			t.integer :upvote_count, :default => 0
			t.integer :downvote_count, :default => 0
			t.integer :user_id
			t.timestamps
		end
	end
end
