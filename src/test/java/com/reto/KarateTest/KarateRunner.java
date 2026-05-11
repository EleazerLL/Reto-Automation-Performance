package com.reto.KarateTest;

import com.intuit.karate.junit5.Karate;


public class KarateRunner {
	@Karate.Test
	Karate testALL() {
	    return Karate.run("testConsultaUsuario.feature").relativeTo(getClass());
	}
	
}
