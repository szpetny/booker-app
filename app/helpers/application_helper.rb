module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = I18n.t(:main_app_title)
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def titleize(str)
    str.split(" ").map(&:capitalize).join(" ")
  end
  
  def current_translations
    @translations ||= I18n.backend.send(:translations)
    @translations[I18n.locale].with_indifferent_access
  end
end
