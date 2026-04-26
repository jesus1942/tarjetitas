# Decisiones Tecnicas

## Decision 1. Dos apps operativas

Se definen dos apps principales:

- `Alumno`
- `Buffet`

Razon:

- los flujos son muy distintos
- el buffet necesita velocidad y camara
- el alumno necesita credencial y estado personal

## Decision 2. Backend central como fuente de verdad

Razon:

- evitar uso indefinido
- impedir doble retiro
- permitir auditoria

Consecuencia:

- la app del alumno no puede marcar consumos por si sola

## Decision 3. Credencial dinamica

Razon:

- una credencial fija se puede compartir o reutilizar

Implementacion sugerida:

- payload firmado por servidor
- expiracion corta
- nonce unico

## Decision 4. PWA en primera instancia

Razon:

- menor costo de desarrollo
- instalable desde celular
- suficiente para MVP

Reevaluar nativo solo si:

- el scanner necesita capacidades superiores
- el modo offline se vuelve muy complejo

## Decision 5. PostgreSQL como base

Razon:

- integridad relacional
- indices y restricciones fuertes
- auditoria y reportes simples

## Decision 6. REST para el MVP

Razon:

- simple de implementar
- simple de documentar
- suficiente para flujo transaccional

## Decision 7. Offiline no entra en primera version

Razon:

- complejiza antifraude
- aumenta conflicto de sincronizacion
- no es requisito para validar producto

## Decision 8. Admin web, no app principal

Razon:

- uso menos frecuente
- mejor operacion en pantallas grandes
- menor complejidad
