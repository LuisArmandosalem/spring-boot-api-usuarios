#!/bin/bash

echo "=== API de Usuarios - Guía de Prueba ==="
echo ""
echo "✅ La aplicación está ejecutándose en: http://localhost:8081"
echo ""
echo "=== Endpoints disponibles ==="
echo ""
echo "1. Obtener todos los usuarios:"
echo "   curl -X GET http://localhost:8081/api/usuarios"
echo ""
echo "2. Crear un nuevo usuario:"
echo '   curl -X POST http://localhost:8081/api/usuarios \
     -H "Content-Type: application/json" \
     -d "{\"nombre\":\"Juan Pérez\",\"email\":\"juan@example.com\",\"telefono\":\"123-456-7890\"}"'
echo ""
echo "3. Obtener usuario por ID (reemplaza {id} con el ID real):"
echo "   curl -X GET http://localhost:8081/api/usuarios/1"
echo ""
echo "4. Buscar usuario por email:"
echo "   curl -X GET http://localhost:8081/api/usuarios/email/juan@example.com"
echo ""
echo "5. Actualizar usuario (reemplaza {id} con el ID real):"
echo '   curl -X PUT http://localhost:8081/api/usuarios/1 \
     -H "Content-Type: application/json" \
     -d "{\"nombre\":\"Juan Carlos Pérez\",\"email\":\"juan.carlos@example.com\",\"telefono\":\"123-456-7891\"}"'
echo ""
echo "6. Eliminar usuario (reemplaza {id} con el ID real):"
echo "   curl -X DELETE http://localhost:8081/api/usuarios/1"
echo ""