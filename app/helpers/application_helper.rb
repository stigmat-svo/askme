module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def inclination(num)
    modul = num % 10
    modul_2 = num % 100

    if (11..14).cover?(modul_2)
      return 'вопросов'
    elsif modul == 1
      return 'вопрос'
    elsif (2..4).cover?(modul)
      return 'вопроса'
    else
      return 'вопросов'
    end
  end
end
