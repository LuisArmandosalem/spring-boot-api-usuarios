# 🎬 Demo del Generador de Proyectos Spring Boot

## 📋 Ejemplo de Ejecución Real

Este documento muestra un ejemplo real de cómo usar el script generador.

## 🎯 Paso 1: Ejecutar el Script

```bash
./generar-proyecto-spring-boot.sh
```

## 💬 Paso 2: Responder las Preguntas

### Entrada del Usuario:

```
GroupId (ej: com.ejemplo): com.miempresa
ArtifactId (ej: mi-api): tienda-online-api
Paquete base (ej: com.ejemplo.miapi): com.miempresa.tiendaonline
Nombre del proyecto (ej: Mi API REST): API REST para Tienda Online
Versión inicial (default: 1.0.0): 1.0.0
Puerto del servidor (default: 8080): 8080

Configuración de Base de Datos PostgreSQL
Nombre de la base de datos: tienda_db
Usuario de PostgreSQL: admin
Contraseña de PostgreSQL: admin123
Puerto de PostgreSQL: 5432

¿Continuar con la generación? (s/n): s
¿Deseas inicializar un repositorio Git? (s/n): s
¿Deseas compilar el proyecto ahora? (s/n): s
```

## ✅ Paso 3: Resultado

### Estructura Generada:

```
tienda-online-api/
├── pom.xml
├── README.md
├── .gitignore
├── src/
│   ├── main/
│   │   ├── java/com/miempresa/tiendaonline/
│   │   │   ├── TiendaOnlineApiApplication.java
│   │   │   ├── controller/
│   │   │   │   └── UsuarioController.java
│   │   │   ├── service/
│   │   │   │   ├── UsuarioService.java
│   │   │   │   └── UsuarioServiceImpl.java
│   │   │   ├── repository/
│   │   │   │   └── UsuarioRepository.java
│   │   │   ├── entity/
│   │   │   │   └── Usuario.java
│   │   │   ├── exception/
│   │   │   │   ├── ResourceNotFoundException.java
│   │   │   │   ├── DataConflictException.java
│   │   │   │   └── GlobalExceptionHandler.java
│   │   │   └── dto/
│   │   │       └── ErrorResponse.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       ├── java/com/miempresa/tiendaonline/
│       │   └── TiendaOnlineApiApplicationTests.java
│       └── resources/
│           └── application.properties
```

### Estadísticas del Proyecto:

```
📊 Archivos generados:
- 11 archivos Java
- 2 archivos de configuración
- 1 pom.xml
- 1 README.md
- 1 .gitignore

⏱️ Tiempo total: ~90 segundos
```

## 🚀 Paso 4: Compilar y Ejecutar

### Crear la Base de Datos:

```bash
createdb -U admin tienda_db
```

### Compilar el Proyecto:

```bash
cd tienda-online-api
mvn clean compile
```

**Salida esperada:**
```
[INFO] BUILD SUCCESS
[INFO] Total time:  8.234 s
```

### Ejecutar Tests:

```bash
mvn test
```

**Salida esperada:**
```
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] BUILD SUCCESS
```

### Iniciar la Aplicación:

```bash
mvn spring-boot:run
```

**Salida esperada:**
```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::               (v2.7.18)

2025-10-29 10:30:00.000  INFO --- [main] c.m.t.TiendaOnlineApiApplication : Starting TiendaOnlineApiApplication
2025-10-29 10:30:02.500  INFO --- [main] o.s.b.w.embedded.tomcat.TomcatWebServer : Tomcat started on port(s): 8080 (http)
2025-10-29 10:30:02.510  INFO --- [main] c.m.t.TiendaOnlineApiApplication : Started TiendaOnlineApiApplication in 2.8 seconds
```

## 🌐 Paso 5: Probar la API

### Crear un Usuario:

```bash
curl -X POST http://localhost:8080/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Carlos Martínez",
    "email": "carlos@tienda.com",
    "telefono": "+34 600 123 456"
  }'
```

**Respuesta (201 Created):**
```json
{
  "id": 1,
  "nombre": "Carlos Martínez",
  "email": "carlos@tienda.com",
  "telefono": "+34 600 123 456",
  "fechaCreacion": "2025-10-29T10:31:00",
  "fechaActualizacion": "2025-10-29T10:31:00"
}
```

### Listar Usuarios:

```bash
curl http://localhost:8080/api/usuarios
```

**Respuesta (200 OK):**
```json
[
  {
    "id": 1,
    "nombre": "Carlos Martínez",
    "email": "carlos@tienda.com",
    "telefono": "+34 600 123 456",
    "fechaCreacion": "2025-10-29T10:31:00",
    "fechaActualizacion": "2025-10-29T10:31:00"
  }
]
```

### Buscar por ID:

```bash
curl http://localhost:8080/api/usuarios/1
```

**Respuesta (200 OK):**
```json
{
  "id": 1,
  "nombre": "Carlos Martínez",
  "email": "carlos@tienda.com",
  "telefono": "+34 600 123 456",
  "fechaCreacion": "2025-10-29T10:31:00",
  "fechaActualizacion": "2025-10-29T10:31:00"
}
```

### Actualizar Usuario:

```bash
curl -X PUT http://localhost:8080/api/usuarios/1 \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Carlos Martínez García",
    "email": "carlos@tienda.com",
    "telefono": "+34 600 123 999"
  }'
```

**Respuesta (200 OK):**
```json
{
  "id": 1,
  "nombre": "Carlos Martínez García",
  "email": "carlos@tienda.com",
  "telefono": "+34 600 123 999",
  "fechaCreacion": "2025-10-29T10:31:00",
  "fechaActualizacion": "2025-10-29T10:35:00"
}
```

### Eliminar Usuario:

```bash
curl -X DELETE http://localhost:8080/api/usuarios/1
```

**Respuesta (204 No Content)**

### Probar Validación de Email Duplicado:

```bash
# Crear primer usuario
curl -X POST http://localhost:8080/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Ana López","email":"ana@tienda.com","telefono":"111"}'

# Intentar crear otro con mismo email
curl -X POST http://localhost:8080/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{"nombre":"María López","email":"ana@tienda.com","telefono":"222"}'
```

**Respuesta (409 Conflict):**
```json
{
  "timestamp": "2025-10-29 10:40:00",
  "status": 409,
  "error": "Conflict",
  "message": "Ya existe un usuario con el email: ana@tienda.com",
  "path": "/api/usuarios"
}
```

## 📊 Métricas del Proyecto Generado

### Líneas de Código:

```
Java (main):        ~450 líneas
Java (test):        ~50 líneas
Configuración:      ~100 líneas
Documentación:      ~200 líneas
─────────────────────────────────
Total:              ~800 líneas
```

### Cobertura de Funcionalidad:

```
✅ CRUD completo (100%)
✅ Validaciones (email único, campos requeridos)
✅ Manejo de errores (404, 409, 400, 500)
✅ Transacciones
✅ Timestamps automáticos
✅ Normalización de datos
✅ Tests unitarios
```

## 🎯 Próximos Pasos con el Proyecto

### 1. Agregar Nueva Entidad (Producto)

**Crear**: `src/main/java/com/miempresa/tiendaonline/entity/Producto.java`

```java
@Entity
@Table(name = "productos")
public class Producto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String nombre;
    
    private Double precio;
    
    private Integer stock;
    
    // getters, setters, etc.
}
```

### 2. Crear Repositorio

**Crear**: `src/main/java/com/miempresa/tiendaonline/repository/ProductoRepository.java`

```java
@Repository
public interface ProductoRepository extends JpaRepository<Producto, Long> {
    List<Producto> findByNombreContaining(String nombre);
    List<Producto> findByPrecioBetween(Double min, Double max);
}
```

### 3. Crear Servicio

Copiar el patrón de `UsuarioService` y `UsuarioServiceImpl`.

### 4. Crear Controlador

Copiar el patrón de `UsuarioController`.

### 5. Agregar Validaciones

```java
@Entity
@Table(name = "productos")
public class Producto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "El nombre es requerido")
    @Size(min = 3, max = 100)
    private String nombre;
    
    @NotNull(message = "El precio es requerido")
    @Min(value = 0, message = "El precio debe ser mayor a 0")
    private Double precio;
    
    // ...
}
```

## 🎓 Lo que Has Logrado

Después de seguir este demo, tienes:

✅ Un proyecto Spring Boot completamente funcional  
✅ API REST con 6 endpoints  
✅ Base de datos PostgreSQL configurada  
✅ Tests unitarios ejecutándose  
✅ Validaciones de negocio implementadas  
✅ Manejo de errores robusto  
✅ Documentación completa  
✅ Patrón claro para agregar nuevas funcionalidades  

## 📚 Recursos para Continuar

1. **Documentación Spring Boot**: https://spring.io/projects/spring-boot
2. **Guía de JPA**: https://spring.io/guides/gs/accessing-data-jpa/
3. **REST API Best Practices**: https://restfulapi.net/
4. **PostgreSQL Docs**: https://www.postgresql.org/docs/

## 💡 Tips Finales

1. **Explora el código generado** - Cada clase tiene comentarios explicativos
2. **Sigue el patrón** - Usa Usuario como plantilla para nuevas entidades
3. **Lee la documentación** - Los archivos MD tienen información detallada
4. **Experimenta** - Prueba diferentes endpoints y casos de uso
5. **Agrega funcionalidades** - El proyecto es extensible

---

## 🎉 ¡Felicitaciones!

Has completado exitosamente:
- ✅ Generación del proyecto
- ✅ Configuración de la base de datos
- ✅ Compilación y tests
- ✅ Ejecución de la aplicación
- ✅ Pruebas de todos los endpoints

**¡Ahora estás listo para desarrollar tu propia API! 🚀**

---

**Para más información consulta:**
- `GUIA-RAPIDA.md` - Referencia rápida
- `GUIA-USO-GENERADOR.md` - Tutorial completo
- `README-GENERADOR.md` - Documentación técnica
- `RESUMEN-GENERADOR.md` - Resumen ejecutivo
