#include <iostream>
#include <vector>
#include <cstring>
using namespace std;

void computePrefixFunction(const string& s, vector<int>& pi) {
    int n = s.length();
    pi[0] = 0;
    for (int i = 1; i < n; i++) {
        int j = pi[i - 1];
        while (j > 0 && s[i] != s[j]) {
            j = pi[j - 1];
        }
        if (s[i] == s[j]) {
            j++;
        }
        pi[i] = j;
    }
}

int main() {
    int caseNum = 0;
    int n;
    while (cin >> n && n != 0) {
        string s;
        cin >> s;
        caseNum++;
        cout << "Test case #" << caseNum << endl;

        vector<int> pi(n);
        computePrefixFunction(s, pi);

        for (int i = 1; i < n; i++) {
            int len = i + 1;
            int cycleLen = len - pi[i];
            if (pi[i] > 0 && len % cycleLen == 0) {
                cout << len << " " << len / cycleLen << endl;
            }
        }
        cout << endl;
    }
    return 0;
}