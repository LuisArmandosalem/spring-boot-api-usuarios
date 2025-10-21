#!/bin/bash

# Script para generar reporte de cobertura de código

echo "📊 REPORTE DE COBERTURA DE CÓDIGO"
echo "================================="
echo ""

# Verificar si existe el reporte
if [[ ! -f "target/site/jacoco/jacoco.csv" ]]; then
    echo "❌ No se encontró el reporte de cobertura."
    echo "   Ejecuta: ./mvnw test para generar el reporte"
    exit 1
fi

echo "📋 Resumen de cobertura por clase:"
echo ""

# Procesar el CSV y calcular métricas
while IFS=, read -r GROUP PACKAGE CLASS INSTRUCTION_MISSED INSTRUCTION_COVERED BRANCH_MISSED BRANCH_COVERED LINE_MISSED LINE_COVERED COMPLEXITY_MISSED COMPLEXITY_COVERED METHOD_MISSED METHOD_COVERED; do
    if [[ "$CLASS" != "CLASS" && "$CLASS" != "" ]]; then
        # Calcular porcentajes
        total_instructions=$((INSTRUCTION_MISSED + INSTRUCTION_COVERED))
        total_lines=$((LINE_MISSED + LINE_COVERED))
        total_methods=$((METHOD_MISSED + METHOD_COVERED))
        
        if [[ $total_instructions -gt 0 ]]; then
            instruction_coverage=$(( (INSTRUCTION_COVERED * 100) / total_instructions ))
        else
            instruction_coverage=0
        fi
        
        if [[ $total_lines -gt 0 ]]; then
            line_coverage=$(( (LINE_COVERED * 100) / total_lines ))
        else
            line_coverage=0
        fi
        
        if [[ $total_methods -gt 0 ]]; then
            method_coverage=$(( (METHOD_COVERED * 100) / total_methods ))
        else
            method_coverage=0
        fi
        
        # Determinar estado
        if [[ $line_coverage -ge 90 ]]; then
            status="✅ EXCELENTE"
        elif [[ $line_coverage -ge 80 ]]; then
            status="🟢 BUENO    "
        elif [[ $line_coverage -ge 70 ]]; then
            status="🟡 REGULAR  "
        else
            status="🔴 MEJORAR  "
        fi
        
        printf "%-30s %s %3d%% líneas, %3d%% métodos\n" "$CLASS" "$status" "$line_coverage" "$method_coverage"
    fi
done < target/site/jacoco/jacoco.csv

echo ""
echo "📈 Métricas Globales:"
echo "===================="

# Calcular totales
total_instruction_missed=0
total_instruction_covered=0
total_line_missed=0
total_line_covered=0
total_method_missed=0
total_method_covered=0

while IFS=, read -r GROUP PACKAGE CLASS INSTRUCTION_MISSED INSTRUCTION_COVERED BRANCH_MISSED BRANCH_COVERED LINE_MISSED LINE_COVERED COMPLEXITY_MISSED COMPLEXITY_COVERED METHOD_MISSED METHOD_COVERED; do
    if [[ "$CLASS" != "CLASS" && "$CLASS" != "" ]]; then
        total_instruction_missed=$((total_instruction_missed + INSTRUCTION_MISSED))
        total_instruction_covered=$((total_instruction_covered + INSTRUCTION_COVERED))
        total_line_missed=$((total_line_missed + LINE_MISSED))
        total_line_covered=$((total_line_covered + LINE_COVERED))
        total_method_missed=$((total_method_missed + METHOD_MISSED))
        total_method_covered=$((total_method_covered + METHOD_COVERED))
    fi
done < target/site/jacoco/jacoco.csv

total_instructions=$((total_instruction_missed + total_instruction_covered))
total_lines=$((total_line_missed + total_line_covered))
total_methods=$((total_method_missed + total_method_covered))

global_instruction_coverage=$(( (total_instruction_covered * 100) / total_instructions ))
global_line_coverage=$(( (total_line_covered * 100) / total_lines ))
global_method_coverage=$(( (total_method_covered * 100) / total_methods ))

echo "📊 Cobertura de Líneas:        $global_line_coverage% ($total_line_covered/$total_lines)"
echo "📊 Cobertura de Métodos:       $global_method_coverage% ($total_method_covered/$total_methods)"
echo "📊 Cobertura de Instrucciones: $global_instruction_coverage% ($total_instruction_covered/$total_instructions)"

echo ""
echo "🎯 RECOMENDACIONES PARA SONARQUBE:"
echo "=================================="

if [[ $global_line_coverage -ge 80 ]]; then
    echo "✅ Cobertura de líneas excelente para SonarQube (>80%)"
else
    echo "⚠️  Cobertura de líneas puede mejorar para SonarQube (objetivo: >80%)"
fi

if [[ $global_method_coverage -ge 90 ]]; then
    echo "✅ Cobertura de métodos excelente"
else
    echo "⚠️  Considera agregar más tests para métodos no cubiertos"
fi

echo ""
echo "📄 Reportes generados:"
echo "======================"
echo "• HTML: target/site/jacoco/index.html"
echo "• CSV:  target/site/jacoco/jacoco.csv"
echo "• XML:  target/site/jacoco/jacoco.xml"

echo ""
echo "🔧 Para mejorar la cobertura:"
echo "============================="
echo "1. Agregar tests para métodos no cubiertos"
echo "2. Incluir casos edge/error en tests existentes"
echo "3. Probar validaciones y manejo de excepciones"
echo "4. Agregar tests de integración para el Controller"