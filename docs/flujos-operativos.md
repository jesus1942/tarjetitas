# Flujos Operativos

## Flujo Diario

### Antes del servicio

1. Administracion confirma calendario activo.
2. Operadores del buffet inician sesion.
3. El sistema deja disponibles credenciales del dia.

### Durante el servicio

1. Alumno presenta la app.
2. Buffet escanea.
3. Backend valida.
4. Se muestra resultado.
5. Si corresponde, se entrega almuerzo.

### Despues del servicio

1. Administracion revisa resumen diario.
2. Se investigan rechazos o excepciones.
3. Se exporta reporte si hace falta.

## Flujo De Validacion

### Resultado aprobado

- alumno identificado
- permiso vigente
- sin consumo previo en la fecha
- credencial no vencida
- operador habilitado

Respuesta esperada:

- color verde
- nombre visible
- hora de registro
- mensaje corto y claro

### Resultado rechazado

Motivos posibles:

- ya retiro
- alumno no habilitado
- credencial expirada
- firma invalida
- operador inactivo

Respuesta esperada:

- color rojo o naranja
- motivo claro
- sin ambiguedad para el operador

## Flujo De Excepcion

### Alumno sin bateria o sin acceso

Opciones:

- busqueda manual por legajo o DNI
- validacion por nombre + curso + confirmacion visual

Condicion:

- debe seguir validando contra backend

### Correccion manual

Solo administracion o rol autorizado puede:

- anular consumo
- volver a habilitar
- cambiar estado

Siempre debe pedirse:

- motivo
- operador responsable
- timestamp

## Flujo Offline Controlado

Solo si se decide implementarlo.

### Preparacion

1. El buffet descarga lista del dia.
2. El dispositivo queda con snapshot firmado.

### Validacion offline

1. Se valida contra snapshot local.
2. Se registra evento pendiente.
3. Se marca como pendiente de sincronizacion.

### Reconexion

1. El dispositivo sube eventos pendientes.
2. Backend resuelve conflictos.
3. Toda diferencia queda auditada.

## Estados Del Alumno En El Dia

- `habilitado`
- `ya_retirado`
- `bloqueado`
- `sin_permiso`
- `requiere_revision`

## Estados De La Credencial

- `vigente`
- `expirada`
- `invalida`
- `consumida`

## Estados Del Operador

- `activo`
- `inactivo`
- `suspendido`
