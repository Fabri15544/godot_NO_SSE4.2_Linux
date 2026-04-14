#!/bin/bash

# ============================================================================
# Script simple para compilar Godot (Editor + Template Release)
# ============================================================================

echo "=========================================="
echo "  COMPILANDO GODOT"
echo "=========================================="

# Compilar el editor
echo -e "\n[1/2] Compilando el editor..."
scons platform=linuxbsd target=editor arch=x86_64 use_llvm=yes -j4

# Verificar si el editor se compiló correctamente
if [ $? -ne 0 ]; then
    echo "ERROR: Falló la compilación del editor"
    exit 1
fi
echo "✓ Editor compilado correctamente"

# Compilar la plantilla de exportación
echo -e "\n[2/2] Compilando plantilla de exportación (template_release)..."
scons platform=linuxbsd target=template_release arch=x86_64 use_llvm=yes -j4

# Verificar si la plantilla se compiló correctamente
if [ $? -ne 0 ]; then
    echo "ERROR: Falló la compilación de la plantilla"
    exit 1
fi
echo "✓ Plantilla compilada correctamente"

# Mostrar resultados
echo -e "\n=========================================="
echo "  ¡COMPILACIÓN COMPLETADA CON ÉXITO!"
echo "=========================================="
echo ""
echo "Archivos generados:"
echo "  • Editor: bin/godot.linuxbsd.editor.x86_64.llvm"
echo "  • Plantilla: bin/godot.linuxbsd.template_release.x86_64.llvm"
echo ""
echo "Para ejecutar el editor:"
echo "  ./bin/godot.linuxbsd.editor.x86_64.llvm"
echo ""
