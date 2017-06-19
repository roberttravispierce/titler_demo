# Titler Demo Application

This application is for the development of the Titler ruby gem, which will make titling your app pages simple but flexible.

Created following the basic [Heroku Instructions - Getting Started with Rails 5.x on Heroku]("https://devcenter.heroku.com/articles/getting-started-with-rails5"), using Rails 5.0.3 and Ruby 2.3.1

## Live Demo Apps:

- Staging: https://titler-demo-staging.herokuapp.com/
- Production: https://titler-demo-production.herokuapp.com/

## How Titler Works
With Titler, a page title consists of the following elements:

### Environment Prefix (env_prefix)
- A one letter prefix in parentheses showing the rails environment. Example "(D) Title here..."  for Development environment, or "(S) Title here..." for Staging environment. This aids in quickly scanning and locating browser tabs during development and testing. It is not added for production environments.

### Admin Namespace (admin_namespace)
- The title will be prefixed with "Admin" (admin_namespace i18n value) if the page controller is within an Admin namespace.

### Element Delimiter (delimiter)
- Elements within the built title string will be delimited by this string. Developer can set it in the i18n file. The default is " - "

### Title Body (title_body)

This is the core of the individual page title, which is set by the developer throughout their app. In order of preference:

- content_for :page_title if found
- @page_title instance variable if found
- The Controller and Action (method) name is used if none of the above are found

### App Name (app_name)

- The built title string is appended with the name of the application. This is set in the "app_name" i18n value. Default fallback is the Rails.application.class name.

### App Tagline (app_tagline)

This allows for an additional marketing tagline to be in every title. Set in the "app_tagline" i18n value and ignored if not found.

### _Examples_

- (D) Privacy Policy | Mom App
- About - Best App for Busy Moms - Mom App
- (S) Admin - User Profile - Mom App
- Recipe of the Week / Best App for Busy Mom's / Mom App
- Mom App | Posts Index
