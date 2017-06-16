class Titler
  require 'i18n'

  def set
    delimiter = I18n.exists?('page_title.delimiter') ? t('page_title.delimiter') : ' - '
    html = app_name
    html << t('page_title.admin_namespace') + delimiter if controller.class.parents.include?(Admin)
    html << title_from_app
    html << (title_from_app.blank? ? app_name : app_name.prepend(delimiter))
  end

  private

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
