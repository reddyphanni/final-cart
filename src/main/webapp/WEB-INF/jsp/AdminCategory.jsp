<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Category</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script
	src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.17/angular.min.js"></script>
<script>
	var app = angular.module('myApp', []);
	function MyController($scope, $http) {
		$scope.sortType = 'name'; // set the default sort type
		$scope.sortReverse = false; // set the default sort order
		$scope.search = '';
		$scope.getDataFromServer = function() {
			$http({
				method : 'GET',
				url : 'categorygson'
			}).success(function(data, status, headers, config) {
				$scope.categories = data;// alert(data); 
			}).error(function(data, status, headers, config) {
			});
		};
	};
</script>
</head>
<body style="margin-top: 100px">
	
	<div>
		<div class="w3-row-1">
			<div class="w3-container w3-third"></div>
			<div class="w3-container w3-third">
			<c:url var="addAction" value="addcategory"></c:url>
				<form:form action="${addAction}" commandName="category">
					<table class=""w3-table-all"">
					<br><tr class="w3-grey"><th colspan="2" >Add Category</th></tr>
						<tr>
							
							<c:choose>
								<c:when test="${!empty category.id}">
									
								</c:when>
								<c:otherwise>
									<td><form:input path="id" pattern=".{2,10}"
											required="true" title="id should contains 2 to 10 characters" /></td>
								</c:otherwise>
							</c:choose>
						<tr>
							<td><form:label path="name">
									<spring:message text="Name" />
								</form:label></td>
							<td><form:input path="name" required="true" /></td>
						</tr>
						<tr>
							<td><form:label path="description">
									<spring:message text="Description" />
								</form:label></td>
							<td><form:input path="description" required="true" /></td>
						</tr>
						<tr>
							<td colspan="2">
							<c:if test="${!empty category.name}">
									<input type="submit" class="w3-btn w3-grey"
										value="<spring:message text="Edit category"/>" />
								</c:if> 
							<c:if test="${empty category.name}">
									<input type="submit" class="w3-btn w3-grey"
										value="<spring:message text="Add category"/>" />
								</c:if></td>
						</tr>
					</table>
				</form:form>
			</div>
		</div>
			<div class="w3-table-all"></div>
			<br>
			<div class="w3-row">
				<div class="w3-container w3-quarter"></div>
				<div class="w3-container w3-half">
				<c:choose>
		  <c:when test="${!EditCategory}">
			<div class="container" data-ng-app="myApp"
				data-ng-controller="MyController" data-ng-init="getDataFromServer()">
				<form>
					<input
						class="w3-input w3-animate-input w3-border w3-round w3-small"
						data-ng-model="search" type="text" placeholder=" Search here"
						style="width: 20%">

				</form>
				<br>
				<table class="table table-bordered table ">
				
					<thead>
					
					
					
						<tr class="w3-grey">
						<br><th>Category ID</th>
							<th>Category Name</th>
							<th>Category Description</th>
							<th>Edit</th>
							<th>Delete</th>
						</tr>
					</thead>
					<tbody>
						<tr
							data-ng-repeat="category in categories | orderBy:sortType:sortReverse | filter:search">
							<td >{{category.id}}</td>
							<td>{{category.name}}</td>
							<td>{{category.description}}</td>
							<td>
										<form action="editcategory/${category.id}" method="post">
											<input type="submit" class="w3-btn w3-grey" class="w3-btn w3-grey" value="Edit">
										</form>
									</td>
									<td><form action="removecategory/${category.id}">
											<input type="submit" class="w3-btn w3-grey" value="Delete">
										</form></td>						
										</tr>
					</tbody>
				</table>
			</div>
		</c:when>
 	<c:otherwise>

		</c:otherwise>
	</c:choose>

				 	
				</div>
				<div class="w3-container w3-quarter"></div>
			</div>
		</div>
</body>
</html>