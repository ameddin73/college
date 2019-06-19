// A simple binary search tree with no balancing.  It internally uses a nested
// Node class to store the values of the tree.

#include <initializer_list>
#include <iostream>
#include <memory>
#include <utility>
#include <vector>

using std::cout;
using std::endl;
using std::initializer_list;
using std::make_unique;
using std::ostream;
using std::unique_ptr;
using std::vector;

/**
 * A binary search tree data structure.
 *
 * @tparam T the type stored
 */
template<typename T>
class BST {
private:
    /**
     * A private nested binary node class consisting of a value, a left child
     * and a right child.
     */
    class Node {

    public:
        /**
         * Construct a node with no children
         *
         * @param value node's value
         */
        Node(const T &value) :
                val_{value},
                left_{nullptr},
                right_{nullptr} {
            cout << "Creating leaf: " << value << endl;
        }

        /**
         * Copy construct from another node by recursively making new nodes.
         *
         * @param other the node to copy from
         */
        Node(const Node &other) :
                val_{other.val_},
                left_{other.left_ ? make_unique<Node>(Node{*(other.left_)}) : nullptr},
                right_{other.right_ ? make_unique<Node>(Node{*(other.right_)}) : nullptr} {
            cout << "Node: " << val_ << " copy constructed" << endl;
        }

        /**
         * Destruct a node
         */
        ~Node() {
            cout << "Node: " << val_ << " destructing" << endl;
        }

        /**
         * Copy assignment is deleted.
         */
        Node &operator=(const Node &other) = delete;

        /**
         * Get the node's value.
         *
         * @return node's value
         */
        T value() const {
            return val_;
        }

        /**
         * Insert a new value into the BST.
         *
         * @param value value to insert
         * @return a reference to this node
         */
        Node &insert(const T &value) {
            if (value <= val_) {
                if (left_) {
                    left_->insert(value);
                } else {
                    cout << "At left of node: " << val_ << endl;
                    left_.reset(new Node{value});
                }
            } else {
                if (right_) {
                    right_->insert(value);
                } else {
                    cout << "At right of node: " << val_ << endl;
                    right_.reset(new Node{value});
                }
            }

            return *this;
        }

        /**
         * Convert a node, n, and its children into a vector of values
         * using inorder traversal.
         *
         * @param v the vector to populate
         * @param n the node
         */
        friend void node_to_vector(vector<T> &v, const Node &n) {
            if (n.left_) {
                node_to_vector(v, *n.left_);
            }
            v.push_back(n.value());
            if (n.right_) {
                node_to_vector(v, *n.right_);
            }
        }

    private:
        /** the node's value **/
        T val_;
        /** the node's left child **/
        unique_ptr<Node> left_;
        /** the node's right child **/
        unique_ptr<Node> right_;
    }; // Node

public:
    /**
     * Default construct an empty tree
     */
    BST() : root_{nullptr} {
        cout << "Creating empty tree (default ctor)" << endl;
    }

    /**
     * Construct the BST from a list of elements.
     *
     * @param elements
     */
    BST(const initializer_list<T> &elements) : BST{} {
        cout << "Creating tree from initializer list" << endl;
        for (auto &element : elements) {
            *this << element;
        }
    }

    /**
     * Destruct the BST.
     */
    ~BST() { cout << "Destructing tree" << endl; }

    /**
     * Copy construct this BST from another BST.
     *
     * @param other the other BST
     */
    BST(const BST<T> &other) : BST{} {
        cout << "Copy constructing tree" << endl;

        // copy from root if other is not empty
        if (!other.empty()) {
            root_ = make_unique<Node>(Node{*other.root_});
        }
    }

    /**
     * Move construct this BST from another BST.
     *
     * @param other the other BST
     */
    BST(BST<T> &&other) :
        root_{nullptr} {
        cout << "Move constructor tree" << endl;

        // copy from root if other is not empty
        if (!other.empty()) {
            //root_ = make_unique<Node>(Node{*other.root_});
            //root_ = make_unique<Node>(Node{nullptr});
            std::swap(root_,other.root_);
        }
    }

    /**
     * Copy assign another BST to this.
     *
     * @param other the other BST
     * @return reference to this
     */
    BST &operator=(const BST<T> &other) {
        cout << "Copy assignment tree" << endl;
        if (this != &other) {  // avoid self-assignment
            if (!empty()) {
                cout << "Clearing out left hand side" << endl;
                root_.reset(nullptr);
            }
            if (!other.empty()) {
                cout << "Copying root to left hand side" << endl;
                root_ = make_unique<Node>(Node{*other.root_});
            }
        }
        return *this;
    }

    /**
     * Move assign another BST to this.
     *
     * @param other the other BST
     * @return reference to this
     */
    BST &operator=(BST<T> &&other) {
        cout << "Move assignment tree" << endl;
        if (this != &other) {  // avoid self-assignment
            if (!empty()) {
                cout << "Clearing out left hand side" << endl;
                root_.reset(nullptr);
            }
            if (!other.empty()) {
                cout << "Moving root to left hand side" << endl;
                //root_ = make_unique<Node>(Node{*other.root_});
                std::swap(root_,other.root_);
            }
        }
        return *this;
    }

    /**
     * Insert an element into the tree using BST rules
     * (if empty => root, if less or equal => left, if greater => right)
     *
     * @param t the tree
     * @param element element to insert
     * @return reference to the tree
     */
    friend BST &operator<<(BST &t, const T &element) {
        if (t.empty()) {
            t.root_.reset(new Node{element});
        } else {
            (t.root_)->insert(element);
        }
        return t;
    }

    /**
     * Is the tree empty?
     *
     * @return whether the tree is empty or not.
     */
    bool empty() const {
        return root_ == nullptr;
    }

    /**
     * Returns an inorder vector of the tree
     * @return ordered vector
     */
    vector<T> to_vector() const {
        vector<T> v;
        if (!empty()) {
            node_to_vector(v, *root_);
        }
        return v;
    }

    // friend toString that uses toVector
    friend ostream &operator<<(ostream &os, const BST &t) {
        for (auto &element : t.to_vector()) {
            os << element << " ";
        }
        return os;
    }

private:
    /** the root of the tree is an encapsulated smart pointer */
    unique_ptr<Node> root_;
}; // BST
