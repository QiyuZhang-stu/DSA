#include<iostream>
#include<vector>
#include <string>

using namespace std;

vector<string> pre_res, in_res, post_res;

struct Node {
	char v;
	Node* l;
	Node* r;
	Node(char v) :v{ v }, l{ NULL }, r{ NULL } {}
};

void preorder(Node* root) {
	if (!root) return;
	pre_res.push_back(string(1, root->v));
	preorder(root->l);
	preorder(root->r);
}

void inorder(Node* root) {
	if (!root) return;
	inorder(root->l);
	in_res.push_back(string(1, root->v));
	inorder(root->r);
}

void postorder(Node* root) {
	if (!root) return;
	postorder(root->l);
	postorder(root->r);
	post_res.push_back(string(1, root->v));
}

int main() {
	int n;
	cin >> n;
	string line;
	getline(cin, line); // ³Ôµô»»ÐÐ
	for (int i = 0; i < n; i++) {
		vector<pair<int, string>> lines;
		while (true) {
			getline(cin, line);
			if (line == "0") break;
			int level = 0;
			while (level < line.size() && line[level] == '-') level++;
			string content = line.substr(level);
			lines.push_back({ level,content });
		}
		Node* root = NULL;
		vector<Node*> lastAtLevel(105, NULL);
		vector<bool> expectRight(105, false);
		for (auto [level, content] : lines) {
			if (content == "*") {
				Node* parent = lastAtLevel[level - 1];
				if (parent) {
					expectRight[level - 1] = true;
				}
				continue;
			}
			Node* cur = new Node(content[0]);
			if (level == 0) {
				root = cur;
			}
			else {
				Node* parent = lastAtLevel[level - 1];
				if (parent) {
					if (!parent->l && !expectRight[level - 1]) {
						parent->l = cur;
					}
					else {
						parent->r = cur;
						expectRight[level - 1] = false;
					}
				}
			}
			lastAtLevel[level] = cur;
		}
		pre_res.clear();
		in_res.clear();
		post_res.clear();
		preorder(root);
		postorder(root);
		inorder(root);

		for (auto& s : pre_res) cout << s;
		cout << "\n";
		for (auto& s : post_res) cout << s;
		cout << "\n";
		for (auto& s : in_res) cout << s;
		cout << "\n";
		if (i != n - 1) cout << "\n";
	}
	return 0;
}