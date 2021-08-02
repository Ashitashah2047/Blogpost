class UserMailer < ApplicationMailer

  def signup_email(post_id)
    @post = Post.find(post_id)
    mail(to: @post.user.email, subject: 'Welcome Email')
  end
end
