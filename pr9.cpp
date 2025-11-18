#include <iostream>
using namespace std;

void directMapping(int addresses[], int n, int cacheSize, int blockSize, int mainMemorySize) {
    cout << "\n--- DIRECT MAPPING ---\n";

    int numBlocks = mainMemorySize / blockSize;
    int numLines = cacheSize / blockSize;

    int cache[numLines];
    int tag[numLines];
    bool valid[numLines];

    for (int i = 0; i < numLines; i++) {
        valid[i] = false;
        tag[i] = -1;
    }

    int hits = 0, misses = 0;

    for (int i = 0; i < n; i++) {
        int blockNum = addresses[i] / blockSize;
        int line = blockNum % numLines;
        int t = blockNum / numLines;

        if (valid[line] && tag[line] == t) {
            cout << "Address " << addresses[i] << " -> HIT\n";
            hits++;
        } else {
            cout << "Address " << addresses[i] << " -> MISS\n";
            valid[line] = true;
            tag[line] = t;
            misses++;
        }
    }

    cout << "Hits: " << hits << ", Misses: " << misses;
    cout << ", Hit Ratio: " << (float)hits / n << "\n";
}

void associativeMapping(int addresses[], int n, int cacheSize, int blockSize, int mainMemorySize) {
    cout << "\n--- ASSOCIATIVE MAPPING ---\n";

    int numLines = cacheSize / blockSize;
    int cache[numLines];
    bool valid[numLines];

    for (int i = 0; i < numLines; i++) valid[i] = false;

    int hits = 0, misses = 0;
    int nextReplace = 0;

    for (int i = 0; i < n; i++) {
        int blockNum = addresses[i] / blockSize;
        bool hit = false;

        for (int j = 0; j < numLines; j++) {
            if (valid[j] && cache[j] == blockNum) {
                hit = true;
                break;
            }
        }

        if (hit) {
            cout << "Address " << addresses[i] << " -> HIT\n";
            hits++;
        } else {
            cout << "Address " << addresses[i] << " -> MISS\n";
            cache[nextReplace] = blockNum;
            valid[nextReplace] = true;
            nextReplace = (nextReplace + 1) % numLines;
            misses++;
        }
    }

    cout << "Hits: " << hits << ", Misses: " << misses;
    cout << ", Hit Ratio: " << (float)hits / n << "\n";
}

void setAssociativeMapping(int addresses[], int n, int cacheSize, int blockSize, int mainMemorySize) {
    cout << "\n--- SET-ASSOCIATIVE MAPPING (2-way) ---\n";

    int ways = 2;
    int numLines = cacheSize / blockSize;
    int numSets = numLines / ways;

    int cache[numSets][ways];
    bool valid[numSets][ways];
    int nextReplace[numSets];

    for (int i = 0; i < numSets; i++) {
        nextReplace[i] = 0;
        for (int j = 0; j < ways; j++) {
            valid[i][j] = false;
        }
    }

    int hits = 0, misses = 0;

    for (int i = 0; i < n; i++) {
        int blockNum = addresses[i] / blockSize;
        int set = blockNum % numSets;
        bool hit = false;

        // Check if present
        for (int j = 0; j < ways; j++) {
            if (valid[set][j] && cache[set][j] == blockNum) {
                hit = true;
                break;
            }
        }

        if (hit) {
            cout << "Address " << addresses[i] << " -> HIT (Set " << set << ")\n";
            hits++;
        } else {
            cout << "Address " << addresses[i] << " -> MISS (Set " << set << ")\n";
            cache[set][nextReplace[set]] = blockNum;
            valid[set][nextReplace[set]] = true;
            nextReplace[set] = (nextReplace[set] + 1) % ways;
            misses++;
        }
    }

    cout << "Hits: " << hits << ", Misses: " << misses;
    cout << ", Hit Ratio: " << (float)hits / n << "\n";
}

int main() {
    int mainMemorySize, cacheSize, blockSize;
    cout << "Enter Main Memory Size (bytes): ";
    cin >> mainMemorySize;
    cout << "Enter Cache Size (bytes): ";
    cin >> cacheSize;
    cout << "Enter Block Size (bytes): ";
    cin >> blockSize;

    int n;
    cout << "Enter number of memory accesses: ";
    cin >> n;

    int addresses[n];
    cout << "Enter memory addresses: ";
    for (int i = 0; i < n; i++)
        cin >> addresses[i];

    directMapping(addresses, n, cacheSize, blockSize, mainMemorySize);
    associativeMapping(addresses, n, cacheSize, blockSize, mainMemorySize);
    setAssociativeMapping(addresses, n, cacheSize, blockSize, mainMemorySize);

    return 0;
}