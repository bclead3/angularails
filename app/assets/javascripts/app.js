'use strict';

angular.module('angularails.controllers', []);
angular.module('angularails.directives', []);
angular.module('angularails.filters', []);
angular.module('angularails.services', ['ngResource']);

var angularails = angular.module('angularails',
  [
  'angularails.controllers',
  'angularails.directives',
  'angularails.filters',
  'angularails.services'
  ]);
