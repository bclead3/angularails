'use strict';

angular.module('angularails.services').
  factory('Item',['$resource', function($resource){
  return $resource('/items/:id', {id: '@id'});
}]);
