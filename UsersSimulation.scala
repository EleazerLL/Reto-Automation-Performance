package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class UsersSimulation extends Simulation {

  // Definimos que vamos a usar la configuración de Karate
  val protocol = karateProtocol()

  // Aquí le decimos a Gatling qué prueba de API queremos estresar.
  // "classpath:KarateApi/src/test/java/users.feature" es la ruta que Maven entenderá.
  val usersLoad = scenario("Carga de Usuarios GoRest")
    .exec(karateFeature("classpath:KarateApi/src/test/java/users.feature"))

  // Configuración de la carga:
  setUp(
    // rampUsers(10) during (5 seconds) significa:
    // "Mete 10 usuarios virtuales poco a poco en un lapso de 5 segundos"
    usersLoad.inject(rampUsers(10) during (5 seconds)).protocols(protocol)
  )

}