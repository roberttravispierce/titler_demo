module ApplicationHelper
  require 'titler'

  def set_page_title
    Titler.new(
      controller: self,
      i18n: I18n,
      title_as_set: content_for(:page_title) || @page_title
     ).title
  end
end
