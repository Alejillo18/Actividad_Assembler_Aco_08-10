#include <stdio.h>

int main() {
    int n;

    printf("Cuantos numeros Fibonacci quieres generar? ");
    scanf("%d", &n);

    if (n <= 0) {
        printf("Numero invalido.\n");
        return 0;
    }

    int fib[n];

    fib[0] = 0;
    if (n > 1) fib[1] = 1;

    for (int i = 2; i < n; i++) {
        fib[i] = fib[i - 2] + fib[i - 1];
    }

    printf("Fibonacci: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", fib[i]);
    }
    printf("\n");

    return 0;
}
