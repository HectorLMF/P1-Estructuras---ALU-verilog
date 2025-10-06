# Práctica 1: ALU de 4 bits en Verilog

Este proyecto implementa una ALU de 4 bits en Verilog, siguiendo la estructura modular propuesta en la asignatura "Estructura de Computadores". Cada módulo está documentado y acompañado de su testbench correspondiente en la carpeta `testbench/`.

## Estructura de módulos

### 1. mux4_1.v
Multiplexor de 4 entradas y una salida de 1 bit. Selecciona una de las cuatro entradas según el selector de 2 bits `S`.

### 2. cl.v
Celda lógica. Realiza operaciones AND, OR, XOR y NOT sobre dos bits de entrada `a` y `b`, según el selector `S`.

### 3. ul4.v
Unidad lógica de 4 bits. Usa 4 instancias de `cl` para operar bit a bit sobre dos operandos de 4 bits.

### 4. fa.v
Full-Adder de 1 bit. Calcula la suma y el acarreo de tres bits de entrada usando el operador de concatenación.

### 5. sum4.v
Sumador completo de 4 bits. Usa 4 instancias de `fa` para sumar dos operandos de 4 bits y un acarreo de entrada.

### 6. sum4_v2.v
Sumador alternativo de 4 bits. Implementa la suma usando asignación continua y el operador de concatenación, sin instancias de `fa`.

### 7. mux2_4.v
Multiplexor de 2 entradas de 4 bits. Selecciona entre los operandos `A` y `B` según el selector `s`.

### 8. compl1.v
Complementador a 1 de 4 bits. Si `cpl` es 1, invierte todos los bits del operando; si es 0, lo deja sin modificar.

### 9. preprocess.v
Preprocesador de operandos. Modifica los operandos `A` y `B` según la operación seleccionada por `Op` para permitir operaciones aritméticas y lógicas avanzadas.

### 10. alu.v
Módulo principal de la ALU. Une todos los componentes, selecciona la operación a realizar y genera los flags de resultado (`zero`, `carry`, `sign`).

## Testbenches
Todos los testbenches se encuentran en la carpeta `testbench/` y permiten verificar el funcionamiento de cada módulo de forma independiente.

## Ejecución de pruebas
Para compilar y ejecutar los testbenches, utiliza los siguientes comandos en la terminal:

```
iverilog -o alu_tb testbench/alu_tb.v alu.v preprocess.v compl1.v sum4.v ul4.v mux2_4.v cl.v mux4_1.v fa.v && vvp alu_tb
```

Repite el proceso para los demás testbenches cambiando el nombre del archivo principal y el testbench correspondiente.

## Autor
Práctica realizada para la asignatura Estructura de Computadores.
