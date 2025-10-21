#!/bin/bash

echo "📊 REPORTE DETALLADO DE COBERTURA POR CLASE"
echo "==========================================="
echo ""

# Verificar si existe el archivo CSV
if [ ! -f "target/site/jacoco/jacoco.csv" ]; then
    echo "❌ Error: No se encontró el reporte de cobertura."
    echo "Ejecuta: ./mvnw test primero"
    exit 1
fi

echo "📋 COBERTURA DETALLADA POR CLASE:"
echo "================================="
echo ""

# Procesar el archivo CSV (saltar header)
tail -n +2 target/site/jacoco/jacoco.csv | while IFS=',' read -r GROUP PACKAGE CLASS INSTRUCTION_MISSED INSTRUCTION_COVERED BRANCH_MISSED BRANCH_COVERED LINE_MISSED LINE_COVERED COMPLEXITY_MISSED COMPLEXITY_COVERED METHOD_MISSED METHOD_COVERED; do
    
    # Calcular porcentajes
    TOTAL_INSTRUCTIONS=$((INSTRUCTION_MISSED + INSTRUCTION_COVERED))
    TOTAL_LINES=$((LINE_MISSED + LINE_COVERED))
    TOTAL_METHODS=$((METHOD_MISSED + METHOD_COVERED))
    
    if [ $TOTAL_INSTRUCTIONS -gt 0 ]; then
        INSTRUCTION_PERCENT=$((INSTRUCTION_COVERED * 100 / TOTAL_INSTRUCTIONS))
    else
        INSTRUCTION_PERCENT=0
    fi
    
    if [ $TOTAL_LINES -gt 0 ]; then
        LINE_PERCENT=$((LINE_COVERED * 100 / TOTAL_LINES))
    else
        LINE_PERCENT=0
    fi
    
    if [ $TOTAL_METHODS -gt 0 ]; then
        METHOD_PERCENT=$((METHOD_COVERED * 100 / TOTAL_METHODS))
    else
        METHOD_PERCENT=0
    fi
    
    # Determinar emoji y color basado en cobertura de líneas
    if [ $LINE_PERCENT -ge 90 ]; then
        STATUS="✅ EXCELENTE"
    elif [ $LINE_PERCENT -ge 80 ]; then
        STATUS="🟢 BUENO    "
    elif [ $LINE_PERCENT -ge 70 ]; then
        STATUS="🟡 REGULAR  "
    else
        STATUS="🔴 MEJORAR  "
    fi
    
    # Mostrar resultado formateado
    printf "%-30s %s %3d%% líneas, %3d%% métodos, %3d%% instrucciones\n" \
        "$CLASS" "$STATUS" "$LINE_PERCENT" "$METHOD_PERCENT" "$INSTRUCTION_PERCENT"
done

echo ""
echo "�� LEYENDA:"
echo "==========="
echo "✅ EXCELENTE (≥90%)  🟢 BUENO (≥80%)  🟡 REGULAR (≥70%)  🔴 MEJORAR (<70%)"
echo ""

echo "📄 REPORTES DISPONIBLES:"
echo "========================"
echo "• 🌐 HTML (navegador): target/site/jacoco/index.html"
echo "• 📊 CSV (datos):      target/site/jacoco/jacoco.csv"  
echo "• 🔧 XML (CI/CD):      target/site/jacoco/jacoco.xml"
echo ""

echo "🚀 COMANDOS ÚTILES:"
echo "==================="
echo "• Ver reporte HTML: firefox target/site/jacoco/index.html"
echo "• Abrir en VS Code: code target/site/jacoco/index.html"
echo "• Ver este reporte: ./class-coverage-report.sh"
