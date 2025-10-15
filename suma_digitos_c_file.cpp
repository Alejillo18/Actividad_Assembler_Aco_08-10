#include <stdio.h>
#include <stdlib.h>

int main(void) {
    long long n;
    printf("Ingrese un numero entero (puede ser negativo): ");
    if (scanf("%lld", &n) != 1) {
        printf("Entrada invalida\n");
        return 1;
    }
    if (n < 0) n = -n;
    int suma = 0;
    while (n > 0) {
        suma += n % 10;
        n /= 10;
    }
    printf("La suma de los digitos es: %d\n", suma);
    return 0;
}
