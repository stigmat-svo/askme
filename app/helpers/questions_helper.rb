module QuestionsHelper

  def author_questions(question, stranger)
    if question.author.present?
      link_to(question.author&.username, user_path(question.author))
    else
      stranger
    end
  end
end
