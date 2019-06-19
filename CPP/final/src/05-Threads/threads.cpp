// Problem 5 - Threads
//
// The following program tries to compute the dot product of two vectors
// by using threads to split up the work.  Fix the race condition in
// the dot_product() function.  Your solution must still use threads
// to compute the result!
//
// To run:
//      threads #
// Where # is the number of threads.  Use 1 to see how it should work
// correctly, and a different positive number to see it fail.
//
// Expected output:
// $ threads
// 2000000

#include <iostream>
#include <thread>
#include <vector>
#include <sstream>
#include <mutex>

using std::cout;
using std::endl;
using std::istringstream;
using std::ref;
using std::thread;
using std::vector;
using std::mutex;

mutex m;

/**
 * Split "mem" into "parts", e.g. if parts = 4 and mem = 10 you will have:
 * 0,2,4,6,10.  if possible the function will split mem into equal chunks,
 * if not the last chunk will be slightly larger
 *
 * @param parts number of "equal" parts to segment chunks into
 * @param mem total number of chunks
 * @return the resulting vector
 */
vector<int> bounds(int parts, int mem) {
    vector<int> bnd;
    int delta = mem / parts;
    int reminder = mem % parts;
    int n1{}, n2{};
    bnd.push_back(n1);
    for (int i = 0; i < parts; ++i) {
        n2 = n1 + delta;
        if (i == parts - 1)
            n2 += reminder;
        bnd.push_back(n2);
        n1 = n2;
    }
    return bnd;
}

/**
 * Compute the dot product of two vectors
 *
 * @param v1 first vector
 * @param v2 second vector
 * @param result the result
 * @param L lower bound
 * @param R upper bound
 */
void dot_product(const vector<int> &v1, const vector<int> &v2, int &result,
                 int L, int R) {
    for (int i = L; i < R; ++i) {
        std::lock_guard<mutex> lock(m);
        result += v1[i] * v2[i];
    }
}

/**
 * The main program runs with one argument, the number of threads.
 *
 * @param argc number of command line arguments
 * @param argv command line arguments
 * @return 0
 */
int main(int argc, char *argv[]) {
    if (argc != 2) {
        cout << "Usage: threads num_threads" << endl;
        return 0;
    }

    // get the number of threads
    istringstream is{argv[1]};
    int num_threads;
    is >> num_threads;

    // how many elements each, and where to store the result
    int num_elements = 1000000;
    int result = 0;
    vector<thread> threads;

    // fill two vectors with some values:
    //	v1: {1,1,..,1}, v2: {2,2,...,2}
    vector<int> v1(num_elements, 1), v2(num_elements, 2);

    // split num_elements into num_elements parts
    vector<int> limits = bounds(num_threads, num_elements);

    // launch num_threads threads
    for (int i = 0; i < num_threads; ++i) {
        threads.push_back(thread(dot_product, ref(v1), ref(v2), ref(result),
                                 limits[i], limits[i + 1]));
    }

    // wait for all the threads to finish
    for (auto &t : threads) {
        t.join();
    }

    // the result should always be 2000000
    cout << result << endl;

    return 0;
}
