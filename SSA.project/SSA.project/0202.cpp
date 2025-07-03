//总结：
// 1. 注意deque的初始化方式，先输入K再创建队列，
// 2. 使用deque的push_front和pop_front操作来模拟发牌过程
// 3. 使用vector存储Bessie的牌，并在最后进行排序输出



#include<iostream>
#include<deque>
#include<vector>
#include <algorithm>

using namespace std;

int main() {
	//input
	int N, K, P;
	cin >> N >> K >> P;
	//deque<int> card(K,0); // 正确初始化：先输入K再创建队列
	//for (int i = 1; i <= K; i++) {
	//	card[i - 1] = i; // 位置从1开始（非0）
	//}
	deque<int> card; // 正确初始化：先输入K再创建队列
	for (int i = 1; i <= K; i++) {
		card.push_back(i); // 位置从1开始（非0）
	}
	vector<int> bessieCards;
	//发牌
	for (int i = 1; i <= K; i++) {
		if(i % N == 0) {
			bessieCards.push_back(card.front());
		}
		card.pop_front();
		for (int j = 0; j < P && !card.empty(); j++) {
			int top = card.front();
			card.pop_front();
			card.push_back(top);
		}
	}
	sort(bessieCards.begin(), bessieCards.end());
	for (int pos : bessieCards) {
		cout << pos << endl;
	}
	return 0;
}



