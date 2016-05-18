var app = angular.module('todoApp');

var headers = {
  'Accept': 'application/todoApp.v1'
};

app.service('userService', ["$http", "$q", "$window", function($http, $q, $window) {
  return ({
    allUsers: allUsers
  });

  function allUsers(cb) {
    var config = { headers: headers };
    $http.get('/apis/users.json', config).
          success(function(data, status, headers, config) {
            if(cb) { cb(data); }
          }).
          error(function(data, status, headers, config) {
            window.location = '/'
          });
  };
}]);
