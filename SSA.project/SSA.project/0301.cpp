#include <iostream>
#include <vector>
#include <deque>

using namespace std;

vector<int> getMins(vector<int>& v, int k) {
    deque<int> dq;
    vector<int> res;
    for (int i = 0; i < v.size(); i++) {            // 遍历数组每个元素
        if (!dq.empty() && dq.front() <= i - k)    // 检查队首是否过期（超出窗口左边界）
            dq.pop_front();                        // 过期则弹出队首
        while (!dq.empty() && v[dq.back()] >= v[i])// 维护单调性：队尾比当前值大则弹出
            dq.pop_back();
        dq.push_back(i);                           // 当前下标入队尾
        if (i >= k - 1)                            // 窗口形成后（i≥k-1时）
            res.push_back(v[dq.front()]);          // 队首即当前窗口最小值
    }
    return res;
}

vector<int> getMaxs(vector<int>& v, int k) {
    deque<int> dq;
    vector<int> res;
    for (int i = 0; i < v.size(); i++) {
        if (!dq.empty() && dq.front() <= i - k) dq.pop_front();
        while (!dq.empty() && v[dq.back()] <= v[i]) dq.pop_back();
        dq.push_back(i);
        if (i >= k - 1) res.push_back(v[dq.front()]);
    }
    return res;
}

int main() {
    int n, k, tmp;
    vector<int> v;
    cin >> n >> k;
    for (int i = 0; i < n; i++) {
        cin >> tmp;
        v.push_back(tmp);
    }

    vector<int> m = getMins(v, k);
    vector<int> M = getMaxs(v, k);

    for (int i = 0; i < m.size(); i++) {
        cout << (i ? " " : "") << m[i];
    }
    cout << '\n';
    for (int i = 0; i < M.size(); i++) {
        cout << (i ? " " : "") << M[i];
    }
    cout << '\n';
    return 0;
}