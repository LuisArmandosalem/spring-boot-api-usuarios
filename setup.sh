#!/bin/bash

# Script de inicialización para nuevos desarrolladores

echo "🚀 Configurando proyecto Spring Boot - API de Usuarios"
echo "==============================================="

# Verificar Java
echo "📋 Verificando Java..."
java_version=$(java -version 2>&1 | grep -oP 'version "1\.\K\d+' || java -version 2>&1 | grep -oP 'version "\K\d+')
if [[ -z "$java_version" ]]; then
    echo "❌ Java no está instalado. Por favor instala Java 17."
    exit 1
elif [[ "$java_version" -lt 17 ]]; then
    echo "⚠️  Tienes Java $java_version. Se recomienda Java 17."
else
    echo "✅ Java $java_version detectado"
fi

# Verificar Maven
echo "📋 Verificando Maven..."
if ! command -v mvn &> /dev/null; then
    echo "❌ Maven no está instalado. El proyecto incluye Maven Wrapper (mvnw)"
    echo "   Puedes usar ./mvnw en lugar de mvn"
else
    echo "✅ Maven instalado: $(mvn -version | head -n1)"
fi

# Verificar PostgreSQL
echo "📋 Verificando PostgreSQL..."
if ! command -v psql &> /dev/null; then
    echo "⚠️  PostgreSQL no detectado en PATH"
    echo "   Asegúrate de tener PostgreSQL corriendo en puerto 5432"
else
    echo "✅ PostgreSQL detectado"
fi

# Configurar base de datos
echo ""
echo "🗄️  Configuración de Base de Datos"
echo "================================"
echo "Asegúrate de tener:"
echo "- PostgreSQL corriendo en puerto 5432"
echo "- Usuario: luis"
echo "- Password: 123"  
echo "- Base de datos: mi_proyecto_db"

echo ""
echo "Para crear la base de datos ejecuta:"
echo "createdb -U luis mi_proyecto_db"

# Compilar proyecto
echo ""
echo "🔨 Compilando proyecto..."
if [[ -f "./mvnw" ]]; then
    ./mvnw clean compile
else
    mvn clean compile
fi

if [[ $? -eq 0 ]]; then
    echo "✅ Compilación exitosa"
else
    echo "❌ Error en compilación"
    exit 1
fi

# Ejecutar tests
echo ""
echo "🧪 Ejecutando tests..."
if [[ -f "./mvnw" ]]; then
    ./mvnw test
else
    mvn test
fi

if [[ $? -eq 0 ]]; then
    echo "✅ Tests pasaron correctamente"
else
    echo "⚠️  Algunos tests fallaron"
fi

echo ""
echo "🎉 ¡Configuración completada!"
echo ""
echo "Para ejecutar la aplicación:"
echo "  ./start-app.sh"
echo ""
echo "Para probar la API:"
echo "  ./test-complete.sh"
echo ""
echo "La aplicación estará disponible en:"
echo "  http://localhost:8081"
echo ""
echo "Documentación API:"
echo "  GET    /api/usuarios        - Listar usuarios"
echo "  POST   /api/usuarios        - Crear usuario"
echo "  GET    /api/usuarios/{id}   - Obtener usuario"
echo "  PUT    /api/usuarios/{id}   - Actualizar usuario"
echo "  DELETE /api/usuarios/{id}   - Eliminar usuario"