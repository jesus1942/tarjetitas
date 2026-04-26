# Alcance Funcional

## Objetivo Del Producto

Digitalizar la entrega de almuerzos escolares con dos apps operativas:

- `Alumno`
- `Buffet`

Y un panel interno de administracion para configuracion y control.

## Problemas Que Resuelve

- elimina anotacion manual
- reduce errores de registro
- evita doble retiro en el mismo dia
- permite auditoria posterior
- acelera el flujo de entrega

## Apps Del Sistema

### App Alumno

Funciones incluidas:

- iniciar sesion
- ver estado del dia
- mostrar credencial dinamica
- ver si ya retiro
- ver mensajes de bloqueo o excepcion

Funciones excluidas del MVP:

- pagos
- chat
- notificaciones push
- mensajeria con administracion

### App Buffet

Funciones incluidas:

- login de operador
- escaneo de credencial
- validacion online
- respuesta visual inmediata
- historial reciente del puesto
- busqueda manual por alumno

Funciones excluidas del MVP:

- cierres contables
- gestion de stock
- impresion de tickets

### Panel Interno

Funciones incluidas:

- ABM de alumnos
- importacion masiva
- alta y baja de permisos
- bloqueos y excepciones
- consulta de entregas
- auditoria basica

Funciones excluidas del MVP:

- integracion con ERP escolar
- dashboards avanzados
- automatizaciones complejas

## Reglas Operativas

- un alumno puede retirar como maximo una vez por servicio y por fecha
- la validacion real ocurre en backend
- un QR o token vencido debe fallar
- un alumno bloqueado no debe poder retirar
- toda correccion manual debe dejar auditoria

## Casos De Uso Principales

### Caso 1. Retiro normal

1. Alumno abre su app.
2. Muestra QR dinamico.
3. Buffet escanea.
4. Sistema valida.
5. Sistema registra consumo.
6. Buffet entrega.

### Caso 2. Ya retiro hoy

1. Alumno vuelve a presentarse.
2. Buffet escanea.
3. Sistema detecta consumo previo.
4. Responde `ya_retirado`.
5. No se entrega.

### Caso 3. Alumno bloqueado

1. Buffet escanea.
2. Sistema detecta estado bloqueado.
3. Responde `no_habilitado`.
4. Operador deriva a revision.

### Caso 4. Credencial vencida

1. Buffet escanea una captura vieja.
2. Sistema detecta expiracion.
3. Responde `credencial_vencida`.
4. Alumno debe refrescar su credencial.

## Criterios De Exito

- reducir tiempos de atencion por alumno
- eliminar el doble uso en operacion normal
- poder reconstruir cualquier entrega desde auditoria
- operar con minimo ingreso manual de texto

## Restricciones

- debe funcionar bien desde celular
- no puede depender de que el alumno sea honesto
- debe soportar conectividad variable
- debe ser simple de usar para el buffet
