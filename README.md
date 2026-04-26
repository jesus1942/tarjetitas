# Tarjetitas

Base de trabajo para un sistema de almuerzos escolares con tres piezas:

- `index.html`: PWA actual para generar e imprimir tarjetas fisicas.
- `curso-tarjetitas.html`: landing viva del curso con el desarrollo paso a paso.
- `docs/`: arquitectura, modelo de datos y API del sistema digital.
- `prototipos/`: dos apps principales (`alumno` y `buffet`) mas un panel interno de administracion.

## Estado actual

La PWA de impresion sigue disponible en la raiz del proyecto y se publica en GitHub Pages.

Tambien hay una landing de curso en `curso-tarjetitas.html` para seguir el proyecto como material didactico y hoja de ruta viva.

## Estructura

- `index.html`: generador de tarjetas imprimibles.
- `curso-tarjetitas.html`: landing del curso y documentacion viva.
- `tarjetas-almuerzo.html`: copia del flujo de impresion.
- `manifest.webmanifest`: manifest de la PWA actual.
- `assets/`: branding e iconos.
- `docs/arquitectura-sistema.md`: arquitectura funcional y tecnica.
- `docs/alcance-funcional.md`: alcance, casos de uso y limites del MVP.
- `docs/flujos-operativos.md`: operacion diaria y escenarios de excepcion.
- `docs/modelo-datos.sql`: esquema base relacional.
- `docs/api-openapi.yaml`: contrato inicial de API.
- `docs/roadmap.md`: etapas sugeridas de implementacion.
- `docs/decisiones-tecnicas.md`: decisiones base del sistema.
- `prototipos/alumno.html`: app del alumno.
- `prototipos/buffet.html`: app del buffet para validar entregas.
- `prototipos/admin.html`: panel interno de administracion.

## Sistema propuesto

El sistema digital se apoya en un backend central para evitar fraude o uso indefinido:

- el alumno muestra una credencial digital
- el buffet escanea o valida desde su propia app
- el backend decide si corresponde entregar el almuerzo
- cada consumo queda registrado y no puede repetirse

## Reglas clave

- la app del alumno no es fuente de verdad
- la validacion real ocurre en el backend
- la entrega diaria se limita a una por alumno
- el QR o token debe ser dinamico y firmado
- todo evento importante deja auditoria

## Proximos pasos tecnicos

1. Implementar backend y base de datos a partir de `docs/modelo-datos.sql`.
2. Construir API siguiendo `docs/api-openapi.yaml`.
3. Convertir `prototipos/alumno.html` y `prototipos/buffet.html` en las apps reales.
4. Integrar autenticacion, scanner y emision de credenciales dinamicas.

## Publicacion

GitHub Pages sirve la PWA actual desde `index.html`.
