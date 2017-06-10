require 'rails_helper'
require 'i18n'
require 'support/i18n_simple_stub'

RSpec.describe TitlerHelper, type: :helper do

  describe '#set_page_title' do
    let(:base) {t('general.app_name')}
    let(:delimiter) {t('page_title.delimiter')}
    let(:admin_namespace) {t('page_title.admin_namespace')}
    let(:default_title) {t('page_title.default')}

    it '(1) return the env_prefix, admin namespace, content_for, delimiter and base if exists' do
      I18n.backend = I18n::Backend::Simple.new
      @page_title = 'This is a Test Page' #content_for takes precedence
      helper.content_for(:page_title, 'Test Page')
      expected_title = "(T) #{admin_namespace}#{delimiter}Test Page#{delimiter}#{base}"
      expect(helper.set_page_title('admin')).to eq(expected_title)
    end

    it '(2) returns the env_prefix, no namespace, content_for, delimiter, and base if exists' do
      I18n.backend = I18n::Backend::Simple.new
      helper.content_for(:page_title, 'Test Page')
      expected_title = "(T) Test Page#{delimiter}#{base}"
      expect(helper.set_page_title()).to eq(expected_title)
    end

    it '(3) returns the staging env_prefix, no namespace, @page_title, delimiter, and base if set' do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('staging'))
      I18n.backend = I18n::Backend::Simple.new
      @page_title = 'This is a Test Page'
      expected_title = "(S) #{@page_title}#{delimiter}#{base}"
      expect(helper.set_page_title()).to eq(expected_title)
    end

    it '(4) returns the env_prefix, no namespace, default title, delimiter, and base if @page_title or content_for(:title) not set' do
      I18n.backend = I18n::Backend::Simple.new
      @page_title = nil
      expected_title = "(T) #{default_title}#{delimiter}#{base}"
      expect(helper.set_page_title()).to eq(expected_title)
    end

    it '(5) returns no env_prefix if in production' do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
      I18n.backend = I18n::Backend::Simple.new
      @page_title = 'This is a Test Page'
      expected_title = "#{@page_title}#{delimiter}#{base}"
      expect(helper.set_page_title()).to eq(expected_title)
    end

    it '(6) returns only app_name if no page_title info found' do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
      @page_title = nil
      expected_title = base
      I18n.backend = I18n::Backend::SimpleStub.new # Sets I18n.exists? to false
      expect(helper.set_page_title()).to eq(expected_title)
      I18n.backend = I18n::Backend::Simple.new
    end
  end

  describe '#env_prefix' do
    it 'should (1) return a one letter environment prefix unless in production' do
      expect(helper.env_prefix).to match '(T) '
    end

    it 'should (2) return an empty string if production env' do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('production'))
      expect(helper.env_prefix).to match ''
    end

    it 'should (3) return a development prefix in development' do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('development'))
      expect(helper.env_prefix).to match '(D) '
    end

    it 'should (4) return a staging prefix in staging' do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new('staging'))
      expect(helper.env_prefix).to match '(S) '
    end
  end

  describe '#env_badge' do
    it '(1) returns an env label string inside a :span element with a default :li wrapper unless in production' do
      expect(helper.env_badge).to match "<li><span class=\"label label--env-test\">Test</span></li>"
    end

    it '(2) returns nil if in production' do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))
      expect(helper.env_badge).to match nil
    end

    it '(3) returns an env label string inside a :div element with a passed in :div wrapper unless in production'  do
      expect(helper.env_badge(:div)).to match "<div><span class=\"label label--env-test\">Test</span></div>"
    end

    it '(4) returns an env label string inside a :span element with a passed in :span wrapper unless in production'  do
      expect(helper.env_badge(:span)).to match "<span><span class=\"label label--env-test\">Test</span></span>"
    end

    it '(5) returns correct label and class if in staging' do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("staging"))
      expect(helper.env_badge).to match "<li><span class=\"label label--env-staging\">Staging</span></li>"
    end

    it '(6) returns correct label and class if in development' do
      allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("development"))
      expect(helper.env_badge).to match "<li><span class=\"label label--env-development\">Development</span></li>"
    end
  end

  describe '#available_page_title' do
    it '(1) returns the the translation title if no other titles are set' do
      I18n.backend = I18n::Backend::Simple.new
      allow(I18n).to receive(:t).with('page_title.default').and_return("Test Title from i18n")
      @page_title = nil
      expect(helper.available_page_title).to eq(t('page_title.default'))
    end

    it '(2) returns the the @page_title if it exists and no content_for exists' do
      I18n.backend = I18n::Backend::Simple.new
      allow(I18n).to receive(:t).with('page_title.default').and_return("Test Title from i18n")
      translation_title = t('page_title.default')
      @page_title = "Test Title from @page_title"
      expect(helper.available_page_title).to eq(@page_title)
    end

    it '(3) returns the the content_for title if it exists' do
      I18n.backend = I18n::Backend::Simple.new
      allow(I18n).to receive(:t).with('page_title.default').and_return("Test Title from i18n")
      translation_title = t('page_title.default')
      @page_title = "Test Title from @page_title"
      helper.content_for(:page_title, 'Test Title from content_for')
      expect(helper.available_page_title).to eq('Test Title from content_for')
    end

    it '(4) returns a blank string if no titles are found' do
      # I18n.backend = I18n::Backend::SimpleStub.new # Sets I18n.exists? to false
      #TODO: Implement shared context per SO Answer to my question: https://stackoverflow.com/questions/44223315/rspec-test-for-when-an-i18n-key-is-missing
      allow(I18n).to receive(:exists?).with('page_title.default').and_return(false)
      @page_title = nil
      expect(helper.available_page_title).to eq('')
    end
  end
end
