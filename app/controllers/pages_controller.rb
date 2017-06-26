class PagesController < ApplicationController

  def default
  end

  def variable
    @page_title = t('page_title.variable')
    titler.page_title
  end

  def view_content
  end

end
