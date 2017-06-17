class AdminController; end

class Titler
  # Configuration setup preparing for transition to a gem. From: https://robots.thoughtbot.com/mygem-configure-block
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :delimiter
    attr_accessor :admin_name
    attr_accessor :app_name_position

    def initialize
      @delimiter = ' - '
      @admin_name = 'Admin'
      @app_name_position = 'append' # append, prepend, none
    end
  end

  class << self
    attr_accessor :configuration
  end

  def initialize(controller: , i18n:, view_content_for:)
    @configuration = Configuration.new
    @controller = controller
    @i18n = i18n
    @view_content_for = view_content_for
  end

  def self.title
    new.title
  end

  def title
    th = title_hash = Hash.new
    th[:env_prefix] = env_prefix
    th[:admin_namespace] = admin_namespace
    th[:title_body] = title_body
    th[:app_name] = app_name
    build_title(th)
  end

  private

  def admin_namespace
    admin_namespace? ? admin_default_name + delimiter : ''
  end

  def admin_namespace?
    @controller.class.ancestors.include?(AdminController)
  end

  def admin_default_name
    @i18n.exists?('titler.admin_name') ? @i18n.t('titler.admin_name') : @configuration.admin_name
  end

  def delimiter
    @i18n.exists?('titler.delimiter') ? @i18n.t('titler.delimiter') : @configuration.delimiter
  end

  def app_name
    name = @i18n.exists?('titler.app_name') ? @i18n.t('titler.app_name') : Rails.application.class.to_s.split("::").first
  end

  def env_prefix
    Rails.env.production? ? '' : "(#{Rails.env[0,1].upcase}) "
  end

  def title_body
    title = case
    # when @controller.helpers.content_for?(:page_title)
    #   @controller.helpers.content_for(:page_title).to_s
    when @view_content_for
      @view_content_for
    when @page_title
      @page_title.to_s
    else
      ''
      # Alternative fallback: #{object_name}" if object_name.present?
      # Another possible fallback to implement from: https://stackoverflow.com/questions/3059704/rails-3-ideal-way-to-set-title-of-pages
      # Attempt to build the best possible page title.
      # If there is an action specific key, use that (e.g. users.index).
      # If there is a name for the object, use that (in show and edit views).
      # Worst case, just use the app name
      # def page_title
      #   app_name = t :app_name
      #   action = t("titles.#{controller_name}.#{action_name}", default: '')
      #   action += " #{object_name}" if object_name.present?
      #   action += " - " if action.present?
      #   "#{action} #{app_name}"
      # end
      #
      # # attempt to get a usable name from the assigned resource
      # # will only work on pages with singular resources (show, edit etc)
      # def object_name
      #   assigns[controller_name.singularize].name rescue nil
      # end
    end
  end

  def build_title(th)
    case @configuration.app_name_position
    when 'append'
      app_name = title_body.blank? ? th[:app_name] : delimiter + th[:app_name]
      th[:env_prefix] + th[:admin_namespace] + th[:title_body] + app_name
    when 'prepend'
      app_name = title_body.blank? ? th[:app_name] : delimiter + th[:app_name]
      th[:env_prefix] + app_name + th[:admin_namespace] + th[:title_body]
    else
      th[:env_prefix] + th[:admin_namespace] + th[:title_body]
    end
  end

  def helpers
    ActionController::Base.helpers
  end
end
