# Titler Demo Application

This application is for the development of the Titler ruby gem, which will make titling your app pages simple but flexible.

Created following the basic [Heroku Instructions - Getting Started with Rails 5.x on Heroku]("https://devcenter.heroku.com/articles/getting-started-with-rails5"), using Rails 5.0.3 and Ruby 2.3.1

## Live Demo Apps:

- Staging: https://titler-demo-staging.herokuapp.com/
- Production: https://titler-demo-production.herokuapp.com/

## How Titler Works
With Titler, a page title consists of the following elements:

### Environment Prefix (env_prefix)
- A one letter prefix in parentheses showing the rails environment. Example "(D) Title here..."  for Development environment, or "(S) Title here..." for Staging environment. This aids in quickly scanning and locating browser tabs during development and testing. It is not added for the Production environment.

### Admin Namespace (admin_namespace)
- The title will be prefixed with "Admin" (admin_namespace i18n value) if the page controller is within an Admin namespace.

### Element Delimiter (delimiter)
- Elements within the built title string will be delimited by this string. Developer can set it in the i18n file. The default is " - "

### Title As Set (title_as_set)

This is the core of the individual page title, which is set by the developer throughout their app. In order of preference:

- content_for :page_title if found
- @page_title if found
- 'page_title.default' i18n translation if found
- blank if none of the above are found

### App Name (app_name)

- The built title string is appended with the name of the application. This is set in the "app_name" i18n value. Default fallback is the Rails.application.class name.

### _Examples_

- (D) Privacy Policy | MyApp
- About - MyApp
- (S) Admin - Posts Listing - Myapp
