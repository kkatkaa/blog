class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def liked_article(user)
    @user = user
    mail(to: @user.email, subject: 'Liked article')
  end
end
