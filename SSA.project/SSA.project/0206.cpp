#include<iostream>
#include<vector>

using namespace std;

void C(int d, vector<int>& A,int N) {
	for (int i = 0; i < N; i++) {
		A[i] = (A[i] + d) % 65535;
	}
}

bool notzero(int x, int I) {
	if (x == 0)
		return false;
	vector<int> a;
	int m = x;
	int n;
	while (m > 0) {
		n = m % 2;
		a.push_back(n);
		m = m / 2;
	}
	//注意边界情况处理
	if (I >= a.size())
		return false;
	//
	return a[I] != 0;
}

void Q(int I, vector<int>& A,int N) {
	int sum = 0;
	for (int i = 0; i < N; i++) {
		if (notzero(A[i],I)) {
			sum++;
		}
	}
	cout << sum << endl;
}


int main() {
	int N, M;
	cin >> N >> M;
	vector<int> A(N);
	for (int i = 0; i < N; i++) {
		cin >> A[i];
	}
	char str;
	int I;
	for (int i = 0; i < M; i++) {
		cin >> str >> I;
		if(str=='C')
			C(I, A, N);
		if(str == 'Q')
			Q(I, A, N);
	}
	return 0;
}