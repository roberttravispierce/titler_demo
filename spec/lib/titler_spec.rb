require 'rails_helper'

class AdminController; end
class MockController < AdminController; end

describe Titler do
  describe '#title' do
    let(:base) {I18n.t('general.app_name')}
    let(:delimiter) {I18n.t('page_title.delimiter')}
    let(:admin_namespace) {I18n.t('page_title.admin_namespace')}
    let(:default_title) {I18n.t('page_title.default')}

    # it '(1) return the env_prefix, admin namespace, content_for, delimiter and base if exists' do
    #   I18n.backend = I18n::Backend::Simple.new
    #   controller.stub(:controller_name).and_return('AdminController')
    #   @page_title = 'This is a Test Page' #content_for takes precedence
    #   helper.content_for(:page_title, 'Test Page')
    #   expected_title = "(T) #{admin_namespace}#{delimiter}Test Page#{delimiter}#{base}"
    #   expect(Titler.new.set).to eq(expected_title)
    # end

    it '(1) returns a title' do
      title = Titler.new(controller: nil, i18n: nil).title
      expect(title).to eq 'foo'
    end

    it '(2) returns a title prefixed by the admin namespace' do
      mock_controller = MockController.new
      i18n = double(:i18n)
      expect(i18n).to receive(:exists?).with('page_title.delimiter').and_return false
      title = Titler.new(controller: mock_controller, i18n: i18n).title
      expect(title).to eq 'Admin - foo'
    end

    context 'with a delimiter translation' do
      it '(3) uses the delimiter from i18n' do
        mock_controller = MockController.new
        i18n = double(:i18n)
        expect(i18n).to receive(:exists?).with('page_title.delimiter').and_return true
        expect(i18n).to receive(:t).with('page_title.delimiter').and_return ' : '
        title = Titler.new(controller: mock_controller, i18n: i18n).title
        expect(title).to eq 'Admin : foo'
      end
    end

    context 'without a delimiter translation' do
    end
  end
end
