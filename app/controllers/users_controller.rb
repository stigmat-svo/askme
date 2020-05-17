class UsersController < ApplicationController
  def index
    @users = [
        User.new(
            id: 1,
            name: 'Виталий',
            username: 'stigmat',
            avatar_url: "https://lh3.googleusercontent.com/proxy/8RjW104aWqaFhYWwqhkf-KeAjZ8XRJDdrReNZLJkK_4PmzHWtMy_AvaNFCTb-pOOLysIH9ax6_h6BWo"
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
        avatar_url: "https://lh3.googleusercontent.com/proxy/8RjW104aWqaFhYWwqhkf-KeAjZ8XRJDdrReNZLJkK_4PmzHWtMy_AvaNFCTb-pOOLysIH9ax6_h6BWo"
    )

    @questions = [
        Question.new(
            text: 'Как дела?',
            created_at: Date.parse('17.05.2020')
        ),
        Question.new(
            text: 'Как семья, как работа?',
            created_at: Date.parse('17.05.2020')
        )
    ]

    @new_question = Question.new
  end
end
