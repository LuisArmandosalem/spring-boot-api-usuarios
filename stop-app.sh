#!/bin/bash

# Script simple para detener la aplicación Spring Boot

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PID_FILE="app.pid"

echo -e "${YELLOW}🛑 Deteniendo aplicación Spring Boot...${NC}"

# Detener usando el archivo PID
if [ -f "$PID_FILE" ]; then
    pid=$(cat "$PID_FILE")
    if ps -p $pid > /dev/null 2>&1; then
        kill $pid
        echo -e "${GREEN}✅ Aplicación detenida (PID: $pid)${NC}"
        rm -f "$PID_FILE"
    else
        echo -e "${YELLOW}⚠️  Proceso $pid ya no existe${NC}"
        rm -f "$PID_FILE"
    fi
else
    echo -e "${YELLOW}⚠️  No se encontró archivo PID${NC}"
fi

# Backup: detener cualquier proceso spring-boot:run restante
if pkill -f "spring-boot:run" 2>/dev/null; then
    echo -e "${GREEN}✅ Procesos Spring Boot adicionales detenidos${NC}"
fi

# Verificar que el puerto esté libre
sleep 1
if ! curl -s http://localhost:8081/api/usuarios > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Puerto 8081 liberado${NC}"
else
    echo -e "${YELLOW}⚠️  Algo sigue ejecutándose en puerto 8081${NC}"
fi

echo -e "${GREEN}🎉 Aplicación detenida completamente${NC}"