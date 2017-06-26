class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def titler
    @titler ||= Titler.new controller: self, i18n: I18n
  end
  helper_method :titler
end
