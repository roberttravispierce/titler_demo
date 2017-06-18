class ApplicationController < ActionController::Base
  require 'titler'
  protect_from_forgery with: :exception

  private

  def page_title
    Titler.new(
        controller: self,
        i18n: I18n,
        content_for_title: helpers.content_for(:page_title)
      ).title
      # TODO: the helpers.content_for is not actually working - always nil
  end
  helper_method :page_title
end
