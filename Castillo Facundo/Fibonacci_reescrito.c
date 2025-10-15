
#include <stdio.h>

#define SIZE 10

void PrintNumber(int num);

int main() {
    int fibArray[SIZE];

    // Primeros dos números de Fibonacci
    fibArray[0] = 0;
    fibArray[1] = 1;

    // Calcular los siguientes números
    for (int i = 2; i < SIZE; i++) {
        fibArray[i] = fibArray[i - 2] + fibArray[i - 1];
    }

    // Mostrar mensaje
    printf("Serie Fibonacci: ");

    // Mostrar todos los números usando la función
    for (int i = 0; i < SIZE; i++) {
        PrintNumber(fibArray[i]);
    }
    printf("\n");

    return 0;
}

// Función para imprimir un número con espacio
void PrintNumber(int num) {
    if (num == 0) {
        printf("0 ");
        return;
    }

    // Determinar los dígitos del número
    char buffer[6];
    int i = 5;
    buffer[i] = '\0';
    i--;

    int n = num;
    while (n > 0) {
        buffer[i] = (n % 10) + '0';
        n /= 10;
        i--;
    }

    printf("%s ", &buffer[i + 1]);
}
