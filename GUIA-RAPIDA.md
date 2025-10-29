# 📋 Guía Rápida - Generador de Proyectos Spring Boot

## 🚀 Inicio Rápido (3 pasos)

### 1. Ejecutar el Script
```bash
./generar-proyecto-spring-boot.sh
```

### 2. Responder las Preguntas
- GroupId: `com.tuempresa`
- ArtifactId: `mi-api`
- Paquete: `com.tuempresa.miapi`
- Nombre: `Mi API REST`
- Puerto: `8080`
- Base de datos: Configuración de PostgreSQL

### 3. Usar el Proyecto
```bash
cd mi-api
createdb -U postgres mi_api_db
mvn spring-boot:run
```

## 🔧 Configuración de Ejemplo

### Proyecto Simple
```
GroupId:     com.ejemplo
ArtifactId:  usuarios-api
Paquete:     com.ejemplo.usuariosapi
Puerto:      8080
DB:          usuarios_db
```

### Proyecto Empresarial
```
GroupId:     com.miempresa.sistemas
ArtifactId:  gestion-clientes
Paquete:     com.miempresa.sistemas.clientes
Puerto:      8081
DB:          clientes_db
```

## 📡 Endpoints Generados

| Método | URL | Acción |
|--------|-----|--------|
| POST   | `/api/usuarios` | Crear |
| GET    | `/api/usuarios` | Listar todos |
| GET    | `/api/usuarios/{id}` | Obtener uno |
| GET    | `/api/usuarios/email/{email}` | Buscar por email |
| PUT    | `/api/usuarios/{id}` | Actualizar |
| DELETE | `/api/usuarios/{id}` | Eliminar |

## 💻 Comandos Esenciales

```bash
# Compilar
mvn clean compile

# Tests
mvn test

# Ejecutar
mvn spring-boot:run

# Crear JAR
mvn clean package

# Ejecutar JAR
java -jar target/mi-api-1.0.0.jar
```

## 🧪 Probar la API

### Crear Usuario
```bash
curl -X POST http://localhost:8080/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Ana López","email":"ana@example.com","telefono":"123456"}'
```

### Listar Usuarios
```bash
curl http://localhost:8080/api/usuarios
```

### Obtener Usuario
```bash
curl http://localhost:8080/api/usuarios/1
```

## 🗄️ Crear Base de Datos

### Desde terminal
```bash
createdb -U postgres nombre_db
```

### Desde psql
```sql
CREATE DATABASE nombre_db;
```

## ⚙️ Archivos de Configuración

### application.properties (Principal)
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/mi_db
spring.datasource.username=postgres
spring.datasource.password=password
server.port=8080
```

### application.properties (Tests)
```properties
# Usa H2 en memoria automáticamente
# Ya está configurado en src/test/resources/
```

## 🏗️ Estructura Generada

```
mi-api/
├── pom.xml                          # Maven config
├── src/main/java/com/ejemplo/miapi/
│   ├── MiApiApplication.java       # Main class
│   ├── controller/                  # REST endpoints
│   ├── service/                     # Business logic
│   ├── repository/                  # Data access
│   ├── entity/                      # JPA entities
│   ├── exception/                   # Error handling
│   └── dto/                         # Data transfer objects
└── src/main/resources/
    └── application.properties       # Configuration
```

## 📦 Dependencias Incluidas

✅ Spring Boot Web (REST APIs)  
✅ Spring Data JPA (Database)  
✅ PostgreSQL (Production DB)  
✅ H2 (Test DB)  
✅ Lombok (Less boilerplate)  
✅ Validation (Bean validation)  
✅ Spring Boot Test (Testing)  

## ⚠️ Solución Rápida de Problemas

### PostgreSQL no conecta
```bash
sudo systemctl start postgresql
sudo systemctl status postgresql
```

### Base de datos no existe
```bash
createdb -U postgres nombre_db
```

### Tests fallan
```bash
mvn clean install
```

### Puerto en uso
Cambia el puerto en `application.properties`:
```properties
server.port=8081
```

## 🎯 Java 11 - Importante

Este generador usa:
- ✅ Spring Boot 2.7.18 (última versión para Java 11)
- ✅ Java 11 compatible
- ⚠️ NO usar Spring Boot 3.x (requiere Java 17+)

## 📝 Verificar Versiones

```bash
# Java version
java -version
# Debe mostrar: version "11.x.x"

# Maven version
mvn -version
# Debe mostrar: Apache Maven 3.6+
```

## 🔄 Flujo Típico de Desarrollo

1. **Generar proyecto**: `./generar-proyecto-spring-boot.sh`
2. **Crear BD**: `createdb -U postgres mi_db`
3. **Compilar**: `mvn clean compile`
4. **Ejecutar tests**: `mvn test`
5. **Iniciar app**: `mvn spring-boot:run`
6. **Probar API**: `curl http://localhost:8080/api/usuarios`
7. **Desarrollar**: Agregar nuevas entidades y endpoints
8. **Empaquetar**: `mvn clean package`
9. **Desplegar**: `java -jar target/mi-api-1.0.0.jar`

## 💡 Tips Rápidos

- 🔸 Usa nombres en minúsculas con guiones para artifact-id: `mi-api`, `usuarios-api`
- 🔸 Los tests usan H2 automáticamente, no necesitan PostgreSQL
- 🔸 El email se guarda en minúsculas automáticamente
- 🔸 Los timestamps se crean automáticamente
- 🔸 Las validaciones de duplicados ya están implementadas

## 📚 Documentación Completa

- **README-GENERADOR.md**: Características del script
- **GUIA-USO-GENERADOR.md**: Tutorial completo con ejemplos
- **README.md del proyecto generado**: Documentación específica del proyecto

## 🌟 Casos de Uso Recomendados

### API de Usuarios
```
ArtifactId: usuarios-api
Entity: Usuario (ya incluida)
Endpoints: CRUD completo
```

### API de Productos
```
ArtifactId: productos-api
Entity: Producto (copiar patrón Usuario)
Endpoints: CRUD + búsquedas
```

### API de Pedidos
```
ArtifactId: pedidos-api
Entity: Pedido, DetallePedido
Endpoints: CRUD + relaciones
```

## 🎓 Próximos Pasos Después de Generar

1. ✅ **Ejecutar tests**: Verificar que todo funciona
2. ✅ **Revisar código**: Entender la estructura
3. ✅ **Probar endpoints**: Usar curl o Postman
4. ✅ **Agregar validaciones**: @NotNull, @Email, etc.
5. ✅ **Crear nuevas entidades**: Copiar patrón Usuario
6. ✅ **Configurar Git**: `git init` y primer commit
7. ✅ **Documentar API**: Considerar Swagger
8. ✅ **Agregar seguridad**: Spring Security cuando sea necesario

---

**¿Necesitas ayuda?** Consulta GUIA-USO-GENERADOR.md para ejemplos detallados.

**¡Éxito con tu proyecto! 🚀**
