ActiveAdmin.register Question do
 
  # 閲覧、編集、削除をコントロールすることができる.
  # ユーザー情報など消えたら問題になるModelは制限を加えたりすることがある
  actions :all
  config.per_page = 20
 
 
  #showページ
  show do
    attributes_table do
      row :title
      row :body
      row :best_answer_id
      row :tags do
        question.tags.collect { |n| n.name }.join(', ')
      end
      
    end
  end
 
  #formのコード
  form do |f|
    f.inputs '質問' do
      f.input :title
      f.input :body
      f.input :best_answer_id
      f.has_many :question_tags, allow_destroy: true, new_record: true do |t|
        t.input :tag_id,
                label: 'タグ',
                as: :select,
                collection: Tag.all
      end
      f.actions
    end
  end
  permit_params :title,
                :body,
                :best_answer_id,
                question_tags_attributes: [:id, :tag_id, :_destroy]
end