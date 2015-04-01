if (typeof angular === 'undefined') {
    location.reload(true);
}
var app = angular.module('app', 	 ['ngRoute', 
                                	  'app.controllers.addtrip',
                                	  'app.controllers.managetrips',
                                      ]);

app.config(['$routeProvider', '$locationProvider',
            function($routeProvider, $locationProvider) {
                $locationProvider.html5Mode(true);
                $routeProvider.
                when(prefix + 'trip', {
                    templateUrl: prefix + 'templates/addTrip.html',
                    controller: 'AddTripController'
                }).
                when(prefix + 'managetrips', {
                    templateUrl: prefix + 'templates/manageTrips.html',
                    controller: 'ManageTripsController'
                }).
                otherwise({
                    redirectTo: prefix + 'trip'
                });
            }
        ]);

app.run([
	'$rootScope', 
	'$location', 
	function($rootScope, $route, $routeParams, $http, $q, $location, $window, $sce) {
        $rootScope.prefix = prefix;
        $rootScope.apiUrl = location.protocol + '//' + location.host + '/api/';
    }]);
