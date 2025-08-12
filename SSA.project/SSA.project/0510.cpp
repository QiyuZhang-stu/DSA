#include<iostream>
#include<vector>
#include<sstream>
#include<string>

using namespace std;

vector<int> in;
vector<int> post;
vector<int> pre;
vector<int> index;
vector<int> l;
vector<int> r;

void input() {
	string line;
	getline(cin, line);
	stringstream ss(line);
	int num;
	while (ss >> num) {
		in.push_back(num);
	}
	getline(cin, line);
	ss.clear();
	ss.str(line);
	while (ss >> num) {
		post.push_back(num);
		index.push_back(num);
	}
}

int search(int x) {
	for (int i = 0; i < index.size(); i++) {
		if (index[i] == x) return i;
	}
	return -1;
}

void build(int in_start,int in_end,int post_start,int post_end) {
	if (in_start > in_end || post_start > post_end) return;
	int root_val = post[post_end];
	pre.push_back(root_val);
	int post_in = -1;
	for(int i = in_start; i <= in_end; i++) {
		if (in[i] == root_val) {
			post_in = i;
			break;
		}
	}
	int left_size = post_in - in_start;
	build(in_start, post_in - 1, post_start, post_start + left_size - 1);
	build(post_in + 1, in_end, post_start + left_size, post_end - 1);
}


int main() {
	input();
	build(0, in.size() - 1, 0, post.size() - 1);
	for (int i = 0; i < pre.size(); i++) {
		if (i > 0) cout << " ";
		cout << pre[i];
	}
	cout << endl;
	return 0;
}