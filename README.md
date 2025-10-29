# 🚀 API REST con Spring Boot y PostgreSQL

## 📋 Descripción

Este proyecto es una **API REST completa** desarrollada con **Spring Boot** que implementa un sistema de gestión de usuarios con arquitectura profesional de capas. Es un ejemplo práctico de las mejores prácticas en desarrollo de aplicaciones Java enterprise.

---

## 🎁 **NUEVO: Generador de Proyectos Spring Boot para Java 11**

¿Quieres crear tu propio proyecto Spring Boot con Maven desde cero?

**Usa nuestro script generador automático:**

```bash
./generar-proyecto-spring-boot.sh
```

Este script crea un proyecto completo con:
- ✅ Spring Boot 2.7.18 compatible con Java 11
- ✅ Arquitectura completa (Controller, Service, Repository, Entity)
- ✅ CRUD de Usuario de ejemplo
- ✅ PostgreSQL + H2 para tests
- ✅ Manejo global de excepciones
- ✅ Configuración lista para producción

**📖 Documentación del generador:**
- [README-GENERADOR.md](README-GENERADOR.md) - Características y descripción
- [GUIA-USO-GENERADOR.md](GUIA-USO-GENERADOR.md) - Tutorial completo con ejemplos
- [GUIA-RAPIDA.md](GUIA-RAPIDA.md) - Referencia rápida

---

## 🏗️ Arquitectura

### Diagrama de Arquitectura
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   REST Client   │───→│   Spring Boot    │───→│   PostgreSQL    │
│ (curl, Postman, │    │     (puerto      │    │   (mi_proyecto_ │
│  Frontend apps) │    │      8081)       │    │        db)      │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                              │
                       ┌──────┴──────┐
                       │             │
                   Controller     Service
                       │             │
                   Exception      Repository
                   Handler           │
                       │         JPA/Hibernate
                     DTO             │
                                  Entity
```

### Patrones Implementados

- **🎯 MVC (Model-View-Controller)**
- **🏭 Repository Pattern**
- **🔧 Dependency Injection**
- **📦 Data Transfer Object (DTO)**
- **⚠️ Global Exception Handling**
- **🔄 Service Layer Pattern**

## 📁 Estructura del Proyecto

```
src/main/java/com/ejemplo/mi_proyecto/
├── 🎮 controller/           # Capa de Presentación
│   └── UsuarioController.java
├── 🏢 service/             # Capa de Lógica de Negocio
│   ├── UsuarioService.java
│   └── impl/
│       └── UsuarioServiceImpl.java
├── 🗄️ repository/          # Capa de Acceso a Datos
│   └── UsuarioRepository.java
├── 📊 entity/              # Modelos de Datos
│   └── Usuario.java
├── ⚠️ exception/           # Manejo de Errores
│   ├── ResourceNotFoundException.java
│   ├── DataConflictException.java
│   └── GlobalExceptionHandler.java
└── 📦 dto/                 # Objetos de Transferencia
    └── ErrorResponse.java
```

## 🛠️ Tecnologías Utilizadas

- **☕ Java 17**
- **🍃 Spring Boot 3.5.6**
- **🌐 Spring Web** (REST APIs)
- **💾 Spring Data JPA** (Persistencia)
- **🐘 PostgreSQL** (Base de datos)
- **🔧 Maven** (Gestión de dependencias)
- **📋 Hibernate** (ORM)

## 📦 Dependencias

```xml
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    <dependency>
        <groupId>org.postgresql</groupId>
        <artifactId>postgresql</artifactId>
        <scope>runtime</scope>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```

## ⚙️ Configuración

### Base de Datos (application.properties)
```properties
spring.application.name=mi-proyecto

# Configuración de PostgreSQL
spring.datasource.url=jdbc:postgresql://localhost:5432/mi_proyecto_db
spring.datasource.username=luis
spring.datasource.password=123
spring.datasource.driver-class-name=org.postgresql.Driver

# Configuración de JPA/Hibernate
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# Puerto del servidor
server.port=8081
```

## 🌐 API Endpoints

| Método | Endpoint | Descripción | Códigos de Estado |
|--------|----------|-------------|-------------------|
| `GET` | `/api/usuarios` | Obtener todos los usuarios | 200 |
| `GET` | `/api/usuarios/{id}` | Obtener usuario por ID | 200, 404, 400 |
| `GET` | `/api/usuarios/email/{email}` | Buscar por email | 200, 404, 400 |
| `POST` | `/api/usuarios` | Crear nuevo usuario | 201, 409, 400 |
| `PUT` | `/api/usuarios/{id}` | Actualizar usuario | 200, 404, 409, 400 |
| `DELETE` | `/api/usuarios/{id}` | Eliminar usuario | 204, 404, 400 |

### Ejemplos de Uso

#### Crear Usuario
```bash
curl -X POST http://localhost:8081/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Juan Pérez",
    "email": "juan@example.com",
    "telefono": "123-456-7890"
  }'
```

#### Respuesta Exitosa
```json
{
  "id": 1,
  "nombre": "Juan Pérez",
  "email": "juan@example.com",
  "telefono": "123-456-7890"
}
```

#### Respuesta de Error (Email Duplicado)
```json
{
  "timestamp": "2025-10-20 18:56:55",
  "status": 409,
  "error": "Data Conflict",
  "message": "Ya existe un usuario con el email: juan@example.com",
  "path": "/api/usuarios"
}
```

## 🏛️ Arquitectura por Capas

### 🎮 Controller Layer
**Responsabilidad**: Manejar peticiones HTTP y respuestas
```java
@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {
    
    private final UsuarioService usuarioService;
    
    @PostMapping
    public ResponseEntity<Usuario> crearUsuario(@RequestBody Usuario usuario) {
        Usuario usuarioCreado = usuarioService.crearUsuario(usuario);
        return ResponseEntity.status(HttpStatus.CREATED).body(usuarioCreado);
    }
}
```

### 🏢 Service Layer
**Responsabilidad**: Lógica de negocio, validaciones, transacciones
```java
@Service
@Transactional
public class UsuarioServiceImpl implements UsuarioService {
    
    public Usuario crearUsuario(Usuario usuario) {
        validarUsuario(usuario);
        usuario.setEmail(usuario.getEmail().trim().toLowerCase());
        
        if (usuarioRepository.existsByEmail(usuario.getEmail())) {
            throw new DataConflictException("Email ya existe: " + usuario.getEmail());
        }
        
        return usuarioRepository.save(usuario);
    }
}
```

### 🗄️ Repository Layer
**Responsabilidad**: Acceso a datos
```java
@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    Optional<Usuario> findByEmail(String email);
    boolean existsByEmail(String email);
}
```

### 📊 Entity Layer
**Responsabilidad**: Mapeo objeto-relacional
```java
@Entity
@Table(name = "usuarios")
public class Usuario {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String nombre;
    
    @Column(unique = true, nullable = false)
    private String email;
    
    private String telefono;
}
```

## ⚠️ Manejo de Errores

### Excepciones Personalizadas
- **`ResourceNotFoundException`**: Recurso no encontrado (404)
- **`DataConflictException`**: Conflicto de datos (409)
- **`IllegalArgumentException`**: Argumentos inválidos (400)

### Global Exception Handler
```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    
    @ExceptionHandler(DataConflictException.class)
    public ResponseEntity<ErrorResponse> handleDataConflictException(
            DataConflictException ex, WebRequest request) {
        
        ErrorResponse errorResponse = new ErrorResponse(
            HttpStatus.CONFLICT.value(),
            "Data Conflict",
            ex.getMessage(),
            request.getDescription(false)
        );
        
        return new ResponseEntity<>(errorResponse, HttpStatus.CONFLICT);
    }
}
```

## 🔧 Funcionalidades Avanzadas

### ✅ Validaciones Implementadas
- **Email único**: Previene emails duplicados
- **Campos obligatorios**: Nombre y email requeridos
- **Formato de email**: Validación básica de estructura
- **Normalización**: Email convertido a minúsculas
- **Longitud de campos**: Nombre entre 2-100 caracteres

### 🔄 Transacciones
- **`@Transactional`**: Garantiza consistencia de datos
- **`readOnly = true`**: Optimización para consultas
- **Rollback automático**: En caso de errores

### 📦 DTOs
- **`ErrorResponse`**: Respuestas de error estandarizadas
- **Separación de concerns**: Entidades vs. transferencia de datos

## 🚀 Instalación y Ejecución

### Prerrequisitos
- Java 17+
- PostgreSQL 12+
- Maven 3.8+

### Pasos de Instalación

1. **Clonar el repositorio**
```bash
git clone <tu-repositorio>
cd mi-proyecto
```

2. **Configurar PostgreSQL**
```sql
CREATE DATABASE mi_proyecto_db;
CREATE USER luis WITH PASSWORD '123';
GRANT ALL PRIVILEGES ON DATABASE mi_proyecto_db TO luis;
```

3. **Compilar el proyecto**
```bash
mvn clean compile
```

4. **Ejecutar la aplicación**
```bash
mvn spring-boot:run
```

### Scripts de Gestión

El proyecto incluye scripts automatizados para facilitar el desarrollo:

#### `test-complete.sh` - Script Principal
```bash
./test-complete.sh          # Ejecutar tests completos
./test-complete.sh start    # Solo iniciar aplicación
./test-complete.sh stop     # Detener aplicación
./test-complete.sh status   # Ver estado
./test-complete.sh logs     # Ver logs en tiempo real
./test-complete.sh help     # Mostrar ayuda
```

#### `test-improvements.sh` - Pruebas de Arquitectura
```bash
./test-improvements.sh      # Probar mejoras implementadas
```

#### `stop-app.sh` - Parada Rápida
```bash
./stop-app.sh              # Detener aplicación de forma segura
```

## 🧪 Testing

### Pruebas Automatizadas
El proyecto incluye scripts de prueba que validan:

- ✅ Creación de usuarios válidos
- ❌ Manejo de emails duplicados
- ❌ Validación de datos inválidos
- ❌ Búsquedas de recursos inexistentes
- ✅ Actualizaciones exitosas
- ✅ Normalización de datos

### Ejemplo de Prueba
```bash
# Crear usuario válido
curl -X POST http://localhost:8081/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Ana García","email":"ana@test.com","telefono":"555-1234"}'

# Respuesta esperada: HTTP 201 Created
{
  "id": 1,
  "nombre": "Ana García",
  "email": "ana@test.com",
  "telefono": "555-1234"
}
```

## 📈 Beneficios de la Arquitectura

### 🔧 Mantenibilidad
- **Separación clara de responsabilidades**
- **Código organizado por capas**
- **Fácil localización de funcionalidades**

### 🧪 Testabilidad
- **Cada capa se puede probar independientemente**
- **Inyección de dependencias facilita mocking**
- **Lógica de negocio aislada en services**

### 🔒 Robustez
- **Manejo centralizado de errores**
- **Validaciones en múltiples niveles**
- **Transacciones garantizan consistencia**

### 📈 Escalabilidad
- **Fácil agregar nuevas entidades**
- **Estructura estándar para nuevas funcionalidades**
- **Preparado para crecimiento del equipo**

## 🎓 Conceptos Aprendidos

### 🏗️ Patrones de Diseño
- **MVC**: Separación de presentación, lógica y datos
- **Repository**: Abstracción del acceso a datos
- **Dependency Injection**: Inversión de control
- **DTO**: Transferencia segura de datos

### 🍃 Spring Framework
- **Auto-configuration**: Configuración automática
- **Annotations**: Configuración declarativa
- **AOP**: Aspectos transversales (transacciones, excepciones)
- **IoC Container**: Gestión de beans

### 💾 Persistencia
- **JPA**: Estándar de persistencia Java
- **Hibernate**: Implementación ORM
- **Entity Lifecycle**: Ciclo de vida de entidades
- **Lazy Loading**: Carga perezosa de relaciones

## 🚀 Próximos Pasos

### Mejoras Sugeridas
1. **🧪 Tests Unitarios** (JUnit + Mockito)
2. **📝 Bean Validation** (anotaciones de validación)
3. **🔐 Seguridad** (Spring Security + JWT)
4. **📚 Documentación API** (Swagger/OpenAPI)
5. **🐳 Containerización** (Docker + Docker Compose)
6. **☁️ Despliegue** (Cloud platforms)

### Extensiones Posibles
- **Paginación y ordenamiento**
- **Filtros de búsqueda avanzados**
- **Auditoría de cambios**
- **Cache con Redis**
- **Métricas y monitoreo**

## 📝 Notas de Desarrollo

### Decisiones de Diseño
- **Puerto 8081**: Para evitar conflictos con otras aplicaciones
- **Email normalizado**: Siempre en minúsculas para consistencia
- **IDs autogenerados**: Simplicidad en la gestión de entidades
- **Soft validation**: Validaciones básicas pero extensibles

### Consideraciones de Producción
- **Configuración por perfiles**: dev, test, prod
- **Logging estructurado**: Para mejor debugging
- **Health checks**: Endpoints de salud
- **Métricas**: Monitoreo de rendimiento

## 👥 Contribución

1. Fork el proyecto
2. Crear rama de feature (`git checkout -b feature/AmazingFeature`)
3. Commit cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE.md](LICENSE.md) para detalles.

## 🤝 Reconocimientos

- **Spring Team** por el excelente framework
- **PostgreSQL Community** por la robusta base de datos
- **Maven Team** por la gestión de dependencias
- **Hibernate Team** por el ORM

---

## 📞 Contacto

**Desarrollador**: [Tu Nombre]
**Email**: [tu-email@example.com]
**LinkedIn**: [tu-linkedin]
**GitHub**: [tu-github]

---

⭐ **¡Si este proyecto te fue útil, dale una estrella!** ⭐