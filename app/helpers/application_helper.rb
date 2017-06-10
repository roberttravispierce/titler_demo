module ApplicationHelper

  def set_page_title(namespace = '')
    delimiter = I18n.exists?('page_title.delimiter') ? t('page_title.delimiter') : ' - '
    html = env_prefix
    html << t('page_title.admin_namespace') + delimiter if namespace == 'admin'
    available_title = available_page_title
    html << available_title
    html << (available_title.blank? ? app_name : app_name.prepend(delimiter))
  end

  def env_prefix
    Rails.env.production? ? '' : "(#{Rails.env[0,1].upcase}) "
  end

  def available_page_title
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

  def app_name
    I18n.exists?('general.app_name') ? t('general.app_name') : Rails.application.class.to_s.split("::").first
  end

  def env_badge(outer = :li)
    unless Rails.env.production?
      content_tag(outer) do
       content_tag(:span, "#{Rails.env.titleize}", class: "label label--env-#{Rails.env}")
      end
    end
  end
end
