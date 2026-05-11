Feature: Chequear el obtener datos de usuario por API

	Background:
		* url 'https://gorest.co.in'
		* header Accept = 'application/json'
		
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