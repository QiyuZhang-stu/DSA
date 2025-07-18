#include<iostream>
#include<stack>
#include<vector>
#include<cctype>
#include<string>
#include<algorithm>

using namespace std;

int grade(char op) {
	if (op == '+' || op == '-')
		return 1;
	if (op == '*' || op == '/')
		return 2;
	return 0;
}

vector<string> trans(string str) {
	vector<string> s;//后缀表达式
	stack<char> op;//中转后存储符号的栈
	for (int i = 0; i < str.length(); i++) {
		char c = str[i];
		if (isdigit(c)) {
			string num;
			while (i < str.length() && isdigit(str[i])) {
				num += str[i++];
			}
			i--;
			s.push_back(num);
		}
		else if (c == '(') {
			op.push(c);
		}
		else if (c == '+' || c == '-' || c == '*' || c == '/') {
			while (!op.empty() && op.top() != '(') {
				if (grade(c) <= grade(op.top())) {
					s.push_back(string(1, op.top()));
					op.pop();
				}
				else
					break;
			}
			op.push(c);
		}
		else if (c == ')') {
			while (op.top() != '(') {
				s.push_back(string(1, op.top()));
				op.pop();
			}
			op.pop();
		}
	}
	while (!op.empty()) {
		s.push_back(string(1, op.top()));
		op.pop();
	}
	return s;
}

int cal(vector<string> s) {
	stack<int> st;
	for (string str : s) {
		if (str == "+" || str == "-" || str == "*" || str == "/") {
			int b = st.top();
			st.pop();
			int a = st.top();
			st.pop();
			if (str == "+") {
				st.push(a + b);
			}
			if (str == "-") {
				st.push(a - b);
			}
			if (str == "*") {
				st.push(a * b);
			}
			if (str == "/") {
				st.push(a / b);
			}
		}
		else
			st.push(stoi(str));
	}
	return st.top();
}

int main() {
	int n;
	cin >> n;
	for (int j = 0; j < n; j++) {
		vector<string> s;//后缀表达式
		stack<char> op;//中转后存储符号的栈
		string str;
		cin >> str;
		s = trans(str);
		cout << cal(s) << endl;
	}
	return 0;
}