# Reto de Automatización: Performance Testing con Gatling

Proyecto enfocado en la medición de estabilidad y carga de servicios API utilizando la integración de Karate con Gatling.

## 🚀 Alcance
- **Simulación:** Carga gradual de usuarios concurrentes sobre los endpoints de la API.
- **Tecnología:** Uso de scripts en Scala para definir la inyección de carga, reutilizando los archivos .feature de Karate.

## 🛠️ Requisitos
- Java 17
- Maven
- Soporte para Scala/Gatling

## 🏃 Ejecución
Para ejecutar la simulación de carga:
```bash
mvn gatling:test