module ApplicationHelper
  def error_explanation_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'error_explanation'
    else
      content_tag :div, capture(&block), class: 'single-wiki' # don't think this gets called ever
    end
  end
end
