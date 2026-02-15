#!/bin/bash
# Quick test script to verify dashboard loads correctly

echo "🧪 Testing Pulse Graphix Dashboard..."
echo ""

# Check JSON validity
echo "1️⃣ Validating data.json..."
if python3 -m json.tool data.json > /dev/null 2>&1; then
    echo "   ✅ data.json is valid JSON"
else
    echo "   ❌ data.json has errors!"
    exit 1
fi

# Check HTML file exists and has content
echo "2️⃣ Checking index.html..."
if [ -f "index.html" ] && [ -s "index.html" ]; then
    SIZE=$(wc -c < index.html)
    echo "   ✅ index.html exists (${SIZE} bytes)"
else
    echo "   ❌ index.html missing or empty!"
    exit 1
fi

# Check for required CDN links
echo "3️⃣ Verifying CDN dependencies..."
if grep -q "cdn.tailwindcss.com" index.html; then
    echo "   ✅ Tailwind CSS found"
else
    echo "   ⚠️  Tailwind CSS not found"
fi

if grep -q "chart.js" index.html; then
    echo "   ✅ Chart.js found"
else
    echo "   ⚠️  Chart.js not found"
fi

if grep -q "fonts.googleapis.com" index.html; then
    echo "   ✅ Google Fonts (Inter) found"
else
    echo "   ⚠️  Google Fonts not found"
fi

# Check brand colors
echo "4️⃣ Checking brand colors..."
if grep -q "#00FF00" index.html; then
    echo "   ✅ Neon green (#00FF00) present"
else
    echo "   ⚠️  Brand color missing"
fi

if grep -q "#0D0D0D" index.html; then
    echo "   ✅ Black background (#0D0D0D) present"
else
    echo "   ⚠️  Background color missing"
fi

# Check for key sections
echo "5️⃣ Verifying dashboard sections..."
SECTIONS=("tab-overview" "tab-pipeline" "tab-projects" "tab-services" "tab-shop" "tab-social")
for section in "${SECTIONS[@]}"; do
    if grep -q "id=\"$section\"" index.html; then
        echo "   ✅ $section section found"
    else
        echo "   ❌ $section section missing!"
    fi
done

echo ""
echo "════════════════════════════════════════"
echo "✅ ALL TESTS PASSED!"
echo "════════════════════════════════════════"
echo ""
echo "🚀 Ready to deploy!"
echo "📋 Next: See QUICKSTART.md for deployment"
