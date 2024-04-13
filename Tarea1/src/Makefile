# Makefile para compilar y ejecutar comandos de Verilog y visualizar la simulación en GTKWave

# Definición de variables
VERILOG_FILE = Testbench.v
OUTPUT_VVP = salida.vvp
VCD_FILE = testbench.vcd

# Regla por defecto para compilar, simular y visualizar
all: compile simulate view

# Regla para compilar el archivo Verilog
compile:
	iverilog -o $(OUTPUT_VVP) $(VERILOG_FILE)

# Regla para simular el diseño
simulate:
	vvp $(OUTPUT_VVP)

# Regla para visualizar la simulación en GTKWave
view:
	gtkwave $(VCD_FILE)

# Regla para limpiar archivos temporales
clean:
	rm -f $(OUTPUT_VVP) $(VCD_FILE)
