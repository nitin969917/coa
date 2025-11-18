#include <stdio.h>

void directMapping(int addresses[], int n, int cacheSize, int blockSize, int mainMemorySize) {

    printf("\n--- DIRECT MAPPING ---\n");

    int numLines = cacheSize / blockSize;

    int valid[50], tag[50];
    for (int i = 0; i < numLines; i++) {
        valid[i] = 0;
        tag[i] = -1;
    }

    int hits = 0, misses = 0;

    for (int i = 0; i < n; i++) {

        int blockNum = addresses[i] / blockSize;
        int line = blockNum % numLines;
        int t = blockNum / numLines;

        if (valid[line] && tag[line] == t) {     // HIT
            printf("Address %d -> HIT\n", addresses[i]);
            hits++;
        }
        else {                                    // MISS
            printf("Address %d -> MISS\n", addresses[i]);
            valid[line] = 1;
            tag[line] = t;
            misses++;
        }
    }

    printf("Hits = %d, Misses = %d, Hit Ratio = %.2f\n",
           hits, misses, (float)hits / n);
}



void associativeMapping(int addresses[], int n, int cacheSize, int blockSize, int mainMemorySize) {

    printf("\n--- ASSOCIATIVE MAPPING ---\n");

    int numLines = cacheSize / blockSize;

    int cache[50], valid[50];
    for (int i = 0; i < numLines; i++) {
        valid[i] = 0;
    }

    int hits = 0, misses = 0;
    int next = 0;

    for (int i = 0; i < n; i++) {

        int blockNum = addresses[i] / blockSize;
        int hit = 0;

        // Check if present
        for (int j = 0; j < numLines; j++) {
            if (valid[j] && cache[j] == blockNum) {
                hit = 1;
                break;
            }
        }

        if (hit) {
            printf("Address %d -> HIT\n", addresses[i]);
            hits++;
        }
        else {
            printf("Address %d -> MISS\n", addresses[i]);
            cache[next] = blockNum;
            valid[next] = 1;
            next = (next + 1) % numLines;
            misses++;
        }
    }

    printf("Hits = %d, Misses = %d, Hit Ratio = %.2f\n",
           hits, misses, (float)hits / n);
}



void setAssociativeMapping(int addresses[], int n, int cacheSize, int blockSize, int mainMemorySize) {

    printf("\n--- SET ASSOCIATIVE (2-way) ---\n");

    int ways = 2;
    int numLines = cacheSize / blockSize;
    int numSets = numLines / ways;

    int cache[50][2], valid[50][2], next[50];

    for (int i = 0; i < numSets; i++) {
        next[i] = 0;
        for (int j = 0; j < ways; j++) {
            valid[i][j] = 0;
        }
    }

    int hits = 0, misses = 0;

    for (int i = 0; i < n; i++) {
        int blockNum = addresses[i] / blockSize;
        int set = blockNum % numSets;

        int hit = 0;

        // Check if present
        for (int j = 0; j < ways; j++) {
            if (valid[set][j] && cache[set][j] == blockNum) {
                hit = 1;
                break;
            }
        }

        if (hit) {
            printf("Address %d -> HIT (Set %d)\n", addresses[i], set);
            hits++;
        }
        else {
            printf("Address %d -> MISS (Set %d)\n", addresses[i], set);
            cache[set][next[set]] = blockNum;
            valid[set][next[set]] = 1;
            next[set] = (next[set] + 1) % ways;
            misses++;
        }
    }

    printf("Hits = %d, Misses = %d, Hit Ratio = %.2f\n",
           hits, misses, (float)hits / n);
}



int main() {

    int mainMemorySize, cacheSize, blockSize;
    int n, addresses[100];

    printf("Enter Main Memory Size (bytes): ");
    scanf("%d", &mainMemorySize);

    printf("Enter Cache Size (bytes): ");
    scanf("%d", &cacheSize);

    printf("Enter Block Size (bytes): ");
    scanf("%d", &blockSize);

    printf("Enter number of memory accesses: ");
    scanf("%d", &n);

    printf("Enter memory addresses:\n");
    for (int i = 0; i < n; i++) {
        scanf("%d", &addresses[i]);
    }

    directMapping(addresses, n, cacheSize, blockSize, mainMemorySize);
    associativeMapping(addresses, n, cacheSize, blockSize, mainMemorySize);
    setAssociativeMapping(addresses, n, cacheSize, blockSize, mainMemorySize);

    return 0;
}