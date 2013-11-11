'use strict';

angular.module('angularails.controllers').
  controller('ItemCtrl', ['$scope', 'Item', function($scope, Item) {

  var getItems = function(){
    $scope.items = Item.query();
  };

  $scope.items = [];
  $scope.newItem = '';

  $scope.add = function(itemName){
    var item = new Item({name:itemName});
    if(itemName && itemName.length > 0) {
      item.$save(function(){
        $scope.status = 'Successfully added '+itemName+'.';
        getItems(); //refresh
      }, function(){
        $scope.status = 'There was an error adding '+itemName+'.';
      });
    }
  };

  $scope.remove = function(index){
    var item = $scope.items[index];
    item.$delete(function(){
      $scope.status = 'Successfully removed item '+index+'.';
      getItems(); //refresh
    },function(){
      $scope.status = 'There was an error removing item #'+index+'.';
    });
  };

  //init
  if ($scope.items.length === 0){
    getItems();
  }
}]);
