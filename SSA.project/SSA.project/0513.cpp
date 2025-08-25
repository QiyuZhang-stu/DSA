#include<iostream>
#include<vector>
#include<queue>

using namespace std;

int main() {
	int t;
	cin >> t;
	while (t--) {
		int n;
		cin >> n;
		priority_queue<int, vector<int>, greater<int>> minHeap;
		for (int i = 0; i < n; i++) {
			int w;
			cin >> w;
			minHeap.push(w);
		}
		int totalWPL = 0;
		while (minHeap.size() > 1) {
			int a = minHeap.top();
			minHeap.pop();
			int b = minHeap.top();
			minHeap.pop();
			int sum = a + b;
			totalWPL += sum;
			minHeap.push(sum);
		}
		cout << totalWPL << endl;
	}
	return 0;
}