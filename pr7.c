#include <stdio.h>

int main() {
    int m, q;  // multiplicand and multiplier
    printf("Enter multiplicand (M): ");
    scanf("%d", &m);
    
    printf("Enter multiplier (Q): ");
    scanf("%d", &q);

    int n = 8;        // number of bits
    int A = 0;        // accumulator
    int Q = q;
    int M = m;
    int Q_1 = 0;      // Q-1
    int count = n;

    printf("\n--- Booth's Algorithm Steps ---\n");

    while (count > 0) {
        int Q0 = Q & 1;  // last bit of Q

        // Step 1: check (Q0, Q-1)
        if (Q0 == 0 && Q_1 == 1) {
            A = A + M;   // A = A + M
            printf("A = A + M → %d\n", A);
        } 
        else if (Q0 == 1 && Q_1 == 0) {
            A = A - M;   // A = A - M
            printf("A = A - M → %d\n", A);
        }

        // Step 2: Arithmetic Right Shift (A, Q, Q-1)
        int combined = (A << (n + 1)) | ((Q & ((1 << n) - 1)) << 1) | Q_1;
        combined >>= 1;

        // extract new values of A, Q, Q-1
        Q_1 = combined & 1;
        Q = (combined >> 1) & ((1 << n) - 1);
        A = combined >> (n + 1);

        printf("After shift → A: %d  Q: %d  Q-1: %d\n", A, Q, Q_1);

        count--;
    }

    int result = (A << n) | (Q & ((1 << n) - 1));
    printf("\nFinal Result (M * Q): %d\n", result);

    return 0;
}