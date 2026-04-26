# Roadmap

## Etapa 0. Definicion

Objetivo:

- cerrar alcance
- validar flujos
- validar roles

Entregables:

- arquitectura
- modelo de datos
- contrato API
- prototipos

## Etapa 1. MVP Tecnico

Objetivo:

- tener circuito completo funcionando

Incluye:

- login alumno
- login buffet
- emision de credencial dinamica
- validacion online
- una entrega por dia
- panel admin basico

Fuera de etapa:

- offline
- integraciones externas

## Etapa 2. Piloto

Objetivo:

- probar operacion real en una escuela o sede

Incluye:

- importacion de alumnos
- reportes diarios
- bloqueos y excepciones
- auditoria basica
- mejoras de UX segun observacion de campo

## Etapa 3. Operacion Estable

Objetivo:

- robustecer para uso diario sostenido

Incluye:

- administracion de dispositivos
- roles finos
- dashboard operativo
- exportaciones
- logs enriquecidos

## Etapa 4. Robustez Avanzada

Objetivo:

- tolerar conectividad irregular y crecer

Incluye:

- modo offline controlado
- multi-sede
- integraciones con sistema escolar
- notificaciones

## Orden Recomendado De Construccion

1. Backend minimo
2. App buffet
3. App alumno
4. Panel admin
5. Reportes
6. Offline controlado

## Riesgos Principales

- UX lenta del buffet
- mala conectividad
- captura de pantalla reutilizada
- operadores sin capacitacion
- carga inicial de padron inconsistente

## Mitigaciones

- respuesta visual grande y rapida
- credenciales de vigencia corta
- validacion centralizada
- auditoria
- importacion con validaciones
