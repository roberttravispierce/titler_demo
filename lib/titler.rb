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
    attr_accessor :use_env_prefix

    def initialize
      @delimiter = ' - '
      @admin_name = 'Admin'
      @app_name_position = 'append' # append, prepend, none
      @use_env_prefix = true
    end
  end

  class << self
    attr_accessor :configuration
  end

  def initialize(controller: , i18n:, content_for_title:)
    @configuration = Configuration.new
    @controller = controller
    @i18n = i18n
    @content_for_title = content_for_title
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
    # TODO: Boolean config values didn't seem to work. Research needed.
    # if @use_env_prefix
    if true
      Rails.env.production? ? '' : "(#{Rails.env[0,1].upcase}) "
    else
      ''
    end
  end

  def title_body
    title = case
      # TODO: Not satisfied with having to pass in content_for
      # Tried this with ActionController::Base.helpers but couldn't
      # get it to work
      #   when @controller.helpers.content_for?(:page_title)
      #     @controller.helpers.content_for(:page_title).to_s

      # TODO: Actually the passing in of content_for to @content_for_title is not working either
      # The application layout sees the content_for(:title) but the page_title
      # helper method in application controller does not.
      when @content_for_title.present?
        @content_for_title
      when @page_title
        @page_title.to_s
      else
        @controller.controller_name.titleize rescue ''
    end
  end

  # def helpers
  #   ActionController::Base.helpers
  # end

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
end
