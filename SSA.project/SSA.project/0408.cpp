#include<iostream>
#include<vector>

using namespace std;

vector<int> buildnext(string s) {
	if (s.empty()) return {};
	vector<int> next(s.length(), 0);
	int len = 0;
	int i = 1;
	while (i < s.length()) {
		if (s[i] == s[len]) {
			len++;
			next[i] = len;
			i++;
		}
		else {
			if (len != 0) {
				len = next[len - 1];
			}
			else {
				next[i] = 0;
				i++;
			}
		}
	}
	return next;
}

int main() {
	int len;
	int num = 1;
	string s;
	while (cin >> len) {
		if (len == 0)
			break;
		cin >> s;
		cout << "Test case #" << num << endl;
		num++;
		vector<int> next = buildnext(s);
		for (int i = 1; i < s.length(); i++) {
			if (next[i] != 0) {
				int cyclelen = i + 1 - next[i];
				if ((i + 1) % cyclelen == 0) {
					int I = i + 1;
					int K = I / cyclelen;
					cout << I << " " << K << endl;
				}
			}
		}
		cout << endl;
	}
	return 0;
}