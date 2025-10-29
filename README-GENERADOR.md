# 📝 Generador de Proyectos Spring Boot Maven con Java 11

## 🎯 Descripción

Script automatizado para generar proyectos Spring Boot con Maven configurados para Java 11, ideal para crear APIs REST con PostgreSQL.

## 🚀 Características

- ✅ Configuración automática para Java 11
- ✅ Spring Boot 2.7.18 (última versión compatible con Java 11)
- ✅ Estructura completa de proyecto Maven
- ✅ Arquitectura en capas (Controller, Service, Repository, Entity)
- ✅ Manejo global de excepciones
- ✅ Configuración de PostgreSQL
- ✅ Entity de ejemplo (Usuario) con operaciones CRUD
- ✅ Endpoints REST completos
- ✅ Tests unitarios básicos
- ✅ README y .gitignore incluidos

## 📋 Prerrequisitos

- Java 11 o superior instalado
- Maven 3.6+ instalado
- PostgreSQL (opcional, para ejecutar el proyecto generado)

## 🔧 Uso

### Modo Interactivo

Ejecuta el script y sigue las instrucciones en pantalla:

```bash
./generar-proyecto-spring-boot.sh
```

El script te pedirá:
- **GroupId**: El groupId de Maven (ej: `com.miempresa`)
- **ArtifactId**: El artifactId de Maven (ej: `mi-api`)
- **Paquete base**: El paquete Java base (ej: `com.miempresa.miapi`)
- **Nombre del proyecto**: Nombre descriptivo del proyecto
- **Versión**: Versión inicial del proyecto (default: 1.0.0)
- **Puerto del servidor**: Puerto donde correrá la aplicación (default: 8080)
- **Configuración de PostgreSQL**: Nombre de BD, usuario, contraseña, puerto

### Ejemplo de Ejecución

```
🚀 Configurando proyecto Spring Boot - API de Usuarios
===============================================

📋 Verificando Java...
✅ Java 11 detectado

📋 Verificando Maven...
✅ Maven detectado: Apache Maven 3.8.6

📋 Configuración del Proyecto
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
GroupId (ej: com.ejemplo): com.miempresa
ArtifactId (ej: mi-api): usuarios-api
Paquete base (ej: com.ejemplo.miapi): com.miempresa.usuariosapi
Nombre del proyecto (ej: Mi API REST): API de Gestión de Usuarios
Versión inicial (default: 1.0.0): 1.0.0
Puerto del servidor (default: 8080): 8080

📋 Configuración de Base de Datos PostgreSQL
Nombre de la base de datos (default: usuarios_api_db): usuarios_db
Usuario de PostgreSQL (default: postgres): postgres
Contraseña de PostgreSQL (default: postgres): postgres
Puerto de PostgreSQL (default: 5432): 5432
```

## 📁 Estructura del Proyecto Generado

```
mi-api/
├── pom.xml
├── README.md
├── .gitignore
└── src/
    ├── main/
    │   ├── java/
    │   │   └── com/ejemplo/miapi/
    │   │       ├── MiApiApplication.java
    │   │       ├── controller/
    │   │       │   └── UsuarioController.java
    │   │       ├── service/
    │   │       │   ├── UsuarioService.java
    │   │       │   └── UsuarioServiceImpl.java
    │   │       ├── repository/
    │   │       │   └── UsuarioRepository.java
    │   │       ├── entity/
    │   │       │   └── Usuario.java
    │   │       ├── exception/
    │   │       │   ├── ResourceNotFoundException.java
    │   │       │   ├── DataConflictException.java
    │   │       │   └── GlobalExceptionHandler.java
    │   │       └── dto/
    │   │           └── ErrorResponse.java
    │   └── resources/
    │       └── application.properties
    └── test/
        └── java/
            └── com/ejemplo/miapi/
                └── MiApiApplicationTests.java
```

## 🛠️ Dependencias Incluidas

El proyecto generado incluye las siguientes dependencias:

### Principales
- `spring-boot-starter-web` - Para crear APIs REST
- `spring-boot-starter-data-jpa` - Para persistencia con JPA/Hibernate
- `postgresql` - Driver de PostgreSQL
- `spring-boot-starter-validation` - Para validaciones de datos
- `lombok` - Para reducir código boilerplate (opcional)

### Testing
- `spring-boot-starter-test` - Framework de testing de Spring Boot
- `h2` - Base de datos en memoria para tests

## 📡 Endpoints Generados

El proyecto incluye endpoints completos para gestión de usuarios:

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/api/usuarios` | Obtener todos los usuarios |
| GET | `/api/usuarios/{id}` | Obtener usuario por ID |
| GET | `/api/usuarios/email/{email}` | Buscar usuario por email |
| POST | `/api/usuarios` | Crear nuevo usuario |
| PUT | `/api/usuarios/{id}` | Actualizar usuario |
| DELETE | `/api/usuarios/{id}` | Eliminar usuario |

## 🎓 Conceptos Implementados

### Arquitectura en Capas
- **Controller**: Maneja peticiones HTTP
- **Service**: Contiene lógica de negocio
- **Repository**: Acceso a datos con Spring Data JPA
- **Entity**: Modelos de dominio con JPA
- **Exception**: Manejo centralizado de errores
- **DTO**: Objetos de transferencia de datos

### Características Avanzadas
- ✅ Validación de datos
- ✅ Manejo global de excepciones
- ✅ Respuestas de error estandarizadas
- ✅ Transacciones con `@Transactional`
- ✅ Inyección de dependencias
- ✅ Timestamps automáticos en entidades
- ✅ Normalización de datos (email en minúsculas)
- ✅ Validación de duplicados

## 🚀 Cómo Usar el Proyecto Generado

### 1. Navegar al directorio

```bash
cd [nombre-del-proyecto]
```

### 2. Configurar PostgreSQL

Crear la base de datos:

```bash
createdb -U postgres nombre_base_datos
```

O desde psql:

```sql
CREATE DATABASE nombre_base_datos;
```

### 3. Compilar

```bash
mvn clean compile
```

### 4. Ejecutar tests

```bash
mvn test
```

### 5. Ejecutar la aplicación

```bash
mvn spring-boot:run
```

### 6. Probar la API

Crear un usuario:

```bash
curl -X POST http://localhost:8080/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Juan Pérez",
    "email": "juan@example.com",
    "telefono": "123456789"
  }'
```

Obtener todos los usuarios:

```bash
curl http://localhost:8080/api/usuarios
```

## 🔍 Validaciones del Script

El script realiza las siguientes validaciones:

- ✅ Java 11 o superior instalado
- ✅ Maven instalado
- ✅ Confirmación antes de generar el proyecto
- ✅ Opción de inicializar repositorio Git
- ✅ Opción de compilar automáticamente

## 📝 Personalización

Después de generar el proyecto, puedes:

1. Modificar `application.properties` para ajustar la configuración
2. Agregar nuevas entidades copiando el patrón de `Usuario`
3. Agregar validaciones con Bean Validation (`@NotNull`, `@Email`, etc.)
4. Implementar seguridad con Spring Security
5. Agregar documentación de API con Swagger/OpenAPI

## 🐛 Solución de Problemas

### Error: Java version menor a 11

**Solución**: Instala Java 11 o superior y asegúrate de que esté en el PATH.

```bash
java -version
```

### Error: Maven no encontrado

**Solución**: Instala Maven o usa Maven Wrapper incluido en el proyecto generado:

```bash
./mvnw spring-boot:run
```

### Error de conexión a PostgreSQL

**Solución**: 
1. Verifica que PostgreSQL esté corriendo
2. Confirma que la base de datos existe
3. Verifica credenciales en `application.properties`

```bash
# Verificar estado de PostgreSQL
sudo systemctl status postgresql

# Conectar a PostgreSQL
psql -U postgres
```

## 📚 Recursos Adicionales

- [Documentación de Spring Boot 2.7](https://docs.spring.io/spring-boot/docs/2.7.x/reference/html/)
- [Spring Data JPA](https://docs.spring.io/spring-data/jpa/docs/current/reference/html/)
- [Maven Getting Started](https://maven.apache.org/guides/getting-started/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## 🤝 Contribuciones

Si encuentras algún problema o tienes sugerencias, por favor:

1. Reporta issues
2. Propón mejoras
3. Comparte el script con otros desarrolladores

## 📄 Licencia

Este script es de uso libre y puede ser modificado según tus necesidades.

---

**¡Feliz codificación! 🚀**
