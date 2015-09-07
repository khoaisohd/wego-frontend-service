#= require angular/angular
#= require angular-rails-templates
#= require angular-route/angular-route
#= require angular-resource/angular-resource
#= require angular-flash/dist/angular-flash
#= require_self
#= require_tree .

Wego = angular.module('wego',[
  'templates',
  'ngRoute',
  'controllers',
  'ngResource',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])