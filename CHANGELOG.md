# Changelog

Todos los cambios notables de este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Validaciones Bean Validation (próximamente)
- DTOs para mejor separación de datos (próximamente)

## [1.0.0] - 2025-10-20

### Added
- ✨ Implementación inicial de API REST con Spring Boot
- 🏗️ Arquitectura por capas (Controller, Service, Repository, Entity)
- 🗄️ Integración con PostgreSQL usando JPA/Hibernate
- ⚠️ Manejo global de excepciones con respuestas estructuradas
- 🔄 Capa de servicio con lógica de negocio y transacciones
- 📦 DTOs para respuestas de error estandarizadas
- 🎯 Endpoints CRUD completos para gestión de usuarios
- ✅ Validaciones de negocio (email único, campos obligatorios)
- 🔧 Scripts de automatización para desarrollo
- 📋 Normalización de datos (email en minúsculas)
- 🧪 Scripts de prueba automatizados
- 📚 Documentación completa con ejemplos

### Security
- 🛡️ Validación de entrada de datos
- 🔍 Prevención de emails duplicados
- ✨ Sanitización de datos de entrada

## [0.1.0] - 2025-10-20

### Added
- 🚀 Configuración inicial del proyecto Spring Boot
- 📁 Estructura básica de directorios
- 🗃️ Configuración de base de datos PostgreSQL
- 📊 Entidad Usuario con mapeo JPA
- 🔗 Repositorio básico con Spring Data JPA
- 🎮 Controlador REST inicial
- ⚙️ Configuración de application.properties

---

## Tipos de Cambios

- `Added` para nuevas funcionalidades
- `Changed` para cambios en funcionalidades existentes
- `Deprecated` para funcionalidades que serán removidas
- `Removed` para funcionalidades removidas
- `Fixed` para corrección de bugs
- `Security` para mejoras de seguridad