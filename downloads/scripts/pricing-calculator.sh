#!/bin/bash
# Pulse Graphix Pricing Calculator
# Quick quote generator for Kabundji

echo "=============================================="
echo "  💰 Pulse Graphix - Calculateur de Devis"
echo "=============================================="
echo ""

# Service catalog
declare -A SERVICES
SERVICES=(
    ["1"]="Site Vitrine WordPress|1500|3000"
    ["2"]="Site E-Commerce WooCommerce|3000|6000"
    ["3"]="Application Web React/Node|5000|15000"
    ["4"]="Application Android|4000|10000"
    ["5"]="Application Flutter|6000|15000"
    ["6"]="Workflow n8n|800|2500"
    ["7"]="Chatbot IA|1500|4000"
    ["8"]="Agent IA Support|2000|5000"
    ["9"]="Render 3dsmax/Revit|500|2000"
    ["10"]="Plan Architecture|800|3000"
    ["11"]="Logo/Branding|300|800"
    ["12"]="Refonte Site WordPress|800|2000"
)

echo "📋 Services disponibles:"
echo ""
printf "%-5s %-35s %-15s %-15s\n" "N°" "Service" "Prix min (€)" "Prix max (€)"
echo "--------------------------------------------------------------------------------"
for key in "${!SERVICES[@]}"; do
    IFS='|' read -r name min max <<< "${SERVICES[$key]}"
    printf "%-5s %-35s %-15s %-15s\n" "$key" "$name" "$min" "$max"
done

echo ""
echo "=============================================="
echo ""
echo "📝 Pour générer un devis rapide:"
echo ""
echo "   Usage: $0 [numéro_service] [complexité]"
echo ""
echo "   Complexité: simple (min) | standard (moyenne) | complexe (max)"
echo ""
echo "   Exemple: $0 2 standard"
echo "            → Devis Site E-Commerce: ~4,500€ HT"
echo ""

# If arguments provided, calculate
if [ $# -eq 2 ]; then
    service_num="$1"
    complexity="$2"
    
    if [ -z "${SERVICES[$service_num]}" ]; then
        echo "❌ Service non trouvé"
        exit 1
    fi
    
    IFS='|' read -r name min max <<< "${SERVICES[$service_num]}"
    
    # Calculate based on complexity
    case "$complexity" in
        simple) price=$min ;;
        standard) price=$(( (min + max) / 2 )) ;;
        complexe) price=$max ;;
        *) price=$(( (min + max) / 2 )) ;;
    esac
    
    # Add 20% as base range
    price_min=$(( price - price / 10 ))
    price_max=$(( price + price / 10 ))
    
    echo "=============================================="
    echo ""
    echo "📊 ESTIMATION RAPIDE"
    echo ""
    echo "   Service: $name"
    echo "   Complexité: $complexity"
    echo ""
    echo "   💵 Fourchette: $price_min € - $price_max € HT"
    echo "   💵 Estimation: ~$price € HT"
    echo "   💵 TVA 20%: $(( price * 12 / 10 )) € TTC"
    echo ""
    echo "=============================================="
fi

echo ""
echo "✅ Utilisez ce devis avec templates/devis-fr.html"
echo "=============================================="
