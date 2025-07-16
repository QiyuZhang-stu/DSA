#include <iostream>
#include <vector>
#include <deque>

using namespace std;

vector<int> getMins(vector<int>& v, int k) {
    deque<int> dq;
    vector<int> res;
    for (int i = 0; i < v.size(); i++) {            // ��������ÿ��Ԫ��
        if (!dq.empty() && dq.front() <= i - k)    // �������Ƿ���ڣ�����������߽磩
            dq.pop_front();                        // �����򵯳�����
        while (!dq.empty() && v[dq.back()] >= v[i])// ά�������ԣ���β�ȵ�ǰֵ���򵯳�
            dq.pop_back();
        dq.push_back(i);                           // ��ǰ�±����β
        if (i >= k - 1)                            // �����γɺ�i��k-1ʱ��
            res.push_back(v[dq.front()]);          // ���׼���ǰ������Сֵ
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