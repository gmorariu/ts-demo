angular.module('app.controllers.addtrip', []).controller('AddTripController', [
    '$scope',
    '$rootScope',
    '$http',
    '$q',
    function($scope, $rootScope, $http, $q) {
    	$scope.trip={};
    	$scope.trip['guests_number'] = 1;
    	$scope.trip['has_restriction'] = 0;
    	$scope.trip['guests_number_drinking'] = 0;
    	$scope.trip['pefered_time'] = "";
    	$scope.trip['spice'] = "mild";
    	$scope.createTrip = function() {
    		if (!($scope.trip['pefered_time'])) {
    			delete $scope.trip["pefered_time"];
    		}
    		$scope.creating = true;
    		var promise = $scope.createTripRESTCall($scope.trip);
    		promise.then(function(response) {
    			$scope.creating = false;
    		}, function(status) {
		           //TODO: Add err handling
    			$scope.creating = false;
    		});
    	};
        $scope.createTripRESTCall = function(trip) {
            var loader = $q.defer();
            $http.post($rootScope.apiUrl+"/client/trips", 
            	trip, {
                cache: false
            }).success(function(data) {
            	loader.resolve(data);
            }).error(function(data, status) {
            	loader.reject(status);
            });
            return loader.promise;
        };
    }]);
