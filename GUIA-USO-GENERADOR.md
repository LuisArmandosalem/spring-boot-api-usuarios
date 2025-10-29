# 🚀 Guía de Uso del Generador de Proyectos Spring Boot

## 📖 Descripción General

Este script (`generar-proyecto-spring-boot.sh`) te permite crear automáticamente un proyecto completo de Spring Boot con Maven, configurado para Java 11 y listo para desarrollar APIs REST con PostgreSQL.

## ✨ ¿Qué Genera el Script?

El script crea un proyecto completamente funcional con:

### 🏗️ Arquitectura Completa
- ✅ **Controller Layer**: Para manejar peticiones HTTP REST
- ✅ **Service Layer**: Para lógica de negocio con transacciones
- ✅ **Repository Layer**: Para acceso a datos con JPA
- ✅ **Entity Layer**: Modelos de dominio con anotaciones JPA
- ✅ **Exception Handling**: Manejo global de errores
- ✅ **DTOs**: Para respuestas de error estandarizadas

### 🔧 Configuración Incluida
- ✅ **pom.xml** configurado para Java 11
- ✅ **Spring Boot 2.7.18** (última versión compatible con Java 11)
- ✅ **PostgreSQL** como base de datos principal
- ✅ **H2** para tests automáticos
- ✅ **Lombok** para reducir código boilerplate
- ✅ **Bean Validation** para validaciones
- ✅ **JaCoCo** listo para agregar (comentado)

### 📦 Ejemplo de Usuario CRUD
El script genera automáticamente una entidad `Usuario` completa con:
- Operaciones CRUD completas (Create, Read, Update, Delete)
- Validaciones de email único
- Timestamps automáticos
- Endpoints REST funcionales

## 🎯 Ejemplo Práctico Paso a Paso

### 1️⃣ Ejecutar el Script

```bash
cd /ruta/a/tu/repositorio
./generar-proyecto-spring-boot.sh
```

### 2️⃣ Responder las Preguntas

El script te preguntará:

```
GroupId (ej: com.ejemplo): com.miempresa
ArtifactId (ej: mi-api): usuarios-api
Paquete base (ej: com.ejemplo.miapi): com.miempresa.usuariosapi
Nombre del proyecto (ej: Mi API REST): Sistema de Gestión de Usuarios
Versión inicial (default: 1.0.0): 1.0.0
Puerto del servidor (default: 8080): 8080

Configuración de Base de Datos PostgreSQL
Nombre de la base de datos (default: usuarios_api_db): usuarios_db
Usuario de PostgreSQL (default: postgres): postgres
Contraseña de PostgreSQL (default: postgres): mipassword123
Puerto de PostgreSQL (default: 5432): 5432
```

### 3️⃣ Confirmar la Generación

El script mostrará un resumen:

```
Resumen de Configuración
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
GroupId:          com.miempresa
ArtifactId:       usuarios-api
Paquete Base:     com.miempresa.usuariosapi
Nombre:           Sistema de Gestión de Usuarios
Versión:          1.0.0
Puerto:           8080
Base de Datos:    usuarios_db
Usuario DB:       postgres
Puerto DB:        5432
Directorio:       usuarios-api

¿Continuar con la generación? (s/n): s
```

### 4️⃣ Resultado

El script generará:

```
✅ Estructura de directorios creada
✅ pom.xml generado
✅ application.properties generado
✅ Clase principal generada: UsuariosApiApplication.java
✅ Entidad Usuario generada
✅ Repositorio generado
✅ Servicio generado
✅ Controlador REST generado
✅ Excepciones personalizadas generadas
✅ DTOs generados
✅ Configuración de tests generada
✅ Test básico generado
✅ README.md generado
✅ .gitignore generado

¡Proyecto generado exitosamente! 🎉
```

## 📁 Estructura del Proyecto Generado

```
usuarios-api/
├── pom.xml                                    # Configuración Maven
├── README.md                                  # Documentación del proyecto
├── .gitignore                                 # Archivos ignorados por Git
└── src/
    ├── main/
    │   ├── java/com/miempresa/usuariosapi/
    │   │   ├── UsuariosApiApplication.java    # Clase principal
    │   │   ├── controller/
    │   │   │   └── UsuarioController.java     # REST Controller
    │   │   ├── service/
    │   │   │   ├── UsuarioService.java        # Interface del servicio
    │   │   │   └── UsuarioServiceImpl.java    # Implementación del servicio
    │   │   ├── repository/
    │   │   │   └── UsuarioRepository.java     # JPA Repository
    │   │   ├── entity/
    │   │   │   └── Usuario.java               # Entidad JPA
    │   │   ├── exception/
    │   │   │   ├── ResourceNotFoundException.java
    │   │   │   ├── DataConflictException.java
    │   │   │   └── GlobalExceptionHandler.java
    │   │   └── dto/
    │   │       └── ErrorResponse.java         # DTO para errores
    │   └── resources/
    │       └── application.properties         # Configuración de la app
    └── test/
        ├── java/com/miempresa/usuariosapi/
        │   └── UsuariosApiApplicationTests.java
        └── resources/
            └── application.properties         # Configuración para tests
```

## 🚀 Cómo Usar el Proyecto Generado

### Paso 1: Navegar al Proyecto

```bash
cd usuarios-api
```

### Paso 2: Configurar PostgreSQL

Opción A - Crear base de datos desde línea de comandos:

```bash
createdb -U postgres usuarios_db
```

Opción B - Crear desde psql:

```bash
psql -U postgres
```

```sql
CREATE DATABASE usuarios_db;
\q
```

### Paso 3: Compilar el Proyecto

```bash
mvn clean compile
```

Salida esperada:
```
[INFO] BUILD SUCCESS
[INFO] Total time:  5.234 s
```

### Paso 4: Ejecutar Tests

```bash
mvn test
```

Los tests se ejecutan con H2 en memoria, no requieren PostgreSQL.

### Paso 5: Ejecutar la Aplicación

```bash
mvn spring-boot:run
```

Salida esperada:
```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::               (v2.7.18)

...Started UsuariosApiApplication in 3.456 seconds
```

## 🌐 Probar la API

### Endpoints Disponibles

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| POST | `/api/usuarios` | Crear usuario |
| GET | `/api/usuarios` | Listar todos los usuarios |
| GET | `/api/usuarios/{id}` | Obtener usuario por ID |
| GET | `/api/usuarios/email/{email}` | Obtener usuario por email |
| PUT | `/api/usuarios/{id}` | Actualizar usuario |
| DELETE | `/api/usuarios/{id}` | Eliminar usuario |

### Ejemplo 1: Crear un Usuario

```bash
curl -X POST http://localhost:8080/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "María García",
    "email": "maria.garcia@example.com",
    "telefono": "+34 666 777 888"
  }'
```

**Respuesta (201 Created):**
```json
{
  "id": 1,
  "nombre": "María García",
  "email": "maria.garcia@example.com",
  "telefono": "+34 666 777 888",
  "fechaCreacion": "2025-10-29T10:30:00",
  "fechaActualizacion": "2025-10-29T10:30:00"
}
```

### Ejemplo 2: Listar Todos los Usuarios

```bash
curl http://localhost:8080/api/usuarios
```

**Respuesta (200 OK):**
```json
[
  {
    "id": 1,
    "nombre": "María García",
    "email": "maria.garcia@example.com",
    "telefono": "+34 666 777 888",
    "fechaCreacion": "2025-10-29T10:30:00",
    "fechaActualizacion": "2025-10-29T10:30:00"
  }
]
```

### Ejemplo 3: Buscar por ID

```bash
curl http://localhost:8080/api/usuarios/1
```

**Respuesta (200 OK):**
```json
{
  "id": 1,
  "nombre": "María García",
  "email": "maria.garcia@example.com",
  "telefono": "+34 666 777 888",
  "fechaCreacion": "2025-10-29T10:30:00",
  "fechaActualizacion": "2025-10-29T10:30:00"
}
```

### Ejemplo 4: Buscar por Email

```bash
curl http://localhost:8080/api/usuarios/email/maria.garcia@example.com
```

### Ejemplo 5: Actualizar Usuario

```bash
curl -X PUT http://localhost:8080/api/usuarios/1 \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "María García López",
    "email": "maria.garcia@example.com",
    "telefono": "+34 666 777 999"
  }'
```

**Respuesta (200 OK):**
```json
{
  "id": 1,
  "nombre": "María García López",
  "email": "maria.garcia@example.com",
  "telefono": "+34 666 777 999",
  "fechaCreacion": "2025-10-29T10:30:00",
  "fechaActualizacion": "2025-10-29T10:35:00"
}
```

### Ejemplo 6: Eliminar Usuario

```bash
curl -X DELETE http://localhost:8080/api/usuarios/1
```

**Respuesta (204 No Content)**

### Ejemplo 7: Manejar Errores - Email Duplicado

```bash
# Crear primer usuario
curl -X POST http://localhost:8080/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Juan Pérez",
    "email": "juan@example.com",
    "telefono": "123456789"
  }'

# Intentar crear otro usuario con el mismo email
curl -X POST http://localhost:8080/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Juan Martínez",
    "email": "juan@example.com",
    "telefono": "987654321"
  }'
```

**Respuesta (409 Conflict):**
```json
{
  "timestamp": "2025-10-29 10:40:00",
  "status": 409,
  "error": "Conflict",
  "message": "Ya existe un usuario con el email: juan@example.com",
  "path": "/api/usuarios"
}
```

### Ejemplo 8: Manejar Errores - Usuario No Encontrado

```bash
curl http://localhost:8080/api/usuarios/999
```

**Respuesta (404 Not Found):**
```json
{
  "timestamp": "2025-10-29 10:45:00",
  "status": 404,
  "error": "Not Found",
  "message": "Usuario no encontrado con ID: 999",
  "path": "/api/usuarios/999"
}
```

## 🔧 Personalizar el Proyecto Generado

### Agregar Nueva Entidad (Ejemplo: Producto)

1. **Crear la entidad:**

```java
// src/main/java/.../entity/Producto.java
@Entity
@Table(name = "productos")
public class Producto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String nombre;
    
    private Double precio;
    
    // getters y setters
}
```

2. **Crear el repositorio:**

```java
// src/main/java/.../repository/ProductoRepository.java
@Repository
public interface ProductoRepository extends JpaRepository<Producto, Long> {
    List<Producto> findByNombreContaining(String nombre);
}
```

3. **Crear el servicio:**

```java
// src/main/java/.../service/ProductoService.java
public interface ProductoService {
    List<Producto> obtenerTodos();
    Producto obtenerPorId(Long id);
    Producto crear(Producto producto);
    // otros métodos
}
```

4. **Crear el controlador:**

```java
// src/main/java/.../controller/ProductoController.java
@RestController
@RequestMapping("/api/productos")
public class ProductoController {
    
    private final ProductoService productoService;
    
    public ProductoController(ProductoService productoService) {
        this.productoService = productoService;
    }
    
    @GetMapping
    public ResponseEntity<List<Producto>> obtenerTodos() {
        return ResponseEntity.ok(productoService.obtenerTodos());
    }
    
    // otros endpoints
}
```

## 📊 Comandos Maven Útiles

```bash
# Limpiar y compilar
mvn clean compile

# Ejecutar tests
mvn test

# Ver coverage de tests (si configuraste JaCoCo)
mvn test jacoco:report

# Empaquetar como JAR
mvn clean package

# Saltar tests al empaquetar
mvn clean package -DskipTests

# Ejecutar la aplicación
mvn spring-boot:run

# Ejecutar con perfil específico
mvn spring-boot:run -Dspring-boot.run.profiles=dev

# Ver dependencias
mvn dependency:tree

# Actualizar versiones de dependencias
mvn versions:display-dependency-updates
```

## 🐳 Ejecutar con Docker (Opcional)

Crear un `Dockerfile`:

```dockerfile
FROM openjdk:11-jre-slim
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

Construir y ejecutar:

```bash
# Construir JAR
mvn clean package -DskipTests

# Construir imagen Docker
docker build -t usuarios-api:1.0.0 .

# Ejecutar contenedor
docker run -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://host.docker.internal:5432/usuarios_db \
  -e SPRING_DATASOURCE_USERNAME=postgres \
  -e SPRING_DATASOURCE_PASSWORD=mipassword123 \
  usuarios-api:1.0.0
```

## 🔍 Troubleshooting

### Problema: Error de compilación por versión de Java

**Síntoma:**
```
[ERROR] Source option 11 is no longer supported. Use 17 or later.
```

**Solución:**
Verifica que estés usando Java 11:
```bash
java -version
# Debe mostrar: openjdk version "11.x.x"
```

Si tienes múltiples versiones, configura JAVA_HOME:
```bash
export JAVA_HOME=/path/to/java-11
```

### Problema: No puede conectar a PostgreSQL

**Síntoma:**
```
Connection refused. Check that the hostname and port are correct
```

**Soluciones:**

1. Verificar que PostgreSQL esté corriendo:
```bash
sudo systemctl status postgresql
```

2. Iniciar PostgreSQL si está detenido:
```bash
sudo systemctl start postgresql
```

3. Verificar configuración en `application.properties`:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/usuarios_db
spring.datasource.username=postgres
spring.datasource.password=tu_password
```

### Problema: Base de datos no existe

**Síntoma:**
```
database "usuarios_db" does not exist
```

**Solución:**
```bash
createdb -U postgres usuarios_db
```

### Problema: Tests fallan por dependencias

**Síntoma:**
```
[ERROR] Failed to execute goal ... test
```

**Solución:**
Limpiar e instalar dependencias:
```bash
mvn clean install
```

## 📚 Recursos Adicionales

- [Spring Boot 2.7 Documentation](https://docs.spring.io/spring-boot/docs/2.7.x/reference/html/)
- [Spring Data JPA Reference](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/)
- [Maven in 5 Minutes](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)
- [PostgreSQL Tutorial](https://www.postgresql.org/docs/current/tutorial.html)

## 💡 Consejos Finales

1. **Guarda la configuración**: El README generado incluye toda la configuración usada
2. **Versiona tu código**: El .gitignore ya está configurado correctamente
3. **Usa perfiles**: Crea `application-dev.properties` y `application-prod.properties` para diferentes entornos
4. **Agrega validaciones**: Usa anotaciones como `@NotNull`, `@Email`, `@Size` en tus entidades
5. **Documenta tu API**: Considera agregar Swagger/OpenAPI para documentación automática
6. **Implementa seguridad**: Agrega Spring Security cuando sea necesario

---

## 🎉 ¡Listo para Desarrollar!

Ahora tienes un proyecto Spring Boot completo y funcional para comenzar a desarrollar tu API. El proyecto incluye todas las mejores prácticas y está listo para producción.

**¡Feliz codificación! 🚀**
