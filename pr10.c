#include <stdio.h>

int main() {
    int pages[50], frames[10];
    int n, f;

    printf("Enter number of pages: ");
    scanf("%d", &n);

    printf("Enter pages: ");
    for (int i = 0; i < n; i++) {
        scanf("%d", &pages[i]);
    }

    printf("Enter number of frames: ");
    scanf("%d", &f);

    int faults, hits;



    /* ===================== FIFO ===================== */
    for (int i = 0; i < f; i++) {
        frames[i] = -1;
    }

    int index = 0;
    faults = 0;
    hits = 0;

    printf("\n\n--- FIFO ---\n");

    for (int i = 0; i < n; i++) {

        int found = 0;
        for (int j = 0; j < f; j++) {
            if (frames[j] == pages[i]) {
                found = 1;
                hits++;
                break;
            }
        }

        if (!found) {
            frames[index] = pages[i];
            index = (index + 1) % f;
            faults++;
        }

        for (int j = 0; j < f; j++) {
            printf("%d ", frames[j]);
        }
        printf("\n");
    }

    float fifo_ratio = (float)hits / n;
    printf("FIFO Faults = %d, Hits = %d, Hit Ratio = %.2f\n",
           faults, hits, fifo_ratio);



    /* ===================== LRU ======================= */
    for (int i = 0; i < f; i++) {
        frames[i] = -1;
    }

    int recent[10] = {0};
    faults = 0;
    hits = 0;

    printf("\n\n--- LRU ---\n");

    for (int i = 0; i < n; i++) {

        int found = -1;
        for (int j = 0; j < f; j++) {
            if (frames[j] == pages[i]) {
                found = j;
                hits++;
            }
        }

        if (found == -1) {      // MISS
            int lru = 0;
            for (int j = 1; j < f; j++) {
                if (recent[j] < recent[lru]) {
                    lru = j;
                }
            }
            frames[lru] = pages[i];
            faults++;
            found = lru;
        }

        for (int j = 0; j < f; j++) {
            recent[j]--;
        }
        recent[found] = 100;

        for (int j = 0; j < f; j++) {
            printf("%d ", frames[j]);
        }
        printf("\n");
    }

    float lru_ratio = (float)hits / n;
    printf("LRU Faults = %d, Hits = %d, Hit Ratio = %.2f\n",
           faults, hits, lru_ratio);



    /* ===================== OPTIMAL =================== */
    for (int i = 0; i < f; i++) {
        frames[i] = -1;
    }

    faults = 0;
    hits = 0;

    printf("\n\n--- OPTIMAL ---\n");

    for (int i = 0; i < n; i++) {

        int found = -1;
        for (int j = 0; j < f; j++) {
            if (frames[j] == pages[i]) {
                found = j;
                hits++;
            }
        }

        if (found == -1) {        // MISS

            int replace = 0;
            int farthest = -1;

            for (int j = 0; j < f; j++) {
                int k;
                for (k = i + 1; k < n; k++) {
                    if (frames[j] == pages[k]) {
                        break;
                    }
                }

                if (k > farthest) {
                    farthest = k;
                    replace = j;
                }
            }

            frames[replace] = pages[i];
            faults++;
        }

        for (int j = 0; j < f; j++) {
            printf("%d ", frames[j]);
        }
        printf("\n");
    }

    float opt_ratio = (float)hits / n;
    printf("Optimal Faults = %d, Hits = %d, Hit Ratio = %.2f\n",
           faults, hits, opt_ratio);


    return 0;
}