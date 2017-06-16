require 'i18n'
require 'support/i18n_simple_stub'

RSpec.describe Titler do

  describe 'Titler.set' do
    let(:base) {I18n.t('general.app_name')}
    let(:delimiter) {I18n.t('page_title.delimiter')}
    let(:admin_namespace) {I18n.t('page_title.admin_namespace')}
    let(:default_title) {I18n.t('page_title.default')}

    it '(1) return the env_prefix, admin namespace, content_for, delimiter and base if exists' do
      I18n.backend = I18n::Backend::Simple.new
      controller.stub(:controller_name).and_return('AdminController')
      @page_title = 'This is a Test Page' #content_for takes precedence
      helper.content_for(:page_title, 'Test Page')
      expected_title = "(T) #{admin_namespace}#{delimiter}Test Page#{delimiter}#{base}"
      expect(Titler.new.set).to eq(expected_title)
    end
  end
end
