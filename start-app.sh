#!/bin/bash

# Script para iniciar la aplicación Spring Boot

echo "🚀 Iniciando API de Usuarios - Spring Boot"
echo "=========================================="

# Verificar si hay una instancia corriendo
if lsof -i :8081 >/dev/null 2>&1; then
    echo "⚠️  Puerto 8081 está ocupado"
    echo "   Ejecuta ./stop-app.sh para detener la aplicación anterior"
    exit 1
fi

# Verificar base de datos
echo "🗄️  Verificando conexión a PostgreSQL..."
if ! nc -z localhost 5432 2>/dev/null; then
    echo "❌ PostgreSQL no está disponible en puerto 5432"
    echo "   Asegúrate de que PostgreSQL esté corriendo"
    exit 1
fi

echo "✅ PostgreSQL detectado"

# Compilar si es necesario
echo ""
echo "🔨 Compilando proyecto..."
if [[ -f "./mvnw" ]]; then
    ./mvnw clean compile -q
else
    mvn clean compile -q
fi

if [[ $? -ne 0 ]]; then
    echo "❌ Error en compilación"
    exit 1
fi

echo "✅ Compilación exitosa"

# Iniciar aplicación
echo ""
echo "🎯 Iniciando aplicación..."
echo "   URL: http://localhost:8081"
echo "   API: http://localhost:8081/api/usuarios"
echo ""
echo "Para detener la aplicación:"
echo "   Ctrl+C o ejecuta ./stop-app.sh desde otra terminal"
echo ""

if [[ -f "./mvnw" ]]; then
    ./mvnw spring-boot:run
else
    mvn spring-boot:run
fi