#set page(
  paper:"a4",
  margin:(top:2cm, bottom:2cm, left:2cm,right:2cm),
)
#set text(font:"SimSun",size:12pt)
#show heading.where(level:1):it => block(width:100%)[
  #set align(center)
  #set text(
    size:18pt,
    weight:"bold",
  )
  #it.body
]
= 算法笔记
#v(3em)
1.滑动窗口极值
`
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
`