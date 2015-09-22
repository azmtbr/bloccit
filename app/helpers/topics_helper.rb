module TopicsHelper

  def user_can_create_topics?
    (current_user && current_user.admin?)
  end

  def user_can_delete_topics?
    (current_user && current_user.moderator?)
  end

  def user_can_edit_topics?
    (current_user && current_user.admin?)
  end

  def render_posts(posts)
    output = ""
    posts.each do |post|
      output += '<div class="media"><div class="media-body"><h4 class="media-heading">'
      output += link_to post.title, topic_post_path(post.topic, post)
      output += "</h4><small>submitted #{time_ago_in_words(post.created_at)} ago by #{post.user.name}<br>"
      output += "#{post.comments.count } comments" if post.respond_to?('comments')
      output += "</small></div></div>"
    end
    output.html_safe
  end

  def render_topic_name(topic, link = false)
    output = link ? link_to(topic.name, topic) : topic.name
    output += "private" unless topic.public?
    output.html_safe
  end
end
