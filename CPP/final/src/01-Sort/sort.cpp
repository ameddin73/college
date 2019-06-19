// Problem 1 - Insertion Sort
//
// Convert the code from using a single native array to a single STL array.
//
// $ ./sort
// 0 1 2 3 4 5 6 7 8 9

#include <algorithm>
#include <iostream>
#include <utility>
#include <array>

using std::cout;
using std::endl;
using std::for_each;
using std::swap;

/**
 * Move the value at mark so that it is in its proper place.
 *
 * @pre data[0] to data[mark] is sorted
 * @post data[0] to data[mark+1] is sorted
 * @param data array of data to sort
 * @param mark "cuts" the array between mark and mark+1
 */
void insert(std::array<int, 10>& data, int mark) {
	int index = mark;
	while (index > -1 && data[index] > data[index+1]) {
		swap(data[index], data[index+1]);
		--index;
	}
}

/**
 * Perform an in-place insertion sort.
 * @post data is sotred
 * @param data array of data to sort
 * @param len the number of elements in data
 */
void insertion_sort(std::array<int, 10>& data) {
	for (unsigned int mark=0; mark<data.size()-1; ++mark) {
		insert(data, mark);
	}
}

/**
 * The main routine sorts a fixed array of data.
 *
 * @return 0
 */
int main() {
    std::array<int, 10> data = {3,7,5,1,2,4,8,9,0,6};
	insertion_sort(data);

    // display the sorted data
    for_each(data.begin(), data.end(), [](int &n){cout << n << " ";});
	cout << endl;

    return 0;
}
