class UsersController < ApplicationController
  def index
    @users = [
        User.new(
            id: 1,
            name: 'Виталий',
            username: 'stigmat',
            avatar_url: "http://zornet.ru/_fr/81/3053642.jpg"
        ),
        User.new(
            id: 2,
            name: 'Игорь',
            username: 'csg'
        )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
        name: "Виталий Шелудько",
        username: "stigmat",
        avatar_url: "http://zornet.ru/_fr/81/3053642.jpg"
    )

    @questions = [
        Question.new(
            text: 'Как дела?',
            created_at: Date.parse('17.05.2020'),
            answer: 'Отлично!'
        ),
        Question.new(
            text: 'Как семья, как работа?',
            created_at: Date.parse('17.05.2020'),
            answer: 'Всё хорошо!'
        ),
        Question.new(
            text: 'Машину починил?',
            created_at: Date.parse('17.05.2020'),
            answer: nil
        )
    ]

    @new_question = Question.new
    @questions_count = @questions.count
  end
end
