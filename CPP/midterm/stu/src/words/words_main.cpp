#include <iostream>
#include <fstream>
#include <map>
#include <set>
#include <vector>

using std::cerr;
using std::cout;
using std::ctype;
using std::ctype_base;
using std::endl;
using std::ifstream;
using std::map;
using std::set;
using std::string;
using std::vector;

/**
 * A structure that will ignore punctuation on words coming from an
 * input stream.
 *
 * http://stackoverflow.com/questions/4888879/
 * elegant-ways-to-count-the-frequency-of-words-in-a-file
 */
struct LetterOnly : ctype<char> {
    LetterOnly(): ctype<char>(get_table()) {}

    static mask const* get_table() {
        static vector<mask>
                rc(table_size, space);

        std::fill(&rc['A'], &rc['z'+1], alpha);
        return &rc[0];
    }
};

/**
 * A structure to represent a word and it's total number of occurrences.
 */
struct WordCount {
    /** the word */
    string word_;
    /** the count */
    unsigned int count_;

    /**
     * Create a new WordCount object.
     *
     * @param word the word
     * @param count its count
     */
    WordCount(const string& word, unsigned int count) :
        word_(word),
        count_(count) {
    }
};

/**
 * A structure that contains a functor for comparing WordCount
 * objects.  It should first order WordCount's by descending
 * word count.  If two words have the same count, they should
 * be ordered alphabetically by word name.
 */
struct WordComparator {
    /**
     * The comparing function to order words first by count
     * and second alphabetically.
     *
     * @param w1 first word
     * @param w2 second word
     * @return true if w1's count is greater than w2's count.  if
     *     both counts are equal, true if the w1's word is less
     *     than w2's word
     */
    bool operator()(const WordCount& w1, const WordCount& w2) const {
        //TODO
        return false;
    }
};

int main() {
    ifstream ifs("data.txt", std::ifstream::in);
    // imbue the stream so it filters out punctuation
    ifs.imbue(std::locale(std::locale(), new LetterOnly()));

    if (!ifs) {
        cerr << "Error opening input file data.txt" << endl;
        return 0;
    }

    // read words into a map
    map<string, unsigned int> words;
    string word;
    while (ifs >> word) {
        ++words[word];
    }

    // create a set that will order WordCount object by the rules set by
    // WordComparator
    set<WordCount, WordComparator> counts;

    // iterate over the map and create WordCount objects out of each
    // pair in the map and insert them to the set

    //TODO

    // now iterate over the set and print out the top 20 words and their
    // counts, e.g.
    // #1 word1 : count
    // #2 word2 : count
    // ...

    //TODO
}
