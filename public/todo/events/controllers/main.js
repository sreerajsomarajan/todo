var app = angular.module('todoApp', []);

app.controller('mainCtrl', ['$scope', '$http', '$templateCache', '$compile', function($scope, $http, $templateCache, $compile) {
  $scope.init = function() {
    var tmp = $templateCache.get('top-header');
    var linkFn = $compile(tmp);
    var header = linkFn($scope);
    $('#header').append($(header));

    tmp = $templateCache.get('main-panel');
    linkFn = $compile(tmp);
    var body = linkFn($scope);
    $('#main-body').append($(body));

    tmp = $templateCache.get('bottom-footer');
    linkFn = $compile(tmp);
    var footer = linkFn($scope);
    $('#footer').append($(footer));
  };
}]);
