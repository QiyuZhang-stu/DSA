//�ܽ᣺
// 1. ע��deque�ĳ�ʼ����ʽ��������K�ٴ������У�
// 2. ʹ��deque��push_front��pop_front������ģ�ⷢ�ƹ���
// 3. ʹ��vector�洢Bessie���ƣ������������������



#include<iostream>
#include<deque>
#include<vector>
#include <algorithm>

using namespace std;

int main() {
	//input
	int N, K, P;
	cin >> N >> K >> P;
	//deque<int> card(K,0); // ��ȷ��ʼ����������K�ٴ�������
	//for (int i = 1; i <= K; i++) {
	//	card[i - 1] = i; // λ�ô�1��ʼ����0��
	//}
	deque<int> card; // ��ȷ��ʼ����������K�ٴ�������
	for (int i = 1; i <= K; i++) {
		card.push_back(i); // λ�ô�1��ʼ����0��
	}
	vector<int> bessieCards;
	//����
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



