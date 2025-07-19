#include<iostream>
#include<queue>
#include<vector>

using namespace std;

int main() {
	int n;
	vector<string> v;
	vector<string> V;
	queue<string> q1, q2, q3, q4, q5, q6, q7, q8, q9, qa, qb, qc, qd;
	cin >> n;
	for (int i = 0; i < n; i++) {
		string s;
		cin >> s;
		v.push_back(s);
	}
	for (int j = 0; j < n; j++) {
		string str = v[j];
		switch (str[1]) {
		case('1'):q1.push(str); break;
		case('2'):q2.push(str); break;
		case('3'):q3.push(str); break;
		case('4'):q4.push(str); break;
		case('5'):q5.push(str); break;
		case('6'):q6.push(str); break;
		case('7'):q7.push(str); break;
		case('8'):q8.push(str); break;
		case('9'):q9.push(str); break;
		}
	}
	cout << "Queue1:";
	while (!q1.empty()) {
		string str = q1.front();
		q1.pop();
		cout << str << " ";
		switch (str[0]) {
		case('A'):qa.push(str); break;
		case('B'):qb.push(str); break;
		case('C'):qc.push(str); break;
		case('D'):qd.push(str); break;
		}
	}
	cout << endl;
	cout << "Queue2:";
	while (!q2.empty()) {
		string str = q2.front();
		q2.pop();
		cout << str << " ";
		switch (str[0]) {
		case('A'):qa.push(str); break;
		case('B'):qb.push(str); break;
		case('C'):qc.push(str); break;
		case('D'):qd.push(str); break;
		}
	}
	cout << endl;
	cout << "Queue3:";
	while (!q3.empty()) {
		string str = q3.front();
		q3.pop();
		cout << str << " ";
		switch (str[0]) {
		case('A'):qa.push(str); break;
		case('B'):qb.push(str); break;
		case('C'):qc.push(str); break;
		case('D'):qd.push(str); break;
		}
	}
	cout << endl;
	cout << "Queue4:";
	while (!q4.empty()) {
		string str = q4.front();
		q4.pop();
		cout << str << " ";
		switch (str[0]) {
		case('A'):qa.push(str); break;
		case('B'):qb.push(str); break;
		case('C'):qc.push(str); break;
		case('D'):qd.push(str); break;
		}
	}
	cout << endl;
	cout << "Queue5:";
	while (!q5.empty()) {
		string str = q5.front();
		q5.pop();
		cout << str << " ";
		switch (str[0]) {
		case('A'):qa.push(str); break;
		case('B'):qb.push(str); break;
		case('C'):qc.push(str); break;
		case('D'):qd.push(str); break;
		}
	}
	cout << endl;
	cout << "Queue6:";
	while (!q6.empty()) {
		string str = q6.front();
		q6.pop();
		cout << str << " ";
		switch (str[0]) {
		case('A'):qa.push(str); break;
		case('B'):qb.push(str); break;
		case('C'):qc.push(str); break;
		case('D'):qd.push(str); break;
		}
	}
	cout << endl;
	cout << "Queue7:";
	while (!q7.empty()) {
		string str = q7.front();
		q7.pop();
		cout << str << " ";
		switch (str[0]) {
		case('A'):qa.push(str); break;
		case('B'):qb.push(str); break;
		case('C'):qc.push(str); break;
		case('D'):qd.push(str); break;
		}
	}
	cout << endl;
	cout << "Queue8:";
	while (!q8.empty()) {
		string str = q8.front();
		q8.pop();
		cout << str << " ";
		switch (str[0]) {
		case('A'):qa.push(str); break;
		case('B'):qb.push(str); break;
		case('C'):qc.push(str); break;
		case('D'):qd.push(str); break;
		}
	}
	cout << endl;
	cout << "Queue9:";
	while (!q9.empty()) {
		string str = q9.front();
		q9.pop();
		cout << str << " ";
		switch (str[0]) {
		case('A'):qa.push(str); break;
		case('B'):qb.push(str); break;
		case('C'):qc.push(str); break;
		case('D'):qd.push(str); break;
		}
	}
	cout << endl;

	cout << "QueueA:";
	while (!qa.empty()) {
		string str = qa.front();
		qa.pop();
		cout << str << " ";
		V.push_back(str);
	}
	cout << endl;
	cout << "QueueB:";
	while (!qb.empty()) {
		string str = qb.front();
		qb.pop();
		cout << str << " ";
		V.push_back(str);
	}
	cout << endl;
	cout << "QueueC:";
	while (!qc.empty()) {
		string str = qc.front();
		qc.pop();
		cout << str << " ";
		V.push_back(str);
	}
	cout << endl;
	cout << "QueueD:";
	while (!qd.empty()) {
		string str = qd.front();
		qd.pop();
		cout << str << " ";
		V.push_back(str);
	}
	cout << endl;
	cout << V[0];
	for (int i = 1; i < n; i++)
		cout << " " << V[i];
	return 0;
}