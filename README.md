# Takeoff 

Takeoff is my personal take on a Rails barebone application. I''m using it myself, feel free to fork if you like it.

## Features

* HAML & SASS
* jQuery on board
* Eric Meyer''s CSS Reset
* Task to clear Sass-generated stylesheets
* Route to root 
* Route for Google Webmasters validation files
* Boilerplate application layout, including Google Analytics code

## Guidelines

* No Rails tutorial-like comment stuff
* Proper gitignore, vim-oriented
* Haml / Sass
* Authlogic for authorization
* jQuery for javascript
* All of my usual helpers

## TODO

* proper helper to make a title tag
* proper require-like helper for javascript & css
* something to deal with metatags (you need to set them from templates)
* google analytics helper (come on, everyone uses them)
* jquery helpers: js_id @some_model returns some_model_123; $(#some_model_123).getModelId returns 123
* add authlogic
* collect custom helpers
* proper 404/500 pages - in haml
* trim down tests
