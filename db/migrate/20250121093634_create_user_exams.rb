class CreateUserExams < ActiveRecord::Migration[7.2]
  def change
    create_table :user_exams do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.float :score
      t.datetime :start_time
      t.datetime :submit_time

      t.timestamps
    end
  end
end
