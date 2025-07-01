//My-1st
#include<iostream>
#include<string>
#include<cmath>

using namespace std;

//init
string dic[10001] = { "" };
string che[10001] = { "" };

//tool
bool isin(string s) {
	for (int i = 0; dic[i] != ""; i++) {
		if (s == dic[i])
			return true;
	}
	return false;
}

string del(string s,int i) {
	return s.erase(i, 1);
}

bool isnear(string s1, string s2) {
	if (s1.length() == s2.length()) {
		int len = s1.length();
		int dif = 0;
		for (int i = 0; i < len; i++) {
			if (s1[i] != s2[i]) {
				dif++;
			}
		}
		if (dif == 1)
			return true;
	}
	int len1 = s1.length();
	int len2 = s2.length();
	if (abs(len1 - len2) > 1)
		return false;
	if (len1 < len2) {
		string s = s1;
		s1 = s2;
		s2 = s;
		int l = len1;
		len1 = len2;
		len2 = l;
	}
	for (int i = 0; i < len1; i++) {
		if (del(s1, i) == s2) {
			return true;
		}
	}
	return false;
}


int main() {
	


	//input
	string str;
	int index = 0;
	while (cin >> str) {
		if(str == "#") {
			break; // End of dictionary input
		}
		if (str != "#") {
			dic[index] = str;
			index++;
		}
	}

	int Index = 0;
	while (cin >> str) {
		if (str == "#") {
			break; 
		}
		if (str != "#") {
			che[Index] = str;
			Index++;
		}
	}





	//main
	for(int i=0;che[i]!="";i++){
		if (isin(che[i])) {
			cout << che[i] << " is correct" << endl;
			continue;
		}
		cout << che[i] << ":";
		for(int j=0;dic[j]!="";j++) {
			if (isnear(dic[j], che[i])) {
				cout << " " << dic[j];
			}
		}
		cout << endl;
	}

	

	return 0;
}