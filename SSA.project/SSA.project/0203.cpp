#include<iostream>

using namespace std;

//����һ���ַ�����ASCII�������ַ�������
int MaxASC(string s) {
	int maxIndex = 0;
	int maxValue = s[0];
	for (int i = 1; i < s.size(); i++) {
		if (s[i] > maxValue) {
			maxValue = s[i];
			maxIndex = i;
		}
	}
	return maxIndex;
}

int main() {
	string str, Substr;
	while (cin >> str >> Substr) {
		string s = str.substr(0, MaxASC(str) + 1) + Substr + str.substr(MaxASC(str) + 1);
		cout << s << endl;
	}
	return 0;
}