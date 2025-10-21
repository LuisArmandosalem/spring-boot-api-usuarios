#!/bin/bash

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🧪 PROBANDO MEJORAS DE LA ARQUITECTURA${NC}"
echo ""

# Función para mostrar respuesta JSON de forma bonita
show_response() {
    local response="$1"
    local description="$2"
    
    echo -e "${YELLOW}📋 $description${NC}"
    echo "$response" | jq . 2>/dev/null || echo "$response"
    echo ""
}

# 1. Probar creación de usuario válido
echo -e "${GREEN}✅ 1. Creando usuario válido...${NC}"
response=$(curl -s -X POST http://localhost:8081/api/usuarios \
    -H "Content-Type: application/json" \
    -d '{"nombre":"Ana García","email":"ana@test.com","telefono":"555-1234"}')
show_response "$response" "Usuario creado correctamente"

# 2. Probar error de email duplicado (debería devolver error estructurado)
echo -e "${RED}❌ 2. Intentando crear usuario con email duplicado...${NC}"
response=$(curl -s -X POST http://localhost:8081/api/usuarios \
    -H "Content-Type: application/json" \
    -d '{"nombre":"Ana Duplicate","email":"ana@test.com","telefono":"555-9999"}')
show_response "$response" "Error de email duplicado (respuesta estructurada)"

# 3. Probar validación de datos inválidos
echo -e "${RED}❌ 3. Intentando crear usuario con datos inválidos...${NC}"
response=$(curl -s -X POST http://localhost:8081/api/usuarios \
    -H "Content-Type: application/json" \
    -d '{"nombre":"","email":"email-invalido","telefono":"555-1111"}')
show_response "$response" "Error de validación (email inválido y nombre vacío)"

# 4. Probar búsqueda de usuario inexistente
echo -e "${RED}❌ 4. Buscando usuario inexistente...${NC}"
response=$(curl -s -X GET http://localhost:8081/api/usuarios/999)
show_response "$response" "Error de usuario no encontrado (ID: 999)"

# 5. Probar búsqueda con ID inválido
echo -e "${RED}❌ 5. Buscando con ID inválido...${NC}"
response=$(curl -s -X GET http://localhost:8081/api/usuarios/-1)
show_response "$response" "Error de ID inválido"

# 6. Probar actualización exitosa
echo -e "${GREEN}✅ 6. Actualizando usuario existente...${NC}"
response=$(curl -s -X PUT http://localhost:8081/api/usuarios/1 \
    -H "Content-Type: application/json" \
    -d '{"nombre":"Ana García Actualizada","email":"ana.updated@test.com","telefono":"555-5678"}')
show_response "$response" "Usuario actualizado correctamente"

# 7. Probar todas las validaciones del service
echo -e "${GREEN}✅ 7. Obteniendo todos los usuarios...${NC}"
response=$(curl -s -X GET http://localhost:8081/api/usuarios)
show_response "$response" "Lista de usuarios con las mejoras aplicadas"

# 8. Probar búsqueda por email
echo -e "${GREEN}✅ 8. Buscando por email...${NC}"
response=$(curl -s -X GET http://localhost:8081/api/usuarios/email/ana.updated@test.com)
show_response "$response" "Búsqueda por email (normalización aplicada)"

echo -e "${BLUE}🎉 PRUEBAS COMPLETADAS${NC}"
echo ""
echo -e "${YELLOW}🔍 MEJORAS IMPLEMENTADAS:${NC}"
echo -e "  ✅ Capa de servicio con lógica de negocio"
echo -e "  ✅ Excepciones personalizadas y estructuradas"
echo -e "  ✅ Manejo global de errores con JSON"
echo -e "  ✅ Validaciones mejoradas y normalizaciones"
echo -e "  ✅ Separación clara de responsabilidades"
echo -e "  ✅ Transacciones y mejores prácticas"
echo ""