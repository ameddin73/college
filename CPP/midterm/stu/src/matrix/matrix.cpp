#include "matrix.h"
#include <iomanip>

using std::endl;
using std::ostream;
using std::setw;
using std::vector;

Matrix::Matrix(unsigned int rows, unsigned int cols, int val) :
    rows_(rows),
    cols_(cols),
    mat_() {
    mat_.resize(rows);
    for (unsigned int i=0; i<mat_.size(); ++i) {
        mat_[i].resize(cols, val);
    }
}

Matrix::Matrix(const Matrix& other) :
        rows_(other.rows_),
        cols_(other.cols_),
        mat_(other.mat_) {
}

Matrix::~Matrix(){
}

Matrix& Matrix::operator=(const Matrix& other) {
    if (this != &other) {
        rows_ = other.rows_;
        cols_ = other.cols_;
        mat_.resize(rows_);
        for (unsigned int i=0; i<mat_.size(); ++i) {
            mat_[i].resize(cols_);
        }
        for (unsigned int r=0; r<rows_; ++r) {
            for (unsigned int c=0; c<cols_; ++c) {
                mat_[r][c] = other.mat_[r][c];
            }
        }
    }
    return *this;
}

Matrix Matrix::operator+(const Matrix& other) const {
    Matrix result(other.rows_, other.cols_, 0);
    for (unsigned int r=0; r<rows_; ++r) {
        for (unsigned int c=0; c<cols_; ++c) {
            result.mat_[r][c] = mat_[r][c] + other.mat_[r][c];
        }
    }
    return result;
}

Matrix& Matrix::operator+=(const Matrix& other) {
    *this = *this + other;
    return *this;
}

Matrix Matrix::operator*(const Matrix& other) const {
    Matrix result(rows_, other.cols_, 0);
    for (unsigned int cc=0; cc<other.cols_; ++cc) {
        for (unsigned int r=0; r<rows_; ++r) {
            for (unsigned int c=0; c<other.rows_; ++c) {
                result.mat_[r][cc] += mat_[r][c] * other.mat_[c][cc];
            }
        }
    }
    return result;
}

Matrix& Matrix::operator*=(const Matrix& other) {
    *this = *this * other;
    return *this;
}

Matrix Matrix::operator+(int val) const {
    Matrix result(rows_, cols_, 0);
    for (unsigned int r=0; r<rows_; ++r) {
        for (unsigned int c=0; c<cols_; ++c) {
            result.mat_[r][c] = mat_[r][c] + val;
        }
    }
    return result;
}

Matrix Matrix::diagonal() const {
    Matrix result(rows_, cols_, 0);
    for (unsigned int r=0; r<rows_; ++r) {
        for (unsigned int c=0; c<cols_; ++c) {
            if (r == c)
                result.mat_[r][c] = mat_[r][c];
        }
    }
    return result;
}

Matrix Matrix::transpose() const {
    Matrix result(rows_, cols_, 0);
    for (unsigned int r=0; r<rows_; ++r) {
        for (unsigned int c=0; c<cols_; ++c) {
            result.mat_[r][c] = mat_[c][r];
        }
    }
    return result;
}

unsigned int Matrix::rows() const {
    return rows_;
}

unsigned int Matrix::cols() const {
    return cols_;
}

int& Matrix::operator()(unsigned int row, unsigned int col) {
    return mat_[row][col];
}

ostream& operator<<(ostream& os, const Matrix& m) {
    for (unsigned int r=0; r<m.rows_; ++r) {
        os << "| ";
        for (unsigned int c=0; c<m.cols_; ++c) {
            os << setw(3) << m.mat_[r][c] << " ";
        }
        os << "|" << endl;
    }
    return os;
}
