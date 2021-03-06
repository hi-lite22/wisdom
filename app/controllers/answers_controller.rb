class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  # ここを追加
  @@question_id = nil
 
  def index
    @questions = Question.all
  end
 
  def show
  end
 
  def new
    # questionを取得します
    @@question_id = params[:questionId]
    @question = Question.find(@@question_id)
    @answer = Answer.new
  end
 
  def edit
  end
 
  def create
    @answer = Answer.new(answer_params)
    # question_idを代入
    @answer.question_id = @@question_id
    # user_idを代入
    @answer.user_id = current_user.id
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 
  private
    def set_answer
      @answer = Answer.find(params[:id])
    end
    def answer_params
      params.require(:answer).permit(:user_id, :question_id, :body)
    end
end