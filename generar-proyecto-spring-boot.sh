#!/bin/bash

# Script para generar un proyecto Spring Boot con Maven para APIs REST
# Compatible con Java 11
# Autor: Script de generación automática
# Fecha: 2025

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes con color
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_header() {
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║   Generador de Proyecto Spring Boot Maven - Java 11         ║"
    echo "║   Para APIs REST con PostgreSQL                             ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Función para validar que Java esté instalado
validar_java() {
    print_info "Validando instalación de Java..."
    if ! command -v java &> /dev/null; then
        print_error "Java no está instalado. Por favor instala Java 11 o superior."
        exit 1
    fi
    
    java_version=$(java -version 2>&1 | grep -oP 'version "1\.\K\d+' || java -version 2>&1 | grep -oP 'version "\K\d+')
    if [[ -z "$java_version" ]]; then
        print_warning "No se pudo detectar la versión de Java, continuando de todos modos..."
    elif [[ "$java_version" -lt 11 ]]; then
        print_error "Se requiere Java 11 o superior. Versión actual: Java $java_version"
        exit 1
    else
        print_success "Java $java_version detectado"
    fi
}

# Función para validar que Maven esté instalado
validar_maven() {
    print_info "Validando instalación de Maven..."
    if ! command -v mvn &> /dev/null; then
        print_error "Maven no está instalado. Por favor instala Maven 3.6+ o usa Maven Wrapper."
        exit 1
    fi
    
    maven_version=$(mvn -version | head -n1)
    print_success "Maven detectado: $maven_version"
}

# Función para solicitar información del proyecto
solicitar_info_proyecto() {
    echo ""
    print_info "Configuración del Proyecto"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # GroupId
    read -p "GroupId (ej: com.ejemplo): " GROUP_ID
    GROUP_ID=${GROUP_ID:-com.ejemplo}
    
    # ArtifactId
    read -p "ArtifactId (ej: mi-api): " ARTIFACT_ID
    ARTIFACT_ID=${ARTIFACT_ID:-mi-api}
    
    # Nombre del paquete base
    read -p "Paquete base (ej: com.ejemplo.miapi): " BASE_PACKAGE
    BASE_PACKAGE=${BASE_PACKAGE:-${GROUP_ID}.${ARTIFACT_ID//-/}}
    
    # Nombre del proyecto
    read -p "Nombre del proyecto (ej: Mi API REST): " PROJECT_NAME
    PROJECT_NAME=${PROJECT_NAME:-"API REST con Spring Boot"}
    
    # Versión
    read -p "Versión inicial (default: 1.0.0): " VERSION
    VERSION=${VERSION:-1.0.0}
    
    # Puerto
    read -p "Puerto del servidor (default: 8080): " SERVER_PORT
    SERVER_PORT=${SERVER_PORT:-8080}
    
    # Configuración de PostgreSQL
    echo ""
    print_info "Configuración de Base de Datos PostgreSQL"
    read -p "Nombre de la base de datos (default: ${ARTIFACT_ID//-/_}_db): " DB_NAME
    DB_NAME=${DB_NAME:-${ARTIFACT_ID//-/_}_db}
    
    read -p "Usuario de PostgreSQL (default: postgres): " DB_USER
    DB_USER=${DB_USER:-postgres}
    
    read -p "Contraseña de PostgreSQL (default: postgres): " DB_PASSWORD
    DB_PASSWORD=${DB_PASSWORD:-postgres}
    
    read -p "Puerto de PostgreSQL (default: 5432): " DB_PORT
    DB_PORT=${DB_PORT:-5432}
    
    PROJECT_DIR="${ARTIFACT_ID}"
}

# Función para mostrar resumen
mostrar_resumen() {
    echo ""
    print_info "Resumen de Configuración"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "GroupId:          $GROUP_ID"
    echo "ArtifactId:       $ARTIFACT_ID"
    echo "Paquete Base:     $BASE_PACKAGE"
    echo "Nombre:           $PROJECT_NAME"
    echo "Versión:          $VERSION"
    echo "Puerto:           $SERVER_PORT"
    echo "Base de Datos:    $DB_NAME"
    echo "Usuario DB:       $DB_USER"
    echo "Puerto DB:        $DB_PORT"
    echo "Directorio:       $PROJECT_DIR"
    echo ""
    
    read -p "¿Continuar con la generación? (s/n): " CONFIRM
    if [[ ! "$CONFIRM" =~ ^[sS]$ ]]; then
        print_warning "Generación cancelada por el usuario"
        exit 0
    fi
}

# Función para crear estructura de directorios
crear_estructura() {
    print_info "Creando estructura de directorios..."
    
    mkdir -p "$PROJECT_DIR"
    cd "$PROJECT_DIR"
    
    # Convertir paquete a ruta
    PACKAGE_PATH=${BASE_PACKAGE//./\/}
    
    # Crear estructura Maven
    mkdir -p src/main/java/$PACKAGE_PATH/{controller,service,repository,entity,exception,dto,config}
    mkdir -p src/main/resources
    mkdir -p src/test/java/$PACKAGE_PATH
    mkdir -p src/test/resources
    
    print_success "Estructura de directorios creada"
}

# Función para crear pom.xml
crear_pom() {
    print_info "Generando pom.xml..."
    
    cat > pom.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.18</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    
    <groupId>${GROUP_ID}</groupId>
    <artifactId>${ARTIFACT_ID}</artifactId>
    <version>${VERSION}</version>
    <name>${PROJECT_NAME}</name>
    <description>API REST desarrollada con Spring Boot y Java 11</description>
    
    <properties>
        <java.version>11</java.version>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    
    <dependencies>
        <!-- Spring Boot Starter Web para APIs REST -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        
        <!-- Spring Boot Starter Data JPA para persistencia -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        
        <!-- PostgreSQL Driver -->
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <scope>runtime</scope>
        </dependency>
        
        <!-- Spring Boot Starter Validation -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        
        <!-- Lombok para reducir código boilerplate (opcional) -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>
        
        <!-- Spring Boot Starter Test -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        
        <!-- H2 Database para tests -->
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <!-- Spring Boot Maven Plugin -->
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
            
            <!-- Maven Compiler Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.10.1</version>
                <configuration>
                    <source>11</source>
                    <target>11</target>
                </configuration>
            </plugin>
            
            <!-- Maven Surefire Plugin para tests -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>2.22.2</version>
            </plugin>
        </plugins>
    </build>
</project>
EOF
    
    print_success "pom.xml generado"
}

# Función para crear application.properties
crear_application_properties() {
    print_info "Generando application.properties..."
    
    cat > src/main/resources/application.properties << EOF
# Configuración de la aplicación
spring.application.name=${ARTIFACT_ID}

# Configuración del servidor
server.port=${SERVER_PORT}

# Configuración de PostgreSQL
spring.datasource.url=jdbc:postgresql://localhost:${DB_PORT}/${DB_NAME}
spring.datasource.username=${DB_USER}
spring.datasource.password=${DB_PASSWORD}
spring.datasource.driver-class-name=org.postgresql.Driver

# Configuración de JPA/Hibernate
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# Configuración de logging
logging.level.root=INFO
logging.level.${BASE_PACKAGE}=DEBUG
logging.pattern.console=%d{yyyy-MM-dd HH:mm:ss} - %msg%n
EOF
    
    print_success "application.properties generado"
}

# Función para crear clase principal
crear_clase_principal() {
    print_info "Generando clase principal de la aplicación..."
    
    # Convertir artifact-id a CamelCase para nombre de clase (quitar guiones)
    CLASS_NAME=$(echo "$ARTIFACT_ID" | sed -r 's/(^|-)([a-z])/\U\2/g' | sed 's/-//g')
    CLASS_NAME="${CLASS_NAME}Application"
    
    cat > "src/main/java/$PACKAGE_PATH/${CLASS_NAME}.java" << EOF
package ${BASE_PACKAGE};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Clase principal de la aplicación Spring Boot
 * 
 * @SpringBootApplication habilita:
 * - @Configuration: Marca la clase como fuente de definiciones de beans
 * - @EnableAutoConfiguration: Habilita la configuración automática de Spring Boot
 * - @ComponentScan: Escanea componentes en el paquete actual y subpaquetes
 */
@SpringBootApplication
public class ${CLASS_NAME} {

    public static void main(String[] args) {
        SpringApplication.run(${CLASS_NAME}.class, args);
    }
}
EOF
    
    print_success "Clase principal generada: ${CLASS_NAME}.java"
}

# Función para crear entidad de ejemplo
crear_entidad_ejemplo() {
    print_info "Generando entidad de ejemplo (Usuario)..."
    
    cat > "src/main/java/$PACKAGE_PATH/entity/Usuario.java" << EOF
package ${BASE_PACKAGE}.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 * Entidad Usuario - Representa la tabla usuarios en la base de datos
 */
@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(unique = true, nullable = false, length = 100)
    private String email;

    @Column(length = 20)
    private String telefono;

    @Column(name = "fecha_creacion", nullable = false, updatable = false)
    private LocalDateTime fechaCreacion;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;

    @PrePersist
    protected void onCreate() {
        fechaCreacion = LocalDateTime.now();
        fechaActualizacion = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        fechaActualizacion = LocalDateTime.now();
    }

    // Constructor por defecto
    public Usuario() {
    }

    // Constructor con parámetros
    public Usuario(String nombre, String email, String telefono) {
        this.nombre = nombre;
        this.email = email;
        this.telefono = telefono;
    }

    // Getters y Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public LocalDateTime getFechaActualizacion() {
        return fechaActualizacion;
    }

    public void setFechaActualizacion(LocalDateTime fechaActualizacion) {
        this.fechaActualizacion = fechaActualizacion;
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", email='" + email + '\'' +
                ", telefono='" + telefono + '\'' +
                '}';
    }
}
EOF
    
    print_success "Entidad Usuario generada"
}

# Función para crear repositorio
crear_repositorio() {
    print_info "Generando repositorio..."
    
    cat > "src/main/java/$PACKAGE_PATH/repository/UsuarioRepository.java" << EOF
package ${BASE_PACKAGE}.repository;

import ${BASE_PACKAGE}.entity.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Repositorio para la entidad Usuario
 * JpaRepository proporciona métodos CRUD básicos
 */
@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    /**
     * Busca un usuario por su email
     * @param email Email del usuario
     * @return Optional con el usuario si existe
     */
    Optional<Usuario> findByEmail(String email);

    /**
     * Verifica si existe un usuario con el email dado
     * @param email Email a verificar
     * @return true si existe, false en caso contrario
     */
    boolean existsByEmail(String email);
}
EOF
    
    print_success "Repositorio generado"
}

# Función para crear servicio
crear_servicio() {
    print_info "Generando servicio..."
    
    # Interfaz del servicio
    cat > "src/main/java/$PACKAGE_PATH/service/UsuarioService.java" << EOF
package ${BASE_PACKAGE}.service;

import ${BASE_PACKAGE}.entity.Usuario;

import java.util.List;

/**
 * Interface del servicio de Usuario
 */
public interface UsuarioService {

    /**
     * Obtiene todos los usuarios
     * @return Lista de usuarios
     */
    List<Usuario> obtenerTodos();

    /**
     * Obtiene un usuario por su ID
     * @param id ID del usuario
     * @return Usuario encontrado
     */
    Usuario obtenerPorId(Long id);

    /**
     * Obtiene un usuario por su email
     * @param email Email del usuario
     * @return Usuario encontrado
     */
    Usuario obtenerPorEmail(String email);

    /**
     * Crea un nuevo usuario
     * @param usuario Usuario a crear
     * @return Usuario creado
     */
    Usuario crear(Usuario usuario);

    /**
     * Actualiza un usuario existente
     * @param id ID del usuario a actualizar
     * @param usuario Datos del usuario
     * @return Usuario actualizado
     */
    Usuario actualizar(Long id, Usuario usuario);

    /**
     * Elimina un usuario
     * @param id ID del usuario a eliminar
     */
    void eliminar(Long id);
}
EOF
    
    # Implementación del servicio
    cat > "src/main/java/$PACKAGE_PATH/service/UsuarioServiceImpl.java" << EOF
package ${BASE_PACKAGE}.service;

import ${BASE_PACKAGE}.entity.Usuario;
import ${BASE_PACKAGE}.exception.ResourceNotFoundException;
import ${BASE_PACKAGE}.exception.DataConflictException;
import ${BASE_PACKAGE}.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Implementación del servicio de Usuario
 */
@Service
@Transactional
public class UsuarioServiceImpl implements UsuarioService {

    private final UsuarioRepository usuarioRepository;

    public UsuarioServiceImpl(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Usuario> obtenerTodos() {
        return usuarioRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Usuario obtenerPorId(Long id) {
        return usuarioRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado con ID: " + id));
    }

    @Override
    @Transactional(readOnly = true)
    public Usuario obtenerPorEmail(String email) {
        return usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado con email: " + email));
    }

    @Override
    public Usuario crear(Usuario usuario) {
        // Validar que el email no esté duplicado
        if (usuarioRepository.existsByEmail(usuario.getEmail())) {
            throw new DataConflictException("Ya existe un usuario con el email: " + usuario.getEmail());
        }
        
        // Normalizar email
        usuario.setEmail(usuario.getEmail().toLowerCase().trim());
        
        return usuarioRepository.save(usuario);
    }

    @Override
    public Usuario actualizar(Long id, Usuario usuario) {
        Usuario usuarioExistente = obtenerPorId(id);
        
        // Validar email duplicado si cambió
        if (!usuarioExistente.getEmail().equals(usuario.getEmail()) 
                && usuarioRepository.existsByEmail(usuario.getEmail())) {
            throw new DataConflictException("Ya existe un usuario con el email: " + usuario.getEmail());
        }
        
        // Actualizar campos
        usuarioExistente.setNombre(usuario.getNombre());
        usuarioExistente.setEmail(usuario.getEmail().toLowerCase().trim());
        usuarioExistente.setTelefono(usuario.getTelefono());
        
        return usuarioRepository.save(usuarioExistente);
    }

    @Override
    public void eliminar(Long id) {
        Usuario usuario = obtenerPorId(id);
        usuarioRepository.delete(usuario);
    }
}
EOF
    
    print_success "Servicio generado"
}

# Función para crear controlador
crear_controlador() {
    print_info "Generando controlador REST..."
    
    cat > "src/main/java/$PACKAGE_PATH/controller/UsuarioController.java" << EOF
package ${BASE_PACKAGE}.controller;

import ${BASE_PACKAGE}.entity.Usuario;
import ${BASE_PACKAGE}.service.UsuarioService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controlador REST para gestión de usuarios
 */
@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    private final UsuarioService usuarioService;

    public UsuarioController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    /**
     * Obtiene todos los usuarios
     * @return Lista de usuarios
     */
    @GetMapping
    public ResponseEntity<List<Usuario>> obtenerTodos() {
        List<Usuario> usuarios = usuarioService.obtenerTodos();
        return ResponseEntity.ok(usuarios);
    }

    /**
     * Obtiene un usuario por su ID
     * @param id ID del usuario
     * @return Usuario encontrado
     */
    @GetMapping("/{id}")
    public ResponseEntity<Usuario> obtenerPorId(@PathVariable Long id) {
        Usuario usuario = usuarioService.obtenerPorId(id);
        return ResponseEntity.ok(usuario);
    }

    /**
     * Obtiene un usuario por su email
     * @param email Email del usuario
     * @return Usuario encontrado
     */
    @GetMapping("/email/{email}")
    public ResponseEntity<Usuario> obtenerPorEmail(@PathVariable String email) {
        Usuario usuario = usuarioService.obtenerPorEmail(email);
        return ResponseEntity.ok(usuario);
    }

    /**
     * Crea un nuevo usuario
     * @param usuario Usuario a crear
     * @return Usuario creado
     */
    @PostMapping
    public ResponseEntity<Usuario> crear(@RequestBody Usuario usuario) {
        Usuario usuarioCreado = usuarioService.crear(usuario);
        return ResponseEntity.status(HttpStatus.CREATED).body(usuarioCreado);
    }

    /**
     * Actualiza un usuario existente
     * @param id ID del usuario a actualizar
     * @param usuario Datos del usuario
     * @return Usuario actualizado
     */
    @PutMapping("/{id}")
    public ResponseEntity<Usuario> actualizar(@PathVariable Long id, @RequestBody Usuario usuario) {
        Usuario usuarioActualizado = usuarioService.actualizar(id, usuario);
        return ResponseEntity.ok(usuarioActualizado);
    }

    /**
     * Elimina un usuario
     * @param id ID del usuario a eliminar
     * @return Respuesta sin contenido
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        usuarioService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
EOF
    
    print_success "Controlador REST generado"
}

# Función para crear excepciones personalizadas
crear_excepciones() {
    print_info "Generando excepciones personalizadas..."
    
    # ResourceNotFoundException
    cat > "src/main/java/$PACKAGE_PATH/exception/ResourceNotFoundException.java" << EOF
package ${BASE_PACKAGE}.exception;

/**
 * Excepción lanzada cuando no se encuentra un recurso
 */
public class ResourceNotFoundException extends RuntimeException {

    public ResourceNotFoundException(String message) {
        super(message);
    }

    public ResourceNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}
EOF

    # DataConflictException
    cat > "src/main/java/$PACKAGE_PATH/exception/DataConflictException.java" << EOF
package ${BASE_PACKAGE}.exception;

/**
 * Excepción lanzada cuando hay un conflicto de datos (ej: duplicados)
 */
public class DataConflictException extends RuntimeException {

    public DataConflictException(String message) {
        super(message);
    }

    public DataConflictException(String message, Throwable cause) {
        super(message, cause);
    }
}
EOF

    # GlobalExceptionHandler
    cat > "src/main/java/$PACKAGE_PATH/exception/GlobalExceptionHandler.java" << EOF
package ${BASE_PACKAGE}.exception;

import ${BASE_PACKAGE}.dto.ErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Manejador global de excepciones
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleResourceNotFoundException(
            ResourceNotFoundException ex, WebRequest request) {
        
        ErrorResponse error = new ErrorResponse(
                LocalDateTime.now().format(FORMATTER),
                HttpStatus.NOT_FOUND.value(),
                "Not Found",
                ex.getMessage(),
                request.getDescription(false).replace("uri=", "")
        );
        
        return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(DataConflictException.class)
    public ResponseEntity<ErrorResponse> handleDataConflictException(
            DataConflictException ex, WebRequest request) {
        
        ErrorResponse error = new ErrorResponse(
                LocalDateTime.now().format(FORMATTER),
                HttpStatus.CONFLICT.value(),
                "Conflict",
                ex.getMessage(),
                request.getDescription(false).replace("uri=", "")
        );
        
        return new ResponseEntity<>(error, HttpStatus.CONFLICT);
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> handleIllegalArgumentException(
            IllegalArgumentException ex, WebRequest request) {
        
        ErrorResponse error = new ErrorResponse(
                LocalDateTime.now().format(FORMATTER),
                HttpStatus.BAD_REQUEST.value(),
                "Bad Request",
                ex.getMessage(),
                request.getDescription(false).replace("uri=", "")
        );
        
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGlobalException(
            Exception ex, WebRequest request) {
        
        ErrorResponse error = new ErrorResponse(
                LocalDateTime.now().format(FORMATTER),
                HttpStatus.INTERNAL_SERVER_ERROR.value(),
                "Internal Server Error",
                "Ha ocurrido un error inesperado",
                request.getDescription(false).replace("uri=", "")
        );
        
        return new ResponseEntity<>(error, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
EOF
    
    print_success "Excepciones personalizadas generadas"
}

# Función para crear DTO
crear_dto() {
    print_info "Generando DTOs..."
    
    cat > "src/main/java/$PACKAGE_PATH/dto/ErrorResponse.java" << EOF
package ${BASE_PACKAGE}.dto;

/**
 * DTO para respuestas de error
 */
public class ErrorResponse {

    private String timestamp;
    private int status;
    private String error;
    private String message;
    private String path;

    public ErrorResponse() {
    }

    public ErrorResponse(String timestamp, int status, String error, String message, String path) {
        this.timestamp = timestamp;
        this.status = status;
        this.error = error;
        this.message = message;
        this.path = path;
    }

    // Getters y Setters
    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
}
EOF
    
    print_success "DTOs generados"
}

# Función para crear configuración de tests
crear_test_properties() {
    print_info "Generando configuración de tests..."
    
    cat > src/test/resources/application.properties << EOF
# Configuración para tests - H2 en memoria
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=

spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=create-drop
spring.jpa.show-sql=false

# Deshabilitar logs durante tests
logging.level.root=WARN
logging.level.${BASE_PACKAGE}=INFO
EOF
    
    print_success "Configuración de tests generada"
}

# Función para crear test básico
crear_test() {
    print_info "Generando test básico..."
    
    CLASS_NAME=$(echo "$ARTIFACT_ID" | sed -r 's/(^|-)([a-z])/\U\2/g' | sed 's/-//g')
    CLASS_NAME="${CLASS_NAME}Application"
    
    cat > "src/test/java/$PACKAGE_PATH/${CLASS_NAME}Tests.java" << EOF
package ${BASE_PACKAGE};

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class ${CLASS_NAME}Tests {

    @Test
    void contextLoads() {
        // Este test verifica que el contexto de Spring Boot se carga correctamente
    }
}
EOF
    
    print_success "Test básico generado"
}

# Función para crear README
crear_readme() {
    print_info "Generando README.md..."
    
    cat > README.md << EOF
# ${PROJECT_NAME}

API REST desarrollada con Spring Boot y Java 11

## 🚀 Tecnologías

- **Java 11**
- **Spring Boot 2.7.18**
- **Spring Data JPA**
- **PostgreSQL**
- **Maven**

## 📋 Prerrequisitos

- Java 11 o superior
- Maven 3.6+
- PostgreSQL 12+

## 🔧 Configuración

### Base de Datos

1. Crear la base de datos en PostgreSQL:

\`\`\`sql
CREATE DATABASE ${DB_NAME};
\`\`\`

2. Configurar las credenciales en \`src/main/resources/application.properties\`

## 🏗️ Compilación

\`\`\`bash
mvn clean install
\`\`\`

## ▶️ Ejecución

\`\`\`bash
mvn spring-boot:run
\`\`\`

La aplicación estará disponible en: \`http://localhost:${SERVER_PORT}\`

## 📡 Endpoints

### Usuarios

- **GET** \`/api/usuarios\` - Obtener todos los usuarios
- **GET** \`/api/usuarios/{id}\` - Obtener usuario por ID
- **GET** \`/api/usuarios/email/{email}\` - Obtener usuario por email
- **POST** \`/api/usuarios\` - Crear nuevo usuario
- **PUT** \`/api/usuarios/{id}\` - Actualizar usuario
- **DELETE** \`/api/usuarios/{id}\` - Eliminar usuario

## 📝 Ejemplo de uso

### Crear usuario

\`\`\`bash
curl -X POST http://localhost:${SERVER_PORT}/api/usuarios \\
  -H "Content-Type: application/json" \\
  -d '{
    "nombre": "Juan Pérez",
    "email": "juan@example.com",
    "telefono": "123456789"
  }'
\`\`\`

### Obtener todos los usuarios

\`\`\`bash
curl http://localhost:${SERVER_PORT}/api/usuarios
\`\`\`

## 🏛️ Arquitectura

El proyecto sigue una arquitectura en capas:

- **Controller**: Maneja las peticiones HTTP
- **Service**: Contiene la lógica de negocio
- **Repository**: Acceso a datos
- **Entity**: Modelos de datos
- **Exception**: Manejo de errores
- **DTO**: Objetos de transferencia de datos

## 🧪 Tests

\`\`\`bash
mvn test
\`\`\`

## 📦 Dependencias Principales

- \`spring-boot-starter-web\`: Para crear APIs REST
- \`spring-boot-starter-data-jpa\`: Para persistencia con JPA
- \`postgresql\`: Driver de PostgreSQL
- \`spring-boot-starter-validation\`: Para validaciones
- \`lombok\`: Para reducir código boilerplate

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.
EOF
    
    print_success "README.md generado"
}

# Función para crear .gitignore
crear_gitignore() {
    print_info "Generando .gitignore..."
    
    cat > .gitignore << EOF
# Compiled class files
*.class

# Log files
*.log

# Package Files
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar

# Maven
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.next
release.properties
dependency-reduced-pom.xml
buildNumber.properties
.mvn/timing.properties
.mvn/wrapper/maven-wrapper.jar

# Eclipse
.project
.classpath
.settings/
.metadata
bin/
tmp/
*.tmp
*.bak
*.swp
*~.nib

# IntelliJ IDEA
.idea/
*.iws
*.iml
*.ipr
out/

# NetBeans
nbproject/private/
nbbuild/
dist/
nbdist/
.nb-gradle/

# VS Code
.vscode/

# OS Files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Application
application-local.properties
EOF
    
    print_success ".gitignore generado"
}

# Función para inicializar repositorio git (opcional)
inicializar_git() {
    if command -v git &> /dev/null; then
        print_info "¿Deseas inicializar un repositorio Git? (s/n): "
        read -p "" INIT_GIT
        if [[ "$INIT_GIT" =~ ^[sS]$ ]]; then
            git init
            git add .
            git commit -m "Proyecto inicial generado con script Maven Spring Boot"
            print_success "Repositorio Git inicializado"
        fi
    fi
}

# Función para compilar el proyecto
compilar_proyecto() {
    print_info "¿Deseas compilar el proyecto ahora? (s/n): "
    read -p "" COMPILE
    if [[ "$COMPILE" =~ ^[sS]$ ]]; then
        print_info "Compilando proyecto..."
        mvn clean compile
        if [[ $? -eq 0 ]]; then
            print_success "Compilación exitosa"
        else
            print_error "Error en la compilación"
        fi
    fi
}

# Función para mostrar instrucciones finales
mostrar_instrucciones_finales() {
    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║           ¡Proyecto generado exitosamente! 🎉               ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    print_success "Ubicación: $(pwd)"
    echo ""
    echo "📋 Próximos pasos:"
    echo ""
    echo "1. Navegar al directorio del proyecto:"
    echo "   cd $PROJECT_DIR"
    echo ""
    echo "2. Asegurarte de que PostgreSQL esté corriendo y crear la base de datos:"
    echo "   createdb -U ${DB_USER} ${DB_NAME}"
    echo ""
    echo "3. Compilar el proyecto:"
    echo "   mvn clean compile"
    echo ""
    echo "4. Ejecutar la aplicación:"
    echo "   mvn spring-boot:run"
    echo ""
    echo "5. Probar la API:"
    echo "   curl http://localhost:${SERVER_PORT}/api/usuarios"
    echo ""
    echo "📚 Documentación:"
    echo "   - README.md: Información general del proyecto"
    echo "   - application.properties: Configuración de la aplicación"
    echo ""
    echo "🌐 La API estará disponible en: http://localhost:${SERVER_PORT}"
    echo ""
}

# ============================================================
# EJECUCIÓN PRINCIPAL
# ============================================================

main() {
    print_header
    
    # Validaciones
    validar_java
    validar_maven
    
    # Solicitar información
    solicitar_info_proyecto
    mostrar_resumen
    
    # Crear proyecto
    crear_estructura
    crear_pom
    crear_application_properties
    crear_clase_principal
    crear_entidad_ejemplo
    crear_repositorio
    crear_servicio
    crear_controlador
    crear_excepciones
    crear_dto
    crear_test_properties
    crear_test
    crear_readme
    crear_gitignore
    
    # Opcionales
    inicializar_git
    compilar_proyecto
    
    # Instrucciones finales
    mostrar_instrucciones_finales
}

# Ejecutar script
main "$@"
