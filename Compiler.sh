#!/bin/bash

# ============================================================================
# Script simple para compilar Godot (Editor + Template Release)
# ============================================================================

echo "=========================================="
echo "  COMPILANDO GODOT"
echo "=========================================="

# Verificar que Clang está instalado
if ! command -v clang++ &> /dev/null; then
    echo "ERROR: clang++ no está instalado"
    echo "Instálalo con: sudo apt-get install clang lld"
    exit 1
fi

echo "Usando compilador: $(clang++ --version | head -1)"

# Configuración común
export SCONS_FLAGS="platform=linuxbsd arch=x86_64 use_llvm=yes CC=clang CXX=clang++ -j4"

# Compilar el editor
echo -e "\n[1/2] Compilando el editor..."
scons target=editor $SCONS_FLAGS

if [ $? -ne 0 ]; then
    echo "ERROR: Falló la compilación del editor"
    exit 1
fi
echo "✓ Editor compilado correctamente"

# Compilar la plantilla de exportación
echo -e "\n[2/2] Compilando plantilla de exportación (template_release)..."
scons target=template_release $SCONS_FLAGS

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
