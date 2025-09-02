#include<iostream>
#include<stack>
#include<queue>

using namespace std;

int main() {
	int n, t;
	int k = 1, tag = 0;
	stack<int> s;
	cin >> n;
	int N = n;
	queue<bool> act;
	queue<int> value;
	while (n--) {
		cin >> t;
		while (s.empty() || s.top() != t) {
			s.push(k);
			act.push(true);
			value.push(k);
			k++;
			if (k == N + 2) {
				cout << "NO";
				tag = 1;
				break;
			}
		}
		if (tag) break;
		act.push(false);
		value.push(s.top());
		s.pop();
		if (s.empty() && k == N + 1) {
			while (!act.empty()) {
				bool b = act.front();
				if (b) {
					cout << "PUSH " << value.front() << endl;
					act.pop();
					value.pop();
				}
				else {
					cout << "POP " << value.front() << endl;
					act.pop();
					value.pop();
				}
			}
		}
	}
	return 0;
}