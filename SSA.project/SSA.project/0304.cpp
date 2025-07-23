#include<iostream>
#include<sstream>
#include<stack>
#include<cctype>
#include<string>
#include<vector>

using namespace std;

int grade(char op) {
	if (op == '+' || op == '-')
		return 1;
	if (op == '*' || op == '/')
		return 2;
	if (op == '^')
		return 3;
	return 0;
}

bool isnum(string str) {
	if (isdigit(str[0]))
		return true;
	if (str.length() > 1 && str[0] == '-')
		return true;
	return false;
}

vector<string> trans() {
	string str;
	vector<string> v;
	stack<char> st;
	string line;
	getline(cin, line);
	stringstream ss(line);
	while (ss >> str) {
		if (isnum(str)) {
			v.push_back(str);
		}
		else if (str == "(") {
			st.push(str[0]);
		}
		else if (str == "+" || str == "-" || str == "*" || str == "/" || str == "^") {
			while (!st.empty() && st.top() != '(') {
				if (grade(str[0]) <= grade(st.top())) {
					v.push_back(string(1, st.top()));
					st.pop();
				}
				else
					break;
			}
			st.push(str[0]);
		}
		else if (str == ")") {
			while (st.top() != '(') {
				v.push_back(string(1, st.top()));
				st.pop();
			}
			st.pop();
		}
	}
	while (!st.empty()) {
		v.push_back(string(1, st.top()));
		st.pop();
	}
	return v;
}

int cal(vector<string> v) {
	stack<int> st;
	for (int i = 0;i<v.size();i++) {
		string str = v[i];
			if (str == "+" || str == "-" || str == "*" || str == "/" || str == "^") {
				int b = st.top();
				st.pop();
				int a = st.top();
				st.pop();
				int res = 1;
				if (str == "+") {
					res = a + b;
				}
				if (str == "-") {
					res = a - b;
				}
				if (str == "*") {
					res = a * b;
				}
				if (str == "/") {
					res = a / b;
				}
				if (str == "^") {			
					for (int j = 0; j < b; j++) 
						res *= a;
				}
				st.push(res);
			}
			else
				st.push(stoi(str));
	}
	return st.top();
}

int main() {
	int n;
	cin >> n;
	cin.ignore();
	for (int i = 0; i < n; i++) {
		cout << cal(trans()) << endl;
	}
	return 0;
}