//以下是C++中`std::deque`（双端队列）的核心函数用法及初始化方式的全面说明，结合标准实现和最佳实践整理：
//
//
//
//### ?? * *一、初始化方法 * *
//| **方式 * *| **语法示例 * *| **说明 * *|
//|------------------------------ | -------------------------------------------- | --------------------------------------------------------------------------|
//| **默认构造 * *| `std::deque<int> dq; ` | 创建空`deque`，元素个数为0                                                |
//| **指定大小和初值 * *| `std::deque<int> dq(5, 10); ` | 创建含5个元素的`deque`，每个元素初始化为10                                 |
//| **列表初始化 * *(C++11起) | `std::deque<int> dq = { 1, 2, 3 }; ` | 直接通过初始化列表构造元素                                               |
//| **拷贝构造 * *| `std::deque<int> dq2(dq1); ` | 复制另一个`deque`的所有元素                                               |
//| **迭代器范围初始化 * *| `std::deque<int> dq(vec.begin(), vec.end()); ` | 通过其他容器（如`vector`）的迭代器范围构造 |
//
//-- -
//
//### ?? * *二、核心操作函数 * *
//#### 1. * *元素访问 * *
//-**随机访问 * *
//`dq[i]`：通过下标直接访问（不检查边界）
//`dq.at(i)`：访问位置`i`的元素，越界时抛出`std::out_of_range`异常
//- **首尾访问 * *
//`dq.front()`：返回首元素的引用
//`dq.back()`：返回尾元素的引用
//
//#### 2. * *增删元素 * *
//-**两端操作 * *（时间复杂度 * *O(1) * *）
//```cpp
//dq.push_back(100);  // 尾部插入元素
//dq.push_front(50);   // 头部插入元素
//dq.pop_back();       // 删除尾部元素
//dq.pop_front();      // 删除头部元素
//```
//- **中间操作 * *（时间复杂度 * *O(n) * *）
//```cpp
//dq.insert(dq.begin() + 2, 99);   // 在索引2处插入99
//dq.erase(dq.begin() + 1);       // 删除索引1处的元素
//```
//
//#### 3. * *容量管理 * *
//-**大小查询 * *
//`dq.size()`：返回当前元素数量
//`dq.empty()`：检查是否为空（返回布尔值）
//- **调整大小 * *
//`dq.resize(10)`：调整容器大小为10，新增元素默认初始化
//`dq.resize(8, 0)`：调整大小至8，新增元素初始化为0
//
//#### 4. * *其他操作 * *
//-**内容替换 * *
//`dq.assign({ 7, 8, 9 })`：用初始化列表替换所有元素
//`dq.assign(vec.begin(), vec.end())`：用迭代器范围替换内容
//- **清空与交换 * *
//`dq.clear()`：清空所有元素
//`dq1.swap(dq2)`：高效交换两个`deque`的内容（避免拷贝）
//
//-- -
//
//### ?? * *三、迭代器与遍历 * *
//| **迭代器类型 * *| **函数 * *| **用途 * *|
//|---------------------- | ------------------ | ------------------------------|
//| 正向迭代器 | `dq.begin()` | 指向首元素                   |
//|                      | `dq.end()` | 指向尾元素的下一个位置       |
//| 反向迭代器 | `dq.rbegin()` | 指向尾元素（反向遍历起点）   |
//|                      | `dq.rend()` | 指向首元素前的位置 |
//
//**遍历示例 * *：
//```cpp
//// 范围for循环（C++11起）
//for (const auto& elem : dq) {
//    std::cout << elem << " ";
//}
//
//// 迭代器遍历
//for (auto it = dq.begin(); it != dq.end(); ++it) {
//    std::cout << *it << " ";
//}
//```
//
//-- -
//
//### ?? * *四、注意事项 * *
//1. * *内存模型 * *：`deque`内部由多个分段连续的内存块组成，支持两端高效操作，但随机访问性能略低于`vector`。
//2. * *迭代器失效 * *：
//- 两端插入 / 删除操作可能使 * *所有迭代器失效 * *（但指针 / 引用仍有效）
//- 中间插入 / 删除操作会使 * *被修改位置之后的迭代器失效 * *。
//3. * *排序优化 * *：对`deque`排序时，建议先复制到`vector`排序后再复制回`deque`以提高性能。
//
//-- -
//
//### ?? * *五、适用场景 * *
//-**高频两端操作 * *：如任务调度队列（头部取任务，尾部追加新任务）。
//- **需随机访问的队列 * *：如缓存管理（需快速访问首尾及中间元素）。
//- **替代`std::queue`的底层容器 * *：`std::queue`默认使用`deque`实现。
//
//> 完整文档参考：[C++ std::deque 参考](https://en.cppreference.com/w/cpp/container/deque)。


//KMP算法
//#include <iostream>
//#include <vector>
//using namespace std;
//
//// 计算next数组
//vector<int> computeNext(string pattern) {
//    int m = pattern.size();
//    vector<int> next(m, 0);
//    int j = 0;
//    for (int i = 1; i < m; i++) {
//        while (j > 0 && pattern[i] != pattern[j])
//            j = next[j - 1];  // 回退至前一个匹配位置
//        if (pattern[i] == pattern[j])
//            j++;
//        next[i] = j;
//    }
//    return next;
//}
//
//// KMP匹配函数
//int kmpSearch(string text, string pattern) {
//    vector<int> next = computeNext(pattern);
//    int j = 0;  // 模式串指针
//    for (int i = 0; i < text.size(); i++) {
//        while (j > 0 && text[i] != pattern[j])
//            j = next[j - 1];  // 失配时回退j
//        if (text[i] == pattern[j])
//            j++;
//        if (j == pattern.size())
//            return i - j + 1;  // 返回匹配起始位置
//    }
//    return -1;
//}
//
//int main() {
//    string text = "ABAABABAC";
//    string pattern = "ABAAC";
//    int pos = kmpSearch(text, pattern);
//    cout << "匹配起始位置: " << pos << endl;  // 输出: 匹配起始位置: 5
//    return 0;
//}

