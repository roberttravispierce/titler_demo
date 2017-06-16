class AdminController; end

class Titler
  def initialize(controller: , i18n:)
    @controller = controller
    @i18n = i18n
  end

  def self.title
    new.title
  end

  def title
    if admin_namespace?
      ['Admin', 'foo'].join delimiter
    else
      'foo'
    end
    # delimiter = I18n.exists?('page_title.delimiter') ? t('page_title.delimiter') : ' - '
    # html = app_name
    # html << t('page_title.admin_namespace') + delimiter if controller.class.parents.include?(Admin)
    # html << title_from_app
    # html << (title_from_app.blank? ? app_name : app_name.prepend(delimiter))
  end

  private

  def delimiter
    @i18n.exists?('page_title.delimiter') ? @i18n.t('page_title.delimiter') : '-'
  end

  def admin_namespace?
    @controller.class.ancestors.include?(AdminController)
  end

  def app_name
    I18n.exists?('general.app_name') ? t('general.app_name') : Rails.application.class.to_s.split("::").first
  end

  def env_prefix
    Rails.env.production? ? '' : "(#{Rails.env[0,1].upcase}) "
  end

  def title_from_app
    title = case
      when content_for?(:page_title)
        content_for(:page_title)
      when @page_title
        @page_title
      when I18n.exists?('page_title.default')
        t('page_title.default')
      else
        ''
    end
  end
end
