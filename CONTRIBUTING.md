# Guía de Contribución

## 🤝 Contribuyendo al Proyecto

¡Gracias por tu interés en contribuir! Este documento te guiará a través del proceso.

## 📋 Tabla de Contenidos

- [Código de Conducta](#código-de-conducta)
- [Cómo Contribuir](#cómo-contribuir)
- [Proceso de Pull Request](#proceso-de-pull-request)
- [Estándares de Código](#estándares-de-código)
- [Estructura de Commits](#estructura-de-commits)

## 📜 Código de Conducta

Este proyecto se adhiere a un código de conducta. Al participar, se espera que mantengas este código.

## 🚀 Cómo Contribuir

### Reportar Bugs

1. **Verifica** que el bug no haya sido reportado anteriormente
2. **Crea un issue** con:
   - Descripción clara del problema
   - Pasos para reproducir
   - Comportamiento esperado vs actual
   - Información del entorno (Java version, OS, etc.)

### Sugerir Features

1. **Crea un issue** describiendo:
   - El problema que resuelve
   - La solución propuesta
   - Alternativas consideradas

### Implementar Cambios

1. **Fork** el repositorio
2. **Crea** una rama desde `main`
3. **Implementa** tus cambios
4. **Escribe tests** si es necesario
5. **Ejecuta** las pruebas existentes
6. **Commit** siguiendo las convenciones
7. **Push** a tu fork
8. **Crea** un Pull Request

## 🔄 Proceso de Pull Request

### Antes de Crear el PR

- [ ] El código compila sin errores
- [ ] Todas las pruebas pasan
- [ ] Se agregaron tests para nueva funcionalidad
- [ ] La documentación está actualizada
- [ ] El código sigue los estándares del proyecto

### Descripción del PR

Incluye:
- **¿Qué cambia?** - Descripción clara de los cambios
- **¿Por qué?** - Justificación del cambio
- **¿Cómo probar?** - Instrucciones para verificar

### Proceso de Review

1. **Automated checks** deben pasar
2. **Code review** por al menos un maintainer
3. **Approval** requerido antes del merge
4. **Squash and merge** es la estrategia preferida

## 📏 Estándares de Código

### Java Code Style

```java
// ✅ Correcto
@Service
@Transactional
public class UsuarioServiceImpl implements UsuarioService {
    
    private final UsuarioRepository usuarioRepository;
    
    public UsuarioServiceImpl(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }
    
    @Override
    public Usuario crearUsuario(Usuario usuario) {
        // lógica aquí
    }
}
```

### Convenciones de Nombres

- **Clases**: `PascalCase` (ej: `UsuarioService`)
- **Métodos**: `camelCase` (ej: `crearUsuario`)
- **Variables**: `camelCase` (ej: `usuarioRepository`)
- **Constantes**: `UPPER_SNAKE_CASE` (ej: `MAX_LENGTH`)

### Documentación

- **JavaDoc** para clases públicas y métodos
- **Comentarios** para lógica compleja
- **README** actualizado para cambios significativos

## 📝 Estructura de Commits

### Formato

```
<tipo>(<scope>): <descripción>

<cuerpo opcional>

<footer opcional>
```

### Tipos

- **feat**: Nueva funcionalidad
- **fix**: Corrección de bug
- **docs**: Cambios en documentación
- **style**: Cambios de formato (sin afectar funcionalidad)
- **refactor**: Refactorización de código
- **test**: Agregar o modificar tests
- **chore**: Tareas de mantenimiento

### Ejemplos

```bash
feat(user): agregar validación de email único

- Implementar verificación en UsuarioService
- Agregar excepción DataConflictException
- Actualizar tests correspondientes

Closes #123
```

```bash
fix(api): corregir manejo de errores en controller

- Remover try-catch innecesario
- Delegar manejo a GlobalExceptionHandler
- Mejorar respuestas de error
```

## 🧪 Testing

### Ejecutar Tests

```bash
# Ejecutar todos los tests
mvn test

# Ejecutar con coverage
mvn test jacoco:report

# Tests de integración
mvn integration-test
```

### Escribir Tests

```java
@ExtendWith(MockitoExtension.class)
class UsuarioServiceTest {
    
    @Mock
    private UsuarioRepository usuarioRepository;
    
    @InjectMocks
    private UsuarioServiceImpl usuarioService;
    
    @Test
    void crearUsuario_ConDatosValidos_DeberiaCrearUsuario() {
        // Given
        Usuario usuario = new Usuario("Test", "test@example.com", "123");
        when(usuarioRepository.save(any())).thenReturn(usuario);
        
        // When
        Usuario resultado = usuarioService.crearUsuario(usuario);
        
        // Then
        assertThat(resultado.getNombre()).isEqualTo("Test");
    }
}
```

## 📦 Estructura de Features

Para nuevas funcionalidades grandes:

```
src/main/java/com/ejemplo/mi_proyecto/
├── controller/
│   └── NuevaFeatureController.java
├── service/
│   ├── NuevaFeatureService.java
│   └── impl/
│       └── NuevaFeatureServiceImpl.java
├── repository/
│   └── NuevaFeatureRepository.java
├── entity/
│   └── NuevaFeature.java
└── dto/
    ├── NuevaFeatureRequestDto.java
    └── NuevaFeatureResponseDto.java
```

## 🔍 Code Review Checklist

### Para el Author

- [ ] Código compilable y funcional
- [ ] Tests agregados/actualizados
- [ ] Documentación actualizada
- [ ] Sin hardcoded values
- [ ] Manejo apropiado de errores
- [ ] Siguiendo principios SOLID

### Para el Reviewer

- [ ] Lógica correcta y eficiente
- [ ] Seguridad considerada
- [ ] Rendimiento aceptable
- [ ] Mantenibilidad del código
- [ ] Consistencia con el resto del proyecto

## 📈 Proceso de Release

1. **Feature freeze** en rama `develop`
2. **Release branch** desde `develop`
3. **Testing** y bug fixes en release branch
4. **Merge** a `main` y tag de versión
5. **Deploy** a producción
6. **Merge back** a `develop`

## 🆘 Obteniendo Ayuda

- **Issues**: Para bugs y features
- **Discussions**: Para preguntas generales
- **Discord/Slack**: Chat en tiempo real (si disponible)
- **Email**: contacto directo con maintainers

## 🏆 Reconocimientos

Los contribuidores serán añadidos automáticamente al README en la sección de reconocimientos.

---

¡Gracias por contribuir! 🎉