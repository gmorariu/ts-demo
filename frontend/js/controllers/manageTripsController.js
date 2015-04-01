angular.module('app.controllers.managetrips', []).controller('ManageTripsController', [
    '$scope',
    '$rootScope',
    '$http',
    '$q',
    function($scope, $rootScope, $http, $q) {
    	$scope.loading = true;
    	$scope.loadTrips = function() {
    		$scope.loading = true;
    		var promise = $scope.getTripsRESTCall();
    		promise.then(function(response) {
    			$scope.trips = response.rows;
    			$scope.loading = false;
    		}, function(status) {
		           //TODO: Add err handling
    			$scope.loading = false;
    		});
    	};
        $scope.getTripsRESTCall = function() {
            var loader = $q.defer();
            $http.get($rootScope.apiUrl+"/admin/trips?include_docs=true", 
            {
                cache: false
            }).success(function(data) {
            	loader.resolve(data);
            }).error(function(data, status) {
            	loader.reject(status);
            });
            return loader.promise;
        };
        
        $scope.loadTrips();
    }]);
