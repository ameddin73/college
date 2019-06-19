#ifndef MATRIX_H
#define MATRIX_H

#include <iostream>
#include <vector>

/**
 * A class to represent a 2-D matrix.
 */
class Matrix {
public:
    /**
     * Create a new matrix N rows X M cols.
     *
     * @param rows number of rows
     * @param cols number of columns
     * @param val initial value to store in each cell
     */
    Matrix(unsigned int rows, unsigned int cols, int val);

    /**
     * Create a new matrix by copying another.
     *
     * @param other the matrix to copy
     */
    Matrix(const Matrix& other);

    /**
     * Destruct the matrix.
     */
    virtual ~Matrix();

    /**
     * Assign this matrix from another.
     *
     * @param other the rhs matrix to copy from
     * @return a reference to the lhs matrix
     */
    Matrix& operator=(const Matrix& other);

    /**
     * Add this matrix to another.
     *
     * @param other the matrix to add to
     * @return a new matrix with the addition of both
     */
    Matrix operator+(const Matrix& other) const;

    /**
     * Add this matrix to another and assign to this matrix.
     *
     * @param other the matrix to add to
     * @return this matrix
     */
    Matrix& operator+=(const Matrix& other);

    /**
     * Multiply this matrix with another.
     *
     * @param other the matrix to multiply with
     * @return a new matrix with the multiplication of both
     */
    Matrix operator*(const Matrix& other) const;

    /**
     * Multiply this matrix with another and assign to this matrix.
     *
     * @param other the matrix to multiply with
     * @return this matrix
     */
    Matrix& operator*=(const Matrix& other);

    /**
     * Add a scalar value to all elements in the matrix.
     *
     * @param val the value to add
     * @return a new matrix with the scalar addition by val
     */
    Matrix operator+(int val) const;

    /**
     * Get the diagonal of the matrix with all other elements zero'd out.
     *
     * @return a new diagonal matrix
     */
    Matrix diagonal() const;

    /**
     * Get the transpose of this matrix.
     *
     * @return a new transposed matrix
     */
    Matrix transpose() const;

    /**
     * Get the number of rows for the matrix.
     *
     * @return number of rows
     */
    unsigned int rows() const;

    /**
     * Get the number of columns for the matrix.
     *
     * @return number of columns
     */
    unsigned int cols() const;

    /**
     * Get the element at (row, col) in the matrix
     *
     * @param row the row index
     * @param col the column index
     * @return the element at the position
     */
    int& operator()(unsigned int row, unsigned int col);

    /**
     * Prints out the matrix to the output stream as:
     *
     * | a00 a01 ... |
     * | a10 a11 ... |
     * | ...         |
     *
     * @param os the output stream
     * @param m the matrix to output
     * @return the output stream
     */
    friend std::ostream& operator<<(std::ostream& os, const Matrix& m);

private:
    /** number of rows in the matrix */
    unsigned int rows_;
    /** number of columns in the matrix */
    unsigned int cols_;
    /** the matrix itself is a 2-D vector of integers */
    std::vector<std::vector<int> > mat_;
};

#endif // MATRIX_H
