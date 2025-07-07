#include<iostream>
#include<queue>
#include<cstring>

using namespace std;

const int SIZE = 4;
const int TOTAL = 1 << (SIZE * SIZE);
int masks[16];
int steps[TOTAL];

void precomputeMasks() {
	for (int i = 0; i < SIZE; i++) {
		for (int j = 0; j < SIZE; j++) {
			int pos = i * SIZE + j;
			masks[pos] = (1 << pos);
			if (i > 0)masks[pos] |= (1 << (pos - SIZE));
			if (i < SIZE - 1) masks[pos] |= (1 << (pos + SIZE));
			if (j > 0)masks[pos] |= (1 << (pos - 1));
			if (j < SIZE - 1) masks[pos] |= (1 << (pos + 1));
		}
	}
}

int main() {
	precomputeMasks();
	int state = 0;
	for (int i = 0; i < SIZE; i++) {
		string s;
		cin >> s;
		for (int j = 0; j < SIZE; j++) {
			if(s[j]=='b')
				state |= (1 << (i * SIZE + j));
		}
	}
	if(state==0||state==TOTAL-1) {
		cout << "0" << endl;
		return 0;
	}
	queue<int> q;
	q.push(state);
	memset(steps, -1, sizeof(steps));
	steps[state] = 0;
	while (!q.empty()) {
		int cur = q.front();
		q.pop();

		// 尝试所有16种操作
		for (int i = 0; i < 16; i++) {
			int next = cur ^ masks[i];  // 异或操作实现翻转

			// 达到目标状态
			if (next == 0 || next == TOTAL - 1) {
				cout << steps[cur] + 1 << endl;
				return 0;
			}

			// 新状态入队
			if (steps[next] == -1) {
				steps[next] = steps[cur] + 1;
				q.push(next);
			}
		}
	}
	cout << "Impossible" << endl;
	return 0;
}