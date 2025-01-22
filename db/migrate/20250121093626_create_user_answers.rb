class CreateUserAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :user_answers do |t|
      t.references :user_exam, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true
      t.integer :times

      t.timestamps
    end
  end
end
