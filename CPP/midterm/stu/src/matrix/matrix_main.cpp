#include "matrix.h"

using std::cout;
using std::endl;
using std::vector;

/**
 * Test function for the Matrix class.
 *
 * @return 0
 */
int main() {
    Matrix m1(2,3,0);
    m1(0,0) = 4;
    m1(0,1) = 2;
    m1(0,2) = 6;
    m1(1,0) = 5;
    m1(1,1) = 3;
    m1(1,2) = 1;
    cout << "m1:" << endl << m1;
    cout << "m1 rows: " << m1.rows() << endl;
    cout << "m1 cols: " << m1.cols() << endl;

    Matrix m2(2,3,1);
    m2(0,0) = 7;
    m2(0,1) = 3;
    m2(1,0) = 4;
    m2(1,1) = 6;
    cout << "m2:" << endl << m2;

    Matrix m3(0,0,0);
    m3 = m1;
    cout << "m3 = m1:" << endl << m3;

    cout << "m1 + m2:" << endl << (m1 + m2);
    m3 += m2;
    cout << "m3 += m2:" << endl << m3;

    Matrix m4(3,2,2);
    m4(0,0) = 5;
    m4(0,1) = 7;
    m4(1,0) = 2;
    m4(1,1) = 1;
    m4(2,0) = 3;
    m4(2,1) = 4;
    cout << "m4: " << endl << m4;
    cout << "m2 * m4:" << endl << (m2 * m4);
    m2 *= m4;
    cout << "m2 *= m4:" << endl << m2;

    Matrix m5(3,3,1);
    m5(0,0) = 2;
    m5(0,1) = 6;
    m5(0,2) = 7;
    m5(1,1) = 3;
    m5(2,0) = 5;
    m5(2,1) = 0;
    m5(2,2) = 4;
    cout << "m5:" << endl << m5;
    cout << "m5 diagonal:" << endl << m5.diagonal();
    cout << "m5 transpose:" << endl << m5.transpose();
}
