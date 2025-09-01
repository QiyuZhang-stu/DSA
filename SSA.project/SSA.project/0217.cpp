#include<iostream>
#include<vector>

using namespace std;

int main() {
	int N;
	cin >> N;
	int x = 0, y = N - 1;
	vector<vector<int>> v(2 * N - 1, vector<int>(2 * N - 1, 0));
	v[x][y] = 1;
	for (int i = 2; i <= (2 * N - 1) * (2 * N - 1); ++i) {
		if ((x == 0 && y == 2 * N - 2) || v[(x + 2 * N - 2) % (2 * N - 1)][(y + 1) % (2 * N - 1)]) { ++x; }
		else { --x; ++y; }
		x = (x + 2 * N - 1) % (2 * N - 1);
		y = y % (2 * N - 1);
		v[x][y] = i;
	}
	for (int i = 0; i < 2 * N - 1; ++i) {
		for (int j = 0; j < 2 * N - 1; ++j) {
			cout << v[i][j];
			if (j == 2 * N - 2) cout << endl;
			else cout << " ";
		}
	}
	return 0;
}