 @smoke
 Feature: Chequear el obtener datos de usuario por API

	Background:
		* url 'https://gorest.co.in'
		* header Accept = 'application/json'
		* url 'https://gorest.co.in'
	    * def getRandomEmail =
	      """
	      function() {
	        var text = "";
	        var possible = "abcdefghijklmnopqrstuvwxyz0123456789";
	        for (var i = 0; i < 8; i++)
	          text += possible.charAt(Math.floor(Math.random() * possible.length));
	        return text + "@testmail.com";
	      }
	      """
	    * def dynamicEmail = getRandomEmail()
		
	Scenario: obtener lista de usuarios
		Given path '/public/v2/users'
		When method GET
		Then status 200
		And print response
	
	Scenario: Validar un usuario existente dinámicamente y obtener parametros
	    Given path '/public/v2/users'
	    When method GET
	    Then status 200
	    * def idExistente = response[0].id
	    * print 'Probando con el ID encontrado:', idExistente
		Given path '/public/v2/users'
		And param id = idExistente 
		When method GET
		Then status 200
		And match response[0].id == idExistente
    	And match response[0].name == '#string'
		And print response
		And match $[0] contains {id:"#number",name:"#string",email:"#regex [A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}",gender: "#notnull"}

	Scenario: Crear usuario sin token debe fallar
	    Given path '/public/v2/users'
	    And request { name: '11111111', gender: 'male', email: 'test@mail.com', status: 'active' }
	    When method POST
	    Then status 401
	    And match response.message == 'Authentication failed'
	    
	 Scenario: Guardar ID en un objeto JSON dinámico y consultarlo
	    Given path '/public/v2/users'
	    When method GET
	    Then status 200
	    * def idVivo = response[0].id
	    * def misDatos = { "id": #(idVivo), "tipo": "usuario_activo" }
	    * print 'Objeto JSON creado:', misDatos
	    Given path '/public/v2/users'
	    And param id = misDatos.id
	    When method GET
	    Then status 200
	    And match response[0].id == misDatos.id
	    * def esquemaEsperado = read('usuario.json')
		And match response[0] contains esquemaEsperado
		
	Scenario: Ciclo de vida completo del usuario (CRUD)
	    # 1. CREAR
	    Given path '/public/v2/users'
	    And header Authorization = 'Bearer 9924bf5c7045e351a22adfa09f02b4e1ef3929a4a45867c71f1c43d916778e0c'
	    And request { name: 'Job', gender: 'male', email: '#(dynamicEmail)', status: 'active' }
	    When method post
	    Then status 201
	    * def userId = response.id
    
    # 2. ACTUALIZAR (Usando el ID anterior)
	    Given path '/public/v2/users/' + userId
	    And header Authorization = 'Bearer 9924bf5c7045e351a22adfa09f02b4e1ef3929a4a45867c71f1c43d916778e0c'
	    And request { name: 'Job Actualizado' }
	    When method put
	    Then status 200
	    And match response.name == 'Job Actualizado'
    
    # 3. ELIMINAR (Limpieza de datos)
	    Given path '/public/v2/users/' + userId
	    And header Authorization = 'Bearer 9924bf5c7045e351a22adfa09f02b4e1ef3929a4a45867c71f1c43d916778e0c'
	    When method delete
	    Then status 204
	    
	 Scenario: Validar error al intentar crear un usuario sin email
	    Given path '/public/v2/users'
	    And header Authorization = 'Bearer 9924bf5c7045e351a22adfa09f02b4e1ef3929a4a45867c71f1c43d916778e0c'
	    And request { name: 'Job Test', gender: 'male', status: 'active' }
	    When method post
	    Then status 422
	    And match response[0].field == 'email'
	    And match response[0].message == "can't be blank"
	   
	 Scenario Outline: Crear múltiples usuarios usando Examples
	    Given path '/public/v2/users'
	    And header Authorization = 'Bearer 9924bf5c7045e351a22adfa09f02b4e1ef3929a4a45867c71f1c43d916778e0c'
	    * def dynamicEmail = getRandomEmail()
	    And request { name: '<nombre>', gender: '<genero>', email: '#(dynamicEmail)', status: 'active' }
	    When method post
	    Then status 201
	    And match response.name == '<nombre>'

    Examples:
      | nombre          | genero |
      | Juan Perez      | male   |
      | Maria Garcia    | female |
      | Admin Test      | male   |
		    

	    
	    
	    
	    
	    
	    
	    
	    
	    
	    