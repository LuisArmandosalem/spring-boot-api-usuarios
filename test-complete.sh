#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Archivo para guardar el PID
PID_FILE="app.pid"

# Función para detener la aplicación
stop_app() {
    echo -e "${YELLOW}� Deteniendo aplicación...${NC}"
    
    # Leer PID del archivo si existe
    if [ -f "$PID_FILE" ]; then
        local pid=$(cat "$PID_FILE")
        if ps -p $pid > /dev/null 2>&1; then
            kill $pid
            echo -e "${GREEN}✅ Aplicación detenida (PID: $pid)${NC}"
        else
            echo -e "${YELLOW}⚠️  El proceso ya no existe${NC}"
        fi
        rm -f "$PID_FILE"
    fi
    
    # Backup: detener cualquier proceso spring-boot:run
    pkill -f "spring-boot:run" 2>/dev/null
    echo -e "${GREEN}✅ Todos los procesos Spring Boot detenidos${NC}"
}

# Función para verificar si la app está corriendo
is_app_running() {
    curl -s http://localhost:8081/api/usuarios > /dev/null 2>&1
    return $?
}

# Función para mostrar el estado
show_status() {
    if [ -f "$PID_FILE" ]; then
        local pid=$(cat "$PID_FILE")
        if ps -p $pid > /dev/null 2>&1; then
            echo -e "${GREEN}✅ Aplicación ejecutándose (PID: $pid)${NC}"
            if is_app_running; then
                echo -e "${GREEN}🌐 API respondiendo en http://localhost:8081${NC}"
            else
                echo -e "${YELLOW}⚠️  Proceso existe pero API no responde${NC}"
            fi
        else
            echo -e "${RED}❌ Proceso no encontrado${NC}"
            rm -f "$PID_FILE"
        fi
    else
        if is_app_running; then
            echo -e "${YELLOW}⚠️  API respondiendo pero sin archivo PID${NC}"
        else
            echo -e "${RED}❌ Aplicación no está ejecutándose${NC}"
        fi
    fi
}

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}🚀 Script de gestión de API Spring Boot${NC}"
    echo ""
    echo -e "${YELLOW}Uso:${NC}"
    echo -e "  ./test-complete.sh          # Ejecutar tests completos"
    echo -e "  ./test-complete.sh start    # Solo iniciar aplicación"
    echo -e "  ./test-complete.sh stop     # Detener aplicación"
    echo -e "  ./test-complete.sh status   # Ver estado"
    echo -e "  ./test-complete.sh logs     # Ver logs"
    echo -e "  ./test-complete.sh help     # Mostrar esta ayuda"
}

# Procesar argumentos de línea de comandos
case "$1" in
    "stop")
        stop_app
        exit 0
        ;;
    "status")
        show_status
        exit 0
        ;;
    "logs")
        if [ -f "app.log" ]; then
            echo -e "${BLUE}📋 Mostrando logs... (Ctrl+C para salir)${NC}"
            tail -f app.log
        else
            echo -e "${RED}❌ No se encontró el archivo app.log${NC}"
        fi
        exit 0
        ;;
    "help"|"-h"|"--help")
        show_help
        exit 0
        ;;
    "start")
        START_ONLY=true
        ;;
    "")
        START_ONLY=false
        ;;
    *)
        echo -e "${RED}❌ Opción desconocida: $1${NC}"
        show_help
        exit 1
        ;;
esac

# Manejar Ctrl+C
trap 'echo -e "\n${YELLOW}🚪 Saliendo...${NC}"; stop_app; exit 0' INT

echo -e "${BLUE}� Iniciando aplicación Spring Boot...${NC}"
cd /mnt/juegos1/Desarrollos/Java/Spring/mi-proyecto

# Detener cualquier aplicación previa
stop_app

# Iniciar la aplicación en background
mvn spring-boot:run > app.log 2>&1 &
APP_PID=$!

# Guardar PID en archivo
echo $APP_PID > "$PID_FILE"

echo -e "${YELLOW}⏳ Esperando que la aplicación inicie...${NC}"

# Esperar hasta que la aplicación responda (máximo 30 segundos)
counter=0
max_attempts=30

while ! is_app_running && [ $counter -lt $max_attempts ]; do
    sleep 1
    counter=$((counter + 1))
    echo -n "."
done

echo ""

if is_app_running; then
    echo -e "${GREEN}✅ Aplicación iniciada correctamente en http://localhost:8081${NC}"
    echo -e "${BLUE}📁 PID guardado en: $PID_FILE${NC}"
else
    echo -e "${RED}❌ Error: La aplicación no responde después de $max_attempts segundos${NC}"
    stop_app
    exit 1
fi

echo ""
echo -e "${BLUE}=== 🧪 PROBANDO LA API REST ===${NC}"
echo ""

# Si solo queremos iniciar, salir aquí
if [ "$START_ONLY" = true ]; then
    echo -e "${GREEN}✅ Aplicación iniciada correctamente${NC}"
    echo -e "${BLUE}💡 Usa './test-complete.sh status' para ver el estado${NC}"
    echo -e "${BLUE}💡 Usa './test-complete.sh stop' para detener${NC}"
    exit 0
fi

echo ""
echo "1️⃣ Obteniendo todos los usuarios:"
curl -s -X GET http://localhost:8081/api/usuarios | jq . || curl -s -X GET http://localhost:8081/api/usuarios
echo ""

echo ""
echo "2️⃣ Creando un nuevo usuario:"
RESPONSE=$(curl -s -X POST http://localhost:8081/api/usuarios \
     -H "Content-Type: application/json" \
     -d '{"nombre":"Juan Pérez","email":"juan@example.com","telefono":"123-456-7890"}')
echo $RESPONSE | jq . 2>/dev/null || echo $RESPONSE
echo ""

echo ""
echo "3️⃣ Obteniendo todos los usuarios después de crear uno:"
curl -s -X GET http://localhost:8081/api/usuarios | jq . 2>/dev/null || curl -s -X GET http://localhost:8081/api/usuarios
echo ""

echo ""
echo "4️⃣ Buscando usuario por email:"
curl -s -X GET http://localhost:8081/api/usuarios/email/juan@example.com | jq . 2>/dev/null || curl -s -X GET http://localhost:8081/api/usuarios/email/juan@example.com
echo ""

echo ""
echo "5️⃣ Creando otro usuario:"
RESPONSE2=$(curl -s -X POST http://localhost:8081/api/usuarios \
     -H "Content-Type: application/json" \
     -d '{"nombre":"María García","email":"maria@example.com","telefono":"987-654-3210"}')
echo $RESPONSE2 | jq . 2>/dev/null || echo $RESPONSE2
echo ""

echo ""
echo "6️⃣ Lista final de usuarios:"
curl -s -X GET http://localhost:8081/api/usuarios | jq . 2>/dev/null || curl -s -X GET http://localhost:8081/api/usuarios
echo ""

echo ""
echo -e "${GREEN}🎉 Pruebas completadas!${NC}"
echo -e "${BLUE}📝 La aplicación sigue ejecutándose en http://localhost:8081${NC}"
echo -e "${BLUE}📋 Logs de la aplicación: app.log${NC}"
echo -e "${BLUE}� PID guardado en: $PID_FILE${NC}"
echo ""
echo -e "${YELLOW}🛠️  COMANDOS ÚTILES:${NC}"
echo -e "${GREEN}   ./test-complete.sh stop    ${NC}# Detener la aplicación"
echo -e "${GREEN}   ./test-complete.sh status  ${NC}# Ver estado de la aplicación"
echo -e "${GREEN}   tail -f app.log            ${NC}# Ver logs en tiempo real"
echo -e "${GREEN}   Ctrl+C                     ${NC}# Detener desde este script"
echo ""
echo -e "${BLUE}📚 Endpoints disponibles:${NC}"
echo -e "   ${GREEN}GET${NC}    http://localhost:8081/api/usuarios"
echo -e "   ${GREEN}POST${NC}   http://localhost:8081/api/usuarios"
echo -e "   ${GREEN}GET${NC}    http://localhost:8081/api/usuarios/{id}"
echo -e "   ${GREEN}PUT${NC}    http://localhost:8081/api/usuarios/{id}"
echo -e "   ${GREEN}DELETE${NC} http://localhost:8081/api/usuarios/{id}"
echo -e "   ${GREEN}GET${NC}    http://localhost:8081/api/usuarios/email/{email}"

# Preguntar si quiere detener la aplicación
echo ""
echo -e "${YELLOW}¿Qué quieres hacer ahora?${NC}"
echo -e "1) Mantener aplicación ejecutándose"
echo -e "2) Detener aplicación"
echo -e "3) Ver logs en tiempo real"
read -p "Selecciona una opción (1-3): " choice

case $choice in
    2)
        stop_app
        ;;
    3)
        echo -e "${BLUE}📋 Mostrando logs... (Ctrl+C para salir)${NC}"
        tail -f app.log
        ;;
    *)
        echo -e "${GREEN}✅ Aplicación manteniéndose ejecutando${NC}"
        echo -e "${YELLOW}💡 Usa: ./test-complete.sh stop para detenerla${NC}"
        ;;
esac