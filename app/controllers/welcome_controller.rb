class WelcomeController < ApplicationController

  def index
  end

  def variable
    @page_title = "Title set by controller variable"
  end

  def view_content
  end

end
