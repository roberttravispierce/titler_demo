class PagesController < ApplicationController

  def default
  end

  def variable
    @page_title = t('page_title.variable')
  end

  def view_content
  end

end
