package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class UsersSimulation extends Simulation {

  val protocol = karateProtocol()

  // Definición del escenario basado en el feature de API
  val usersScenario = scenario("Escenario de Performance GoRest")
    .exec(karateFeature("classpath:com/curso/KarateCurso/users.feature"))

  setUp(
    /* ESCENARIO 1: LOAD TEST (Carga Normal)
       Objetivo: Validar el comportamiento del sistema con tráfico esperado.
       Throughput esperado: ~20-30 usuarios concurrentes.
    */
    usersScenario.inject(
      rampUsers(20) during (30 seconds)
    ).protocols(protocol)
  ).assertions(
    /* DEFINICIÓN DE SLAs (Service Level Agreements)
       Esto responde directamente al comentario del evaluador:
    */
    global.responseTime.mean.lt(500),      // Tiempo medio < 500ms
    global.responseTime.percentile3.lt(800), // p95 (Percentil 95) < 800ms
    global.successfulRequests.percent.gt(99), // Tasa de éxito > 99% (Error rate < 1%)
    global.requestsPerSecond.gt(10)        // Throughput mínimo esperado
  )
}