var app = angular.module('todoApp', []);

app.controller('eventsCtrl', ['$scope', '$http', '$templateCache', '$compile', 'eventService', function($scope, $http, $templateCache, $compile, eventService) {
  $scope.init = function() {
    var templateIds = [
      { tmpId: 'top-header', htmlId: 'header' },
      { tmpId: 'main-panel', htmlId: 'main-body' },
      { tmpId: 'bottom-footer', htmlId: 'footer' },
    ]
    $scope.compileAndAppend(templateIds);
    eventService.allEvents($scope.populateEvents);
  };

  $scope.populateEvents = function(data) {
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
