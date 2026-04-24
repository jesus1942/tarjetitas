# Arquitectura Del Sistema

## Objetivo

Resolver la entrega diaria de almuerzos sin anotacion manual y sin permitir reutilizacion indefinida de una credencial local.

## Principio central

La app instalada en el celular del alumno no puede decidir por si sola si el almuerzo ya fue usado. La fuente de verdad tiene que ser un backend central.

## Apps principales

- App del alumno
- App del buffet

El panel administrativo existe como soporte interno, pero no es una app operativa principal para el retiro diario.

## Actores

- Alumno: abre su app y presenta su credencial.
- Buffet: escanea o valida desde la app del buffet.
- Administracion: administra alumnos, permisos, cupos, calendarios y reportes.
- Backend: autentica, emite credenciales, valida consumos y audita.

## Componentes

### 1. App del alumno

Responsabilidades:

- iniciar sesion
- mostrar estado del dia
- exponer credencial digital
- informar si ya retiro o si esta bloqueado
- conservar datos minimos offline

No debe:

- marcar consumos localmente como verdad definitiva
- permitir reusar una credencial vieja sin validacion

### 2. App del buffet

Responsabilidades:

- escanear QR o ingresar identificador manual
- consultar/validar contra backend
- mostrar resultado grande y rapido
- registrar operador, hora y punto de entrega

Estados sugeridos:

- `aprobado`
- `ya_retirado`
- `no_habilitado`
- `credencial_vencida`
- `requiere_revision`

### 3. Panel de administracion

Responsabilidades:

- alta y baja de alumnos
- importacion masiva
- asignacion de permisos
- calendario de servicio
- excepciones y bloqueos
- reportes por dia, curso y alumno
- auditoria de operadores

### 4. Backend central

Responsabilidades:

- autenticacion
- emision de credenciales dinamicas
- validacion antifraude
- registro de consumos
- auditoria
- administracion de dispositivos y operadores

## Flujo operativo ideal

1. El alumno abre la app.
2. La app obtiene una credencial valida para la ventana actual.
3. El operador escanea la credencial.
4. El backend verifica:
   - identidad
   - habilitacion del dia
   - si ya hubo consumo
   - si la credencial sigue vigente
   - si el operador y el punto de entrega son validos
5. Si pasa las reglas, el backend crea el consumo.
6. La app del buffet muestra `APROBADO`.
7. Cualquier segundo intento del mismo dia devuelve `YA RETIRADO`.

## Estrategia antifraude

### Regla 1. Credencial dinamica

El QR no debe ser fijo. Debe cambiar por tiempo o por nonce.

Contenido recomendado:

- `student_id`
- `entitlement_id`
- `issued_at`
- `expires_at`
- `device_id`
- `nonce`
- firma del servidor

### Regla 2. Validacion centralizada

Aunque el QR sea valido criptograficamente, el backend debe consultar si ya existe un consumo del mismo alumno en la fecha y servicio.

### Regla 3. Ventana corta de vigencia

La credencial debe tener una vigencia breve, por ejemplo 30 a 60 segundos.

### Regla 4. Auditoria completa

Registrar:

- alumno
- operador
- dispositivo del buffet
- dispositivo del alumno
- hora
- resultado
- motivo de rechazo

### Regla 5. Modo offline controlado

Solo si hace falta.

Si se habilita:

- la app del buffet usa una lista local de habilitados del dia
- cada consumo offline queda firmado localmente
- al reconectar, sincroniza
- los conflictos se auditan

## Modelo de despliegue recomendado

- Frontend alumno: PWA
- Frontend buffet: PWA optimizada para camara
- Frontend admin: web responsiva
- Backend: API REST
- Base de datos: PostgreSQL
- Autenticacion: JWT corto + refresh seguro
- Hosting inicial: una sola app backend + DB administrada

## Modulos del backend

- `auth`
- `students`
- `entitlements`
- `credentials`
- `redemptions`
- `operators`
- `stations`
- `reports`
- `audit`

## Reglas de negocio minimas

- un alumno no puede tener mas de un consumo por servicio por fecha
- una credencial expirada no se acepta
- un operador inactivo no puede validar
- un alumno bloqueado no puede retirar
- toda anulacion de consumo requiere operador y motivo

## Fases de implementacion

### Fase 1. MVP operativo

- login simple
- credencial dinamica
- validacion online desde buffet
- una entrega por alumno por dia
- panel basico

### Fase 2. Operacion real

- importacion masiva
- reportes
- auditoria
- soporte para excepciones
- administracion de dispositivos

### Fase 3. Robustez

- modo offline controlado
- notificaciones
- multi-sede
- integracion con sistemas escolares

## Decision recomendada

Si hay que empezar rapido, construir primero:

- `prototipos/alumno.html`
- `prototipos/buffet.html`
- `prototipos/admin.html`
- API minima de autenticacion, credencial y validacion

Eso ya permite validar la operacion sin arrastrar el sistema manual.
