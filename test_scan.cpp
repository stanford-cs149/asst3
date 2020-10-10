#include<iostream>
#include<string>
void exclusive_scan_recursive(int* start, int* end, int* output, int* scratch) {

    int N = end - start;

    if (N == 0)
        return;
    else if (N == 1) {
        output[0] = 0;
        return;
    }

    // sum pairs in parallel.
    for (int i = 0; i < N/2; i++)
        output[i] = start[2*i] + start[2*i+1];

    // prefix sum on the compacted array.
    exclusive_scan_recursive(output, output + N/2, scratch, scratch + (N/2));

    // finally, update the odd values in parallel.
    for (int i = 0; i < N; i++) {
        output[i] = scratch[i/2];
        if (i % 2)
            output[i] += start[i-1];
    }
}

int main(int argc, char ** arv) {
    int size = 6;
    int start[] = {0,1,2,5,6,7};
    int scratch[] = {0,0,0,0,0,0};
    int output[] = {0,0,0,0,0,0};

    exclusive_scan_recursive(start, start + size, output, scratch);
    std::cout << "[";
    for (int i = 0; i < size; i++) {
        std::cout << i;
        if (i < size-1) {
            std::cout << ",";
        }
    }
    std::cout << "]" << std::endl;
    return 0;
}
