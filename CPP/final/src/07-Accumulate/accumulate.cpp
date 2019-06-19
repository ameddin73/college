// Problem 7 - Accumulate
//
// Remove both loops from the following code and replace it with calls to
// std::accumulate.  The first result is the result of multiplying all the
// first numbers together.  The second result is the result of adding all
// the second numbers to the first result.
//
// Expected output:
// $ ./accumulate
// multiply result: 105
// add result: 125

#include <iostream>
#include <vector>
#include <numeric>

using std::cout;
using std::endl;
using std::vector;
using std::accumulate;

int main() {
    // we will multiply these numbers together to get the first result
    vector<int> mul_numbers{1, 3, 5, 7};

    //int mul_result = 1;
    //for (int num : mul_numbers) {
    //    mul_result *= num;
    //}
    int mul_result = accumulate(mul_numbers.begin(),mul_numbers.end(),1,
            [](int a, int b) {return a*b;});

    cout << "multiply result: " << mul_result << endl;

    // we will then add the sum of these numbers to the first result and
    // store them in the second result
    vector<int> add_numbers{2, 4, 6, 8};

    int add_result = mul_result;
    //for (int num : add_numbers) {
    //    add_result += num;
    //}
    add_result += accumulate(add_numbers.begin(),add_numbers.end(),0);
            

    cout << "add result: " << add_result << endl;
}
