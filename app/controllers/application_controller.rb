class ApplicationController < ActionController::Base
  require 'titler'
  protect_from_forgery with: :exception
  before_action :set_title

  private

  def set_title
    $title = Titler.new.set
  end
end
