# Takeoff 

Takeoff is my personal take on a Rails barebone application. I'm using it myself, feel free to fork if you like it.

## Features

* HAML &amp; SASS
* jQuery
* Eric Meyer's CSS Reset
* Task to clear Sass-generated stylesheets: `rake sass:clear`
* Route to root, and a `MainController`
* Route for Google Webmasters validation files, put your codes to `config/environment.rb`
* Boilerplate application layout, including Google Analytics code (`google_analytics 'your_code_here'`)
* js-model helpers: `js_id_for @some_model` returns `some_models_123`; `$('#some_models_123').modelId()` returns 123
* require resource helpers - `require_javascript` and `require_css` - which include resources only once

## Guidelines

* No Rails tutorial-like comment stuff
* Proper gitignore, vim-oriented
* Haml / Sass
* Authlogic for authorization
* jQuery for javascript
* All of my usual helpers

## TODO

* proper helper to make a title tag
* something to deal with metatags (you need to set them from templates)
* add authlogic
* collect custom helpers
* proper 404/500 pages - in haml
* trim down tests
* use http://github.com/toretore/javascript_routes/tree/master to get routes in javascript
