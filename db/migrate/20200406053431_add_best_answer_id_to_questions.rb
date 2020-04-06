class AddBestAnswerIdToQuestions < ActiveRecord::Migration[5.2]
  def change
    # デフォルトでは完了していない0を入れます。完了する際に1を入れます
    add_column :questions, :best_answer_id, :integer, default: nil
  end
end