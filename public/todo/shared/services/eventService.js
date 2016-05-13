var app = angular.module('todoApp');

var headers = {
  'Accept': 'application/todoApp.v1'
};

app.service('eventService', ["$http", "$q", "$window", function($http, $q, $window) {
  return ({
    allEvents: allEvents
  });

  function allEvents(cb) {
    var config = { headers: headers };
    $http.get('/apis/events.json', config).
          success(function(data, status, headers, config) {
            if(cb) { cb(data); }
          }).
          error(function(data, status, headers, config) {
            window.location = '/test'
          });
  };
}]);
