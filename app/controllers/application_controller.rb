class ApplicationController < ActionController::Base
  require 'titler'
  protect_from_forgery with: :exception

  private

  def page_title
    require 'pry'; binding.pry;
    Titler.new(controller: self, i18n: I18n).title
  end
  helper_method :page_title
end
