class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  @@user_type = nil
 
  def index
    @q = Question.ransack(params[:q])
    @@user_type = current_user.role
    if @@user_type == '質問者'
      @questions = current_user.questions
    else
      if params[:q]
        @questions = @q.result(distinct: true)
      else
        @questions = Question.all
      end
    end
  end
 
  def show
  end
 
  def new
    # 新規作成画面でタグを表示するため
    @tags = Tag.all
    @question = Question.new
  end
 
  def edit
    # 修正画面でタグを表示するため
    @tags = Tag.all
  end
 
  def create
    @question = current_user.questions.build(question_params)
    respond_to do |format|
      if @question.save
        format.html {redirect_to @question, notice: 'Question was successfully created.'}
        format.json {render :show, status: :created, location: @question}
      else
        format.html {render :new}
        format.json {render json: @question.errors, status: :unprocessable_entity}
      end
    end
  end
 
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html {redirect_to @question, notice: 'Question was successfully updated.'}
        format.json {render :show, status: :ok, location: @question}
      else
        format.html {render :edit}
        format.json {render json: @question.errors, status: :unprocessable_entity}
      end
    end
  end
 
  def destroy
    @question.destroy
    respond_to do |format|
      format.html {redirect_to questions_url, notice: 'Question was successfully destroyed.'}
      format.json {head :no_content}
    end
  end
 
  private
 
  def set_question
    @question = Question.find(params[:id])
  end
 
  def question_params
    # ここを修正
    params.require(:question).permit(:user_id, :title, :body, :best_answer_id, {:tag_ids => []})
  end
end