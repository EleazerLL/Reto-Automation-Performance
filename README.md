# 📈 Reto de Automatización: Performance Testing (Gatling + Karate)

Este proyecto implementa pruebas de carga y estrés sobre los servicios de GoRest, utilizando la capacidad de **Karate DSL** para ser ejecutado como motor de carga a través de **Gatling**.

## 🛠️ Stack Tecnológico
* **Java:** 17
* **Framework:** Karate + Gatling
* **Lenguaje:** Scala 2.13
* **Build Tool:** Maven

## 🎯 Plan de Pruebas y Objetivos (SLAs)
Basado en los requisitos de capacidad y estabilidad, se han definido los siguientes **Acuerdos de Nivel de Servicio (SLAs)** que el sistema debe cumplir:

* **Throughput:** El sistema debe procesar un mínimo de **10 solicitudes por segundo (TPS)**.
* **Tiempo de Respuesta (p95):** El 95% de las peticiones debe completarse en menos de **800ms**.
* **Tasa de Error:** Se permite un máximo de **1% de fallos** (éxito > 99%).
* **Latencia Media:** El tiempo medio de respuesta esperado es de **500ms**.

## 🚀 Escenarios Diferenciados
Se han documentado y configurado los siguientes escenarios en la clase `UsersSimulation.scala`:

1. **Load Test (Carga):** 20 usuarios virtuales inyectados gradualmente en 30 segundos. Su objetivo es validar el comportamiento estable.
2. **Stress Test (Estrés):** Simulación de picos de tráfico para identificar el punto de degradación del servicio.

## 🏃 Ejecución y Reportes
Ejecutar el comando:
`mvn clean gatling:test`

Los reportes interactivos se generan en:
`target/gatling/[nombre-simulacion]/index.html`

Estos reportes incluyen métricas clave como la distribución de latencia, peticiones