var app = angular.module('todoApp', []);

app.controller('usersCtrl', ['$scope', '$http', '$templateCache', '$compile', 'userService', function($scope, $http, $templateCache, $compile, userService) {
  $scope.init = function() {
    var templateIds = [
      { tmpId: 'top-header', htmlId: 'header' },
      { tmpId: 'userIndex', htmlId: 'main-body' },
      { tmpId: 'bottom-footer', htmlId: 'footer' },
    ]
    $scope.compileAndAppend(templateIds);
    userService.allUsers($scope.populateUsers);
  };



  $scope.populateUsers = function(data) {
    $scope.records = data;
  };

  $scope.compileAndAppend = function(templateIds) {
    _.each(templateIds, function(e) {
      var tmp = $templateCache.get(e.tmpId);
      var linkFn = $compile(tmp);
      var header = linkFn($scope);
      $('#' + e.htmlId).append($(header));
    });
  };

}]);
