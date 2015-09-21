module UsersHelper

  def display_user_posts(user)
    if user.posts.count > 0
      render user.posts
    else
      "#{user.name} does not have any posts."
    end
  end

  def display_user_comments(user)
    if user.comments.count > 0
      render user.comments
    else
      "#{user.name} has not commented on anything."
    end
  end
end
