module ApplicationHelper

  def page_title(page_title)
    content_for(:page_title) { page_title }
  end

  def set_page_title
    Titler::Title.new(controller: self, i18n: I18n, title_as_set: content_for(:page_title) || @page_title).title
  end
end
