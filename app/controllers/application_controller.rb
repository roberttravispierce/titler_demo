class ApplicationController < ActionController::Base
  require 'titler'
  protect_from_forgery with: :exception

  private

  def page_title
    Titler.new(
      controller: self,
      i18n: I18n,
      view_content_for: helpers.content_for(:page_title)
    ).title
  end
  helper_method :page_title
end
