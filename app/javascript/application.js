// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
//= require moment
//= require bootstrap-datepicker
import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"
flatpickr(".datepicker", {})
