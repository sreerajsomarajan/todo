var app = angular.module('todoApp', ['ngRoute']);

app.config(function($routeProvider, $locationProvider) {
  $routeProvider
   .when('/users', {
      templateUrl: '/users/templates/index.html',
      resolve: {
        // I will cause a 1 second delay
        // delay: function($q, $timeout) {
        //   var delay = $q.defer();
        //   $timeout(delay.resolve, 1000);
        //   return delay.promise;
        // }
      }
    })
    .when('/users/edit/:id', {
      templateUrl: '/users/templates/edit.html',
    })
    .otherwise({
        redirectTo: '/'
    });

  // configure html5 to get links working on jsfiddle
  $locationProvider.html5Mode(true);
  $locationProvider.hashPrefix('!');
});
