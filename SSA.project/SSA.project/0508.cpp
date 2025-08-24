#include<iostream>
#include<vector>
#include<sstream>

using namespace std;

struct TreeNode {
	int v;
	TreeNode* l;
	TreeNode* r;
	TreeNode(int x) :v{ x }, l{ NULL }, r{ NULL }{}
};

TreeNode* insert(TreeNode* root, int x) {
	if (root == NULL) return new TreeNode(x);
	if (x < root->v) root->l = insert(root->l, x);
	else if (x > root->v) root->r = insert(root->r, x);
	else return root;
}

void preorder(TreeNode* root, vector<int>& result) {
	if (root == NULL) return;
	result.push_back(root->v);
	preorder(root->l, result);
	preorder(root->r, result);
}

int main() {
	vector<int> result;
	int tmp;
	TreeNode* root = NULL;
	string line;
	getline(cin, line);  // 读取整行
	stringstream ss(line);
	while (ss >> tmp) {   // 从字符串流解析数字
		root = insert(root, tmp);
	}
	preorder(root, result);
	for (int x : result) {
		cout << x << " ";
	}
	return 0;
}