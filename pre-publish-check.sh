#!/bin/bash

# Script de verificación pre-publicación para GitHub

echo "🔍 Verificación Pre-Publicación GitHub"
echo "======================================"

# Verificar archivos esenciales
echo ""
echo "📁 Verificando archivos esenciales..."

files=(
    "README.md"
    "CONTRIBUTING.md"
    "LICENSE"
    "CHANGELOG.md"
    "GITHUB_GUIDE.md"
    "TECHNICAL_DOCS.md"
    ".gitignore"
    ".editorconfig"
    "pom.xml"
    "src/main/java/com/ejemplo/mi_proyecto/MiProyectoApplication.java"
    "src/main/resources/application.properties"
)

missing_files=()
for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✅ $file"
    else
        echo "❌ $file (FALTANTE)"
        missing_files+=("$file")
    fi
done

# Verificar scripts
echo ""
echo "🔧 Verificando scripts..."

scripts=(
    "setup.sh"
    "start-app.sh"
    "stop-app.sh"
    "test-complete.sh"
    "test-improvements.sh"
    "pre-publish-check.sh"
)

for script in "${scripts[@]}"; do
    if [[ -f "$script" ]]; then
        if [[ -x "$script" ]]; then
            echo "✅ $script (ejecutable)"
        else
            echo "⚠️  $script (no ejecutable)"
            chmod +x "$script"
            echo "   → Permisos corregidos"
        fi
    else
        echo "❌ $script (FALTANTE)"
        missing_files+=("$script")
    fi
done

# Verificar estructura del proyecto
echo ""
echo "🏗️  Verificando estructura del proyecto..."

directories=(
    "src/main/java/com/ejemplo/mi_proyecto"
    "src/main/resources"
    "src/test/java/com/ejemplo/mi_proyecto"
    ".vscode"
)

for dir in "${directories[@]}"; do
    if [[ -d "$dir" ]]; then
        echo "✅ $dir/"
    else
        echo "❌ $dir/ (FALTANTE)"
    fi
done

# Verificar código Java
echo ""
echo "☕ Verificando archivos Java..."

java_files=(
    "src/main/java/com/ejemplo/mi_proyecto/MiProyectoApplication.java"
    "src/main/java/com/ejemplo/mi_proyecto/entity/Usuario.java"
    "src/main/java/com/ejemplo/mi_proyecto/repository/UsuarioRepository.java"
    "src/main/java/com/ejemplo/mi_proyecto/service/UsuarioService.java"
    "src/main/java/com/ejemplo/mi_proyecto/service/impl/UsuarioServiceImpl.java"
    "src/main/java/com/ejemplo/mi_proyecto/controller/UsuarioController.java"
    "src/main/java/com/ejemplo/mi_proyecto/exception/ResourceNotFoundException.java"
    "src/main/java/com/ejemplo/mi_proyecto/exception/DataConflictException.java"
    "src/main/java/com/ejemplo/mi_proyecto/exception/GlobalExceptionHandler.java"
    "src/main/java/com/ejemplo/mi_proyecto/dto/ErrorResponse.java"
)

for java_file in "${java_files[@]}"; do
    if [[ -f "$java_file" ]]; then
        echo "✅ $(basename "$java_file")"
    else
        echo "❌ $(basename "$java_file") (FALTANTE)"
        missing_files+=("$java_file")
    fi
done

# Verificar compilación
echo ""
echo "🔨 Verificando compilación..."
if [[ -f "./mvnw" ]]; then
    ./mvnw clean compile -q
else
    mvn clean compile -q
fi

if [[ $? -eq 0 ]]; then
    echo "✅ Compilación exitosa"
else
    echo "❌ Error en compilación"
fi

# Verificar tests
echo ""
echo "🧪 Verificando tests..."
if [[ -f "./mvnw" ]]; then
    ./mvnw test -q
else
    mvn test -q
fi

if [[ $? -eq 0 ]]; then
    echo "✅ Tests pasan correctamente"
else
    echo "⚠️  Algunos tests fallan (verificar antes de publicar)"
fi

# Verificar .gitignore
echo ""
echo "🙈 Verificando .gitignore..."
if grep -q "target/" .gitignore && grep -q "*.log" .gitignore; then
    echo "✅ .gitignore configurado correctamente"
else
    echo "⚠️  .gitignore puede necesitar ajustes"
fi

# Resumen final
echo ""
echo "📊 RESUMEN DE VERIFICACIÓN"
echo "=========================="

if [[ ${#missing_files[@]} -eq 0 ]]; then
    echo "✅ Todos los archivos esenciales presentes"
else
    echo "❌ Archivos faltantes: ${#missing_files[@]}"
    printf '   - %s\n' "${missing_files[@]}"
fi

# Verificar tamaño del proyecto
project_size=$(du -sh . | cut -f1)
echo "📏 Tamaño del proyecto: $project_size"

# Contar líneas de código
if command -v find &> /dev/null; then
    java_lines=$(find . -name "*.java" -exec wc -l {} \; | awk '{sum += $1} END {print sum}')
    echo "📝 Líneas de código Java: $java_lines"
fi

echo ""
echo "🚀 ESTADO PARA GITHUB"
echo "===================="

if [[ ${#missing_files[@]} -eq 0 ]]; then
    echo "🎉 ¡PROYECTO LISTO PARA PUBLICAR!"
    echo ""
    echo "Pasos siguientes:"
    echo "1. Crear repositorio en GitHub"
    echo "2. git init"
    echo "3. git add ."
    echo "4. git commit -m 'Initial commit: Complete Spring Boot API'"
    echo "5. git remote add origin <URL_DEL_REPO>"
    echo "6. git push -u origin main"
    echo ""
    echo "Ver GITHUB_GUIDE.md para instrucciones detalladas"
else
    echo "⚠️  REVISA LOS ARCHIVOS FALTANTES ANTES DE PUBLICAR"
fi