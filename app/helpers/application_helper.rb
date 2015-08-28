module ApplicationHelper
  #define a method named form_group_tag which takes two arguments.
  #The first argument is an array of errors, and the second is a block.
  def form_group_tag(errors, &block)
  # if the errors array is not empty, the content_tag helper method is called.
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end
end
