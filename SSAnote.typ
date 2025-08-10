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
= 数据结构与算法A笔记（以模块划分）
#v(3em)
#show heading.where(level:2):it => block(width:100%)[
  #set align(center)
  #set text(
    size:16pt,
    weight:"bold",
  )
  #it.body
]
== 第3章：栈与队列  
#v(2em)
#show heading.where(level:3):it => block(width:100%)[
  #set text(
    size:14pt,
    weight:"bold",
  )
  #it.body
]
=== 3.1 栈（运算只在表的一端进行）
#v(1em)
一.栈的定义

1.后进先出（LIFO）

2.栈的基本操作：入栈（push）、出栈（pop）、取栈顶元素（top）

3.应用：表达式求值，消除递归，DFS

二.栈的抽象数据类型
```cpp
template<class T>
class Stack {
public:
    void clear(); // 清空栈
    bool push(const T item); // 入栈，成功返回真
    bool pop(T& item); // 出栈，成功返回真，并将栈顶元素存入item
    bool top(T& item); // 取栈顶元素，成功返回真，并将栈顶元素存入item
    bool isEmpty(); // 判断栈是否为空
    bool isFull(); // 判断栈是否已满
};
```

三.火车进出栈问题

四.栈的实现

1.顺序栈：使用向量实现，顺序表的简化版

a.顺序栈的类定义
```cpp
template<class T>
class arrStack:public Stack<T> {
private:
    int mSize;// 栈的最大容量
    int top;//栈顶位置，应< mSize
    T* st;// 栈元素存储数组
public:
    arrStack(int size){
        mSize = size;
        top = -1; // 栈顶指针初始化为-1，表示栈为空
        st = new T[mSize]; // 动态分配数组
    }
    arrStack(){
        top=-1;
    }
    ~arrStack(){
        delete[] st; // 释放动态分配的数组
    }
    void clear() {
        top = -1; // 清空栈
    }
}
```
b.按压入先后次序，最后压入的元素编号为4，然后依次为3,2,1

c.顺序栈的溢出：
   - 当栈满时，无法再入栈，可能导致内存溢出或程序崩溃（上溢）
   - 对空栈进行出栈操作，可能导致访问非法内存（下溢）

d.压入栈顶
```cpp
bool arrStack<T>::push(const T item){
    if(top==mSize-1){
        cout<<"栈已满，无法入栈"<<endl;
        return false;
    }
    else{
        st[++top] = item; // 将元素压入栈顶
        return true;
    }
}
```
e.弹出栈顶
```cpp
bool arrStack<T>::pop(T& item){
    if(top==-1){
        cout<<"栈为空，无法出栈"<<endl;
        return false;
    }
    else{
        item = st[top--]; // 将栈顶元素存入item，并将栈顶指针下移
        return true;
    }
}
```

2.链式栈：用单链表存储，指针方向从栈顶向下链接

a.链式栈的创建
```cpp
template<class T>class lnkStack:public Stack<T> {
private:
    Link<T>* top; // 栈顶指针
    int size; // 栈的大小
public:
    lnkStack(int defSize) {
        top = NULL; // 初始化栈顶指针为空
        size = 0; // 栈的大小初始化为0
    }
    ~lnkStack() {
        clear(); // 析构时清空栈
    }
}
```
b.链式栈的入栈
```cpp
bool lnkStack<T>::push(const T item){
    Link<T>* tmp=new Link<T>(item,top); // 创建新节点，指向当前栈顶
    top = tmp; // 更新栈顶指针
    size++; // 栈大小增加
    return true; // 入栈成功
}
Link(const T info,Link* nextValue){
    data=info;
    next=nextValue;
}
```
c.链式栈的出栈
```cpp
bool lnkStack<T>::pop(T& item){
    Link<T>* tmp;
    if(size==0){
        cout<<"栈为空，无法出栈"<<endl;
        return false; // 栈为空，出栈失败
    }
    else{
        item = top->data; // 将栈顶元素存入item
        tmp = top; // 保存当前栈顶节点
        top = top->next; // 更新栈顶指针
        delete tmp; // 释放原栈顶节点
        size--; // 栈大小减少
        return true; // 出栈成功
    }
}
```
3.顺序栈和链式栈的比较
  -时间效率
    - 顺序栈：入栈和出栈操作时间复杂度均为O(1)
    - 链式栈：入栈和出栈操作时间复杂度均为O(1)
  - 空间效率
    - 顺序栈：空间利用率较低，可能浪费内存
    - 链式栈：空间利用率较高，动态分配内存，节省空间，但每个节点需要额外存储指针，增加了内存开销
    - 实际应用中，顺序栈更广泛

4.栈的应用
- 表达式求值：使用栈来存储操作数和操作符，按照运算优先级进行计算

  a.中缀表达式
  - 中缀表达式：操作符在操作数之间，如`4*x*(2*x+a)-c`

  b.后缀表达式
  - 后缀表达式：操作符在操作数之后，如`4 x * 2 x * a + * c -`

  c.后缀表达式求值
  - 循环：依次顺序读入表达式的符号序列（假设以＝作为输入序列
  的结束），并根据读入的元素符号逐一分析
  - 当遇到的是一个操作数，则压入栈顶
  - 当遇到的是一个运算符, 就从栈中两次取出栈顶，按照运算符对这两个操作数进行计算。然后将计算结果压入栈顶
  - 如此继续，直到遇到符号＝，这时栈顶的值就是输入表达式的值
  【例】#image("assets/逆波兰表达式.png")
  ```cpp
#include<iostream>
#include<string>
#include<stack>
#include<cctype>
using namespace std;
int main(){
    string s;
    cin>>s;
    stack<int> st;
    string tmp="";
    for(int i=0;i<s.size();i++){
        char c = s[i];
        if(c=='@') 
            break;
        if(isdigit(c))
            tmp+=c;
        else if(c=='.'){
            if(!tmp.empty()){
                st.push(stoi(tmp));
                tmp = "";
            }
        } 
        else if(c=='+' || c=='-' || c=='*' || c=='/'){
            int a=st.top();
            st.pop();
            int b=st.top();
            st.pop();
            int res;
            switch(c){
                case '+':
                    res = b + a;
                    break;
                case '-':
                    res = b - a;
                    break;
                case '*':
                    res = b * a;
                    break;
                case '/':
                    // if(a == 0) {
                    //     cout << "Error: Division by zero" << endl;
                    //     return 1; // Exit on division by zero
                    // }
                    res = b / a;
                    break;
            }
            st.push(res);
        }            
    }
    cout<<st.top()<<endl;
    return 0;
}
  ```
【关键点】1.边进栈边计算

#h(4.5em)2.>10数的合并操作

#h(1em)d.后缀计算器的类定义
  ```cpp
  class Calculator {
  private:
      Stack<double> s;
      bool GetTwoOperands(double& opd1, double& opd2);
      void Compute(char op);
  public:
      Calculator(){};
      void Run();
      void Clear();
  }


  template<class ELEM>
  bool Calculator<ELEM>::GetTwoOperands(ELEM& opd1, ELEM& opd2) {
      if (s.isEmpty()) {
          cout << "栈为空，无法获取操作数" << endl;
          return false;
      }
      opd1 = s.top(); // 获取栈顶元素
      s.pop(); // 弹出栈顶元素
      if (s.isEmpty()) {
          cout << "栈中只有一个操作数" << endl;
          return false;
      }
      s.pop(opd2); // 再弹出第一个操作数
      return true; // 成功获取两个操作数
  }


  template<class ELEM>
  void Calculator<ELEM>::Compute(char op) {
      bool result;
      ELEM opd1, opd2;
      result = GetTwoOperands(opd1, opd2);
      if(result==true)
            switch(op) {
                case '+':
                    s.push(opd2 + opd1);
                    break;
                case '-':
                    s.push(opd2 - opd1);
                    break;
                case '*':
                    s.push(opd2 * opd1);
                    break;
                case '/':
                    if (opd1 == 0) {
                        cout << "Error: Division by zero" << endl;
                        return; // Exit on division by zero
                    }
                    s.push(opd2 / opd1);
                    break;
                default:
                    cout << "Unknown operator: " << op << endl;
            }
        else s.ClearStack();
  }


  template <class ELEM> void Calculator<ELEM>::Run(void) { 
  char c; 
  ELEM newoperand; 
  while (cin >> c, c!= '=') { 
      switch(c) { 
          case '+': case '-': case '*': case '/': 
               Compute(c); 
               break; 
          default: 
               cin.putback(c); cin >> newoperand; 
               S.Push(newoperand); 
               break; 
      } 
  } 
  if (!S.IsEmpty()) 
      cout << S.Pop() << endl; // 印出求值的最后结果 
  } 
  ```
  e.中缀表达式转后缀表达式

#h(1.5em)\u{25B6} 当输入是操作数，直接输出到后缀表达式序列

#h(1.5em)\u{25B6} 当输入是左括号，压入栈顶

#h(1.5em)\u{25B6} 当输入的是运算符时： `WHile`

#set par(hanging-indent: 2em)  // 应用悬挂缩进
#h(2em)1.如果栈非空 and 栈顶不是左括号 and 
   输入运算符的优先级 "≤" 栈顶运算符的优先级, 
   将当前栈顶元素弹栈, 放到后缀表达式序列中 
   (此步反复循环, 直到上述 if 条件不成立); 
   将输入的运算符压入栈中。

#h(2em)2.否则把输入的运算符压栈（>当前栈顶运算符才压栈！）\

#h(1.5em)\u{25B6} 当输入是右括号时，先判断栈顶是否为空

#set par(hanging-indent: 2em)
#h(2em)1.如果栈顶为空，报错

#h(2em)2.如果非空，则把栈中的元素依次弹出，遇到第一个左括号为止，将弹出的元素输出到后缀表达式的序列中（弹出的
开括号不放到序列中）
若没有遇到开括号，说明括号也不匹配，做异常处理，清栈退出

#h(1.5em)\u{25B6} 最后，当中缀表达式的符号序列全部读入时，若栈内仍有元素，把它们全部依次弹
出，都放到后缀表达式序列尾部。–若弹出的元素遇到开括号时，则说明括号不匹配，做错误异常处理，清栈退出

#h(1em)【例】#image("assets/中缀到后缀的转换1.png")
#h(1em)#image("assets/中缀到后缀的转换2.png")
```cpp
#include<iostream>
#include<stack>
#include<string>
#include<vector>
#include<cctype>
using namespace std;

int grade(char op){
    if(op=='^')
        return 4;
    else if(op=='*'||op=='/')
        return 3;
    else if(op=='+'||op=='-')
        return 2;
    else if(op=='(')
        return 1;
    else
        return 0;
}

void cal(vector<string>& v){
    for(int i=0;i<v.size();i++){
        string c=v[i];
        if(c=="+"||c=="-"||c=="*"||c=="/"||c=="^"){
            int a=stoi(v[i-2]);
            int b=stoi(v[i-1]);
            int res;
            if(c=="+"){
                res=a+b;
            }
            else if(c=="-"){
                res=a-b;
            }
            else if(c=="*"){
                res=a*b;
            }
            else if(c=="/"){
                res=a/b;
            }
            else if(c=="^"){
                res=1;
                for(int j=0;j<b;j++){
                    res*=a;
                }
            }
            v[i-2]=to_string(res);
            v.erase(v.begin() + i - 1, v.begin() + i + 1);
            return;
        }
    }
}

int main() {
    stack<char> op;
    vector<string> all;
    string str;
    cin>>str;
    for(char c:str){
        if(isdigit(c)){
            all.push_back(string(1,c));
        }
        else if(c=='('){
            op.push(c);
        }
        else if (c == '+' || c == '-' || c == '*' || c == '/' || c == '^') {
            while (!op.empty() && op.top() != '(') {
                char top_op = op.top();
                if (grade(top_op) > grade(c) || (grade(top_op) == grade(c) && c != '^')) {  // 乘方右结合特判
                    all.push_back(string(1, op.top()));
                    op.pop();
                } 
                else break;
            }
            op.push(c);
        }
        else if(c==')'){
            if(!op.empty()){
                while(op.top()!='('){
                    all.push_back(string(1,op.top()));
                    op.pop();
                }
                op.pop(); // 弹出 '('
            }
        }
    }
    while(!op.empty()){
        all.push_back(string(1,op.top()));
        op.pop();
    }
    while(1){
        for (int i = 0; i < all.size(); i++) {
            cout << all[i];
            if (i < all.size() - 1) cout << " ";
        }
        cout << endl;
        if(all.size()==1) break;
        cal(all);
    }
    return 0;
}   
```
【关键点】1.`char`到`string`的转换`c->string(1,c)`

#h(6.5em)2.乘方右结合特判：```cpp if (grade(top_op) > grade(c) || (grade(top_op) == grade(c) && c != '^'))```

#h(6.5em)3.注意空栈问题易导致死循环
#v(1em)
- 消除递归：将递归转化为迭代，使用栈来模拟函数调用
- 深度优先搜索（DFS）：使用栈来存储访问的节点，实现图的遍历
#v(2em)
=== 3.2 队列（运算只在表的两端进行）
#v(1em)
一.队列的定义

1.先进先出（FIFO）

2.限制访问点的线性表

3.队头：`front` 队尾：`rear` 入队：`enQueue` 出队：`deQueue` 取队首：`getFront` 判空：`isEmpty`

二.队列的抽象数据结构
```cpp
template<class T> class Queue{
public:
    void clear();
    bool enQueue(const T item);
    bool deQueue(T& item);
    bool getFront(T& item);
    bool isEmpty();
    bool isFull();
};
```

三.队列的实现方式

1.顺序队列（关键在防止假溢出）

a.用向量存储队列元素，用两个变量分别指向
队列的前端(front)和尾端(rear)
#image("assets/顺序队列.png")
b.队列的溢出
- 上溢：当队列满时，再做进队操作
- 下溢：当队列空时，再做删除操作
- 假溢出：当 rear = mSize-1 时，再作插入运算就会产生溢出，如果这时队列的前端还有许多空位置，这种现象称为假溢出
c.循环队列的类定义：
```cpp
class arrQueue:public Queue<T>{
private:
    int mSize;
    int front;
    int rear;
    T* qu;
public:
    arrQueue(int size){
        mSize=size+1;// 浪费一个存储空间，以区别队列空和队列满
        qu=new T[mSize];
        front=rear=0;
    }
    ~arrQueue(){
        delete [] qu;
    }
};

bool arrQueue<T>::enQueue(const T item){
    if(((rear+1)%mSize)==front){
        cout << "队列已满，溢出" << endl;
        return false;
    }
    qu[rear]=item;
    rear=(rear+1)%mSize;
    return true;
}

bool arrQueue<T>::deQueue(T& item){
    if(front==rear){
        cout << "队列为空" << endl;
        return false;
    }
    item=qu[front];
    front=(front+1)%mSize;
    return true;
}
```

2.链式队列（用单链表方式存储，队列中每个元素对应链表中的一个结点）

a.链式队列的表示（链接指针的方向是从队列的前端向尾端链接）
#image("assets/链式队列.png")
b.链式队列的类定义
```cpp
template<class T>
class lnkQueue:public Queue<T>{
private:
    int size;
    Link<T>* front;
    Lint<T>* rear;
public:
    lnkQueue(int size);
    ~lnkQueue();
}

bool enQueue(const T item){
    if(rear==NULL){
        front=rear=new Link<T>(item,NULL);
    }
    else{
        rear->next=new Link<T>(item,NULL);
        rear=rear->next;
    }
    size++;
    return true;
}

bool deQueue(T* item){
    Link<T>* tmp;
    if(size==0){
        cout << "队列为空" << endl;
        return false;
    }
    *item=front->data;
    tmp=front;
    front=front->next;
    delete tmp;
    if(front==NULL)
        rear=NULL;
    size--;
    return true;
}
```

c.顺序队列与链式队列的比较
- 顺序队列 固定的存储空间
- 链式队列 可以满足大小无法估计的情况
- 都不允许访问队列内部元素

d.队列的应用
- 调度或缓冲
- BFS

e.农夫过河问题
#image("assets/人狼羊菜过河.png")
- 假定采用BFS解决农夫过河问题
   - 采用队列做辅助结构，把下一步所有可能达到的状态都放在队列中，然后顺序取出对其分别处理，处理过程中再把下一步的状态放在队列中
   - 数据抽象：起始岸位置：0，目标岸：1
   - 数据表示：整数 status表示上述四位二进制描述的状态
   - 算法抽象：从状态0000（整数0）出发，寻找全部由安全状态构成的状态序列，以状态1111（整数15）为最终目标。状态序列中每个状态都可以从前一状态通过农夫（可以带一样东西）划船过河的动作到达。序列中不能出现重复状态
   - 算法设计：
   ```cpp
   void solve(){
        int movers,i,location,newlocation;
        vector<int> route(END+1,-1); //记录已考虑的状态路径
        queue<int> moveTo;
        moveTo.push(0x00);// 相当于enQueue
        route[0]=0;
   }

   while(!moveTo.empty()&&route[15]==-1){
        status=moveTo.front();//得到现在的状态
        moveTo.pop();//相当于deQueue
        for(movers=1;movers<=8;movers<<=1){
             //农夫总是在移动，随农夫移动的也只能是在农夫同侧的东西
             if(farmer(status)==(bool)(status&movers)){
                 newstatus =status ^(0x08|movers);
                 if(safe(newstatus)&&(route[newstatus]==-1)){
                        route[newstatus]=status;
                        moveTo.push(newstatus);}
                 }
             }
        }
   }

   // 反向打印出路径
if (route[15] != -1) { 
    cout<<"The reverse path is :" << endl;
    for (intstatus = 15; status >= 0; status = route[status]) {
        cout<< "The status is : “ << status << endl;
        if(status == 0) break;
    }
}
else
    cout<< "No solution.“ << endl;
   ```
e.栈和队列的相互模拟
#v(2em)
=== 3.3 栈的应用：递归到非递归
#v(1em)
一.简单的递归转换

1.【例】阶乘
- 递归：
```cpp
int f(int n){
    if(n<=0)
        return 1;
    return n*f(n-1);
}
```

- 非递归：
```cpp
int f(int n){
    int m=1;
    for(int i=1;i<=n;i++)
        m*=i;
    return m;
}
```

- 尾递归：
```cpp
int f(int n,int x){
    if(n<=0)
        return x;
    return f(n-1,x*n);
}
```

2.一类特殊的递归函数—尾递归
- 指函数的最后一个动作是调用函数本身的递归函数，是递归的一种特殊情形 
- 尾递归的本质是：将单次计算的结果缓存起来，传递给下次调用，相当于自动累积
- 计算仅占用常量栈空间
- 命令式语言：编译器可以对尾递归进行优化，没有必要存储函数调用栈信息，不会出现栈溢出 （例如 gcc –O2）
- 函数式语言：靠尾递归来实现循环

3.函数运行时的动态内存分配
- stack：函数调用
- heap(堆)：指针所指向空间的分配、全局变量

二.递归函数调用原理

1.函数调用及返回的步骤
- 调用
  - 保存调用信息（参数，返回地址）
  - 分配数据区（局部变量）
  - 控制转移给被调函数的入口
- 返回
  - 保存返回信息
  - 释放数据区
  - 控制转移到上级函数（主调用函数）
2.递归的实现
- 一个问题能否用递归实现，看其是否具有下面特点
  - 有递推公式（1个或多个）
  - 有递归结束条件（1个）
- 编写递归函数时，程序中必须有相应的语句
  - 一个（或者多个）递归调用语句
  - 测试结束语句
  - 先测试，后递归调用
- 递归程序的特点
  - 易读、易编，但占用额外内存空间
3.函数运行时的存储分配
- 静态分配
  - 在非递归情况下，数据区的分配可以在程序运行前进行，一直到整个程序运行结束才释放，这种分配称为静态分配
  - 采用静态分配时，函数的调用和返回处理比较简单，不需要每次分配和释放被调函数的数据区
- 动态分配
  - 在递归（函数）调用的情况下，被调函数的局部变量不能静态地分配某些固定单元，而必须每调用一次就分配一份，以存放当前所使用的数据，当返回时随即释放。【大小不确定，值不确定】
  - 动态分配在内存中开辟一个称为运行栈的足够大的动态区
4.动态存储分配
#image("assets/动态内存分配.png")
5.运行栈中的活动记录
- 函数活动记录是动态存储分配中的基本单元
  - 当调用函数时，函数的活动记录包含为其局部数据分配的存储空间
- 运行栈随着程序执行时发生的调用链或生长或缩小
  - 每次调用执行进栈操作，把被调函数的活动信息压入栈顶
  - 函数返回执行出栈操作，恢复到上次调用所分配的数据区
- 一个函数在运行栈上可以有若干不同的活动记录，每个都代表了一个不同的调用
  - 递归深度决定运行栈中活动记录的数目
  - 同一局部变量在不同的递归层次被分配给不同的存储空间

三.机械的递归转换

1.递归转非递归的通用方法
- 1. 设置一工作栈保存当前工作记录
```cpp
enumrdType{0, 1, 2}; //对应三种返回情况
public class knapNode{
    int s, n;         // 背包容量和物品数目
    rdType rd;    // 返回情况标号
    bool k;           // 结果单元
};
```
- 2. 设置 t+2个语句标号
  - label 0: 第一个可执行语句
  - label t+1: 设置在函数体结束处
  - label i (1 <= i <= t): 第i个递归返回处

- 3. 增加非递归入口
```cpp
Stack<knapNode> stack;
knapNodetmp;
tmp.s= s; tmp.n= n, tmp.rd = 0;
stack.push(tmp);    // 入栈
```
- 4. 替换第 i (i = 1, …, t)个递归规则
  - 若函数体第i (i=1, ..., t)个递归调用语句形如recf(a1, a2, …, am)；则用以下语句替换：
  - 并增加标号为i的退栈语句
```cpp
S.push(i, a1, ..., am);
goto label0;

label i: S.pop(&x); 
//根据取值x进行相应的返回处理
```
- 5. 所有递归出口处增加语句：
```cpp
goto label t+1;
```
- 6. 标号为t+1的语句的格式
```cpp
S.pop(&tmp);
switch (tmp.rd) {
case 0: return;
case 1: gotolabel1; break;
// ……
cast t: gotolabelt; break;
default: break;
}
```
- 7. 改写循环和嵌套中的递归
- 8. 优化处理

2.[简化的0-1背包问题] 我们有n件物品，物品i的重量为w[i] 。如果限定每种物品
（0）要么完全放进背包（1）要么不放进背包；即物品是不可分割的。问：
能否从这n件物品中选择若干件放入背包，使其重量之和恰好为s
```cpp
bool knap(int s,int n){
    if(s==0)
        return true;
    if((s<0)||(s>0&&n<1))
        return false;
    if(knap(s-w[n-1],n-1)){
        cout<<w[n-1];
        return true;
    }
    else
        return knap(s,n-1);
}
```
#v(3em)
==  第4章：字符串
#v(2em)
=== 4.1 字符串的基本概念
#v(1em)
一.最基本定义

1.特殊的线性表，即元素为字符的线性表

2.$n(>=0)$ 个字符的有限序列，
一般记作 $S:c_0 c_1 c_2...c_(n-1)$，$S$是串名，$c_0 c_1 c_2...c_(n-1)$是串值，$c_i$是串中字符，$n$是串长

二.字符/符号

1.字符(char) ：组成字符串的基本单位

2.取值依赖于字符集Σ（同线性表，结点的有限集合）

三.字符编码：单字节（8 bits）

- 用 ASCII 码对 128 个符号进行编码
- 其他编码方式： UNICODE...

四.处理子串的函数

1.子串（被包含）
- 空串是任意串的子串
- 真子串：非空且不为自身的子串
2.函数
#image("assets/字符串函数.png")

五.字符串中的字符

1.重载下标运算符[ ]
```cpp
char& string::operator[](int n);
```
2.按字符定位下标
```cpp
int string::find(char c,int start=0);
```
3.反向寻找，定位尾部出现的字符
```cpp
int string::rfind(char c,int pos=0);
```
#v(2em)
=== 4.2 字符串的存储结构
#v(1em)
一.字符串的顺序存储

1.处理方案
- 用 S[0] 作为记录串长的存储单元 (Pascal)
    -  缺点：限制了串的最大长度不能超过256
- 为存储串的长度，另辟一个存储的地方
    - 缺点：串的最大长度一般是静态给定的，不是动态申请数组空间
- 用一个特殊的末尾标记 `'\0'` (C/C++) 
2.早期：顺序，链接，索引

二·字符串类的存储结构
```cpp
private:
char* str;
int size;
```
#image("assets/字符串存储例子.png")

三.串的运算实现
```cpp
int strcmp(char* d,char* s){
    int i;
    for(int i=0;d[i]==s[i];i++){
        if(d[i]=='\0'&&s[i]=='\0')
            return 0;
    }
    return (d[i]-s[i])/abs(d[i]-s[i]);
}
```
#v(2em)
=== 4.4 字符串的模式匹配
#v(1em)
一.模式匹配

1.定义：在目标T中寻找一个给定的模式P的过程

2.应用：文本编辑时的特定词，句的查找，DNA 信息的提取

3. 用给定的模式 P，在目标字符串 T 中搜索与模式 P 全同的一个子串，并求出 T 中第一
个和 P 全同匹配的子串（简称为“配串”）,返回其首字符位置

二.朴素算法

1.穷举法
```cpp
int Findpat(string T,string P,int startindex){
    for(int g=startindex;g<=T.length()-P.length();g++){
        for(int j=0;((j<P.length())&&(T[g+j]==P[j]));j++)
            if(j==P.length())
                return g;
    }
    return -1;
}
```
2.效率分析:假定目标 T 的长度为 n，模式 P
长度为 m（m≤n），在最坏的情况下，每一次循环都不成功，则一共要进行比较（n-m+1）次,每一次“相同匹配”比较所耗费的时间，是 P 和 T 
逐个字符比较的时间，最坏情况下，共 m 次– 因此，整个算法的最坏时间开销估计为
$O( m*n )$
 
三.KMP算法

1.简介：一种高效字符串匹配算法，通过预处理模式串生成next数组（部分匹配表），在匹配失败时跳过无效比较，将时间复杂度优化至O(n+m)（n为主串长度，m为模式串长度）

2.next数组
- 定义​：next[i]表示模式串P[0..i]中，​最长相等真前缀和真后缀的长度​（不包括子串本身）
- 作用​：当匹配失败时，根据next值移动模式串指针，避免主串回溯
- 构建逻辑
    - P[0]：无前缀/后缀，next[0]=0
    - P[1..8]：若P[i] == P[j]，则j++；否则j = next[j-1]回退
【例】#image("assets/字符串匹配.png")
解：```cpp

```
【例】#image("assets/KMP模板1.png")#image("assets/KMP模板2.png")
解：```cpp

```
#v(3em)
==  第5章：二叉树
#v(2em)
=== 5.1 二叉树的概念
#v(1em)
一·定义：二叉树(binary tree)由结点的有限集合构成，这个有限集合或者为空集(empty)，或者为由一个根结点(root)及两棵互不相交、分别称作这个根的左子树(left subtree)和右子树(right subtree)的二叉树组成的集合

二·五种基本形态

三·术语

1.结点
- 子结点、父结点、最左子结点
- 兄弟结点、左兄弟、右兄弟
- 分支结点、叶结点
  - 没有子树的结点称作 叶结点（或树叶、终端结点）
  -  非终端结点称为分支结点

2.边：两个结点的有序对

3.路径、路径长度
- 除结点 k0外的任何结点 k∈K，都存在一个结点序列 k0，k1，…，ks，使得 k0 就是树根，且 ks=k，其中有序对 $<k_i-1,k_i>$ ∈ r  (1≤i≤s) 。这样的结点序列称为从根到结点 k 的一条路径，其路径长度为 s (包含的边数)

4.祖先，后代
- 若有一条由 k 到达 ks的路径，则称k 是 ks的祖先，ks是 k 的子孙 

5.层数
- 根为第 0 层，其他结点的层数等于其父结点的层数加 1

6.深度
- 层数最大的叶结点的层数

7.高度
- 层数最大的叶结点的层数加 1

8.满二叉树
- 一棵二叉树的任何结点，或者是树叶，或者恰有两棵非空子树

9.完全二叉树
- 最多只有最下面的两层结点度数可以小于2，且最下一层的结点都集中最左边

10.扩充二叉树
- 所有空子树，都增加空树叶，
- 外部路径长度 E 和内部路径长度 I 满足：E = I + 2n (n 是内部结点个数)

四·主要性质

1.一棵二叉树，若其终端结点数为 $n_0$，度为2的结点数为$n_2$，
则 $n_0=n_2+1$

证：设总边数A，总结点数B，节点分为$n_0,n_1,n_2$则$B=A-1=n_0+n_1+n_2-1$，而$B=n_1+2 n_2$，联立即得

2.满二叉树定理：非空满二叉树树叶数目等于其分支结点数加1

证：满二叉树要求所有分支结点（非叶结点）的度均为 2（即不存在度为 1 的结点），故$n_2=n_b$

3. 满二叉树定理推论：一个非空二叉树的空子树数目（空指针数）等于其结点数加1

4.有n个结点（n>0）的完全二叉树的高度为 $log_2(n+1)$ 

#v(2em)
=== 5.2 二叉树的抽象数据类型
#v(1em)
一·抽象数据类型

1.逻辑结构 + 运算
- 针对整棵树
  - 初始化二叉树
  - 合并两棵二叉树
- 围绕结点
  - 访问某个结点的左子结点、右子结点、父结点
  - 访问结点存储的数据
```cpp
template<class T>
class BinaryTreeNode{
friend class BinaryTree<T>;// 声明二叉树类为友元类
private:
    T info;// 二叉树结点数据域
public:
    BinaryTreeNode(); // 缺省构造函数
    BinaryTreeNode(const T& ele); // 给定数据的构造
    BinaryTreeNode(const T& ele,BinaryTreeNode<T>* l,BinaryTreeNode<T>* r);// 子树构造结点
    T value() const;// 返回当前结点数据
    BinaryTreeNode<T>* leftchild() const;// 返回左子树
    void setLeftchild(BinaryTreeNode<T>*); // 设置左子树
    void setRightchild(BinaryTreeNode<T>*); // 设置右子树
    void setValue(const T& val); // 设置数据域
    bool isLeaf() const; // 判断是否为叶结点
    BinaryTreeNode<T>& operator =(const BinaryTreeNode<T>& Node);// 重载赋值操作符 
}

template <class T>
class BinaryTree {
private:
BinaryTreeNode<T>* root; // 二叉树根结点     
public:
BinaryTree() {root = NULL;};  
~BinaryTree(){DeleteBinaryTree(root);};
bool isEmpty() const;// 判定二叉树是否为空树
BinaryTreeNode<T>* Root() {return root;}; // 返回根结点
};

BinaryTreeNode<T>* Parent(BinaryTreeNode<T>* current);     // 返回父
BinaryTreeNode<T>* LeftSibling(BinaryTreeNode<T> *current);// 左兄
BinaryTreeNode<T>* RightSibling(BinaryTreeNode<T> *current); // 右兄
void CreateTree(const T& info,
BinaryTree<T>& leftTree, BinaryTree<T>&  rightTree);    // 构造新树
void PreOrder(BinaryTreeNode<T> *root);    // 前序遍历二叉树或其子树
void InOrder(BinaryTreeNode<T> *root);      
// 中序遍历二叉树或其子树
void PostOrder(BinaryTreeNode<T> *root);   // 后序遍历二叉树或其子树
void LevelOrder(BinaryTreeNode<T> *root);  // 按层次遍历二叉树或其子树
void DeleteBinaryTree(BinaryTreeNode<T> *root); // 删除二叉树或其子树
```

二·DFS遍历二叉树
- 前序法：访问根结点；按前序遍历左子树；按前序遍历右子树
- 中序法：按中序遍历左子树；访问根结点；按中序遍历右子树
- 后序法：按后序遍历左子树；按后序遍历右子树；访问根结点
#image("assets/DFS遍历二叉树.png")
#image("assets/表达式二叉树.png")
- 递归遍历
```cpp
template<class T>
void BinaryTree<T>::DepthOrder(BinaryTree<T>* root){
    if(root!=NULL){
        Visit(root);//前序
        DepthOrder(root->leftchild()); // 递归访问左子树
        Visit(root);//中序
        DepthOrder(root->leftchild());// 递归访问右子树
        Visit(root);//后序
    }
}
```
【例】已知某二叉树的中序序列为 ${A, B, C, D, E, F, G}$,后序序列为 ${B, D, C, A, F, G, E}$；则其前序序列为何？

解：#image("assets/中后序推前序.png")
- 非递归算法（用栈模拟）
  - 前序：遇到一个结点，就访问该结点，并把此结点的非空右结点推入栈中，然后下降去遍历它的左子树；遍历完左子树后，从栈顶托出一个结点，并按照它的右链接指示的地址再去遍历该结点的右子树结构
  ```cpp
  template<class T> 
  void BinaryTree<T>::PreOrderWithoutRecusion(BinaryTree<T>* root){
    using std::stack;
    stack<BinaryTree<T>*> aStack;
    BinaryTree<T>* pointer=root;
    aStack.push(NULL);
    while(pointer){
        Visit(pointer->value());
        if(pointer->rightchild()!=NULL)
            aStack.push(pointer->rightchild());
        if(pointer->leftchild()!=NULL)
            aStack.push(pointer->leftchild());
        else{
            pointer=aStack.top();
            aStack.pop();
        }
    }
  }
  ```
  - 中序：遇到一个结点，把它推入栈中，遍历其左子树；遍历完左子树，从栈顶托出该结点并访问之，按照其右链地址遍历该结点的右子树
  ```cpp
  template<class T>
  void BinaryTree<T>::InOrderWithoutRecusion(BinaryTreeNode<T>* root){
    using std::stack;
    stack<BinaryTreeNode<T>*> aStack;
    BinaryTreeNode<T>* pointer=root;
    while(!aStack.empty()||pointer){
        if(pointer){
            aStack.push(pointer);
            pointer=pointer->leftchild();
        }
        else{
            pointer=aStack.top();
            aStack.pop();
            pointer=pointer->rightchild();
        }
    }
  }
  ```
  - 后序：给栈中元素加上一个特征位，Left 表示已进入该结点的左子树，将从左边回来；Right 表示已进入该结点的右子树，将从右边回来
  ```cpp
  enum Tags{Left,Right};
  template<class T>
  class StackElement{
  public:
    BinaryTreeNode<T>* pointer;
    Tags tag;
  };
  template<class T>
  void BinaryTree<T>::PostOrderWithoutRecusion(BinaryTreeNode<T>* root){
    using std::stack;
    StackElement<T> element;
    stack<StackElement<T>> aStack;
    BinaryTreeNode<T>* pointer;
    pointer=root;
    while(!aStack.empty()||pointer){
        while(pointer!=NULL){
            element.pointer = pointer;  
            element.tag = Left;
            aStack.push(element); 
            pointer = pointer->leftchild();
        }
        element = aStack.top();  
        aStack.pop();
        pointer = element.pointer;
        if (element.tag == Left) {
            element.tag = Right; 
            aStack.push(element); 
            pointer = pointer->rightchild();
        }
        else { 
            Visit(pointer->value());      
            pointer = NULL;     
        }
    }
  }
  ```
- 二叉树遍历算法的空间代价分析
  - 深搜：栈的深度与树的高度有关，最好$O(log n)$；最坏$O(n)$
三·BFS遍历二叉树
1.
```cpp
void BinaryTree<T>::LevelOrder(BinaryTreeNode<T>* root){
    using std::queue;
    queue<BinaryTreeNode<T>*> aQueue;
    BinaryTreeNode<T>* pointer=root;
    if(pointer)
        aQueue.push(pointer);
    while(!aQueue.empty()){
        pointer=aQueue.front();
        aQueue.pop();
        Visit(pointer->value());
        if(pointer->leftchild())
            aQueue.push(pointer->leftchild());
        if(pointer->rightchild())
            aQueue.push(pointer->rightchild());
    }
}
```
- 时间代价分析：$O(n)$
- 时间代价分析：最好$O(1)$；最坏$O(n)$
#v(2em)
=== 5.3 二叉树的存储结构
#v(1em)
一·链式存储结构（二叉树的各结点随机地存储在内存空间中，结点之间的
逻辑关系用指针来链接）

1.二叉链表
- 指针 left 和 right，分别指向结点的左孩子和右孩子
#image("assets/二叉链表.png")
2.三叉链表 
#image("assets/三叉链表.png")
3.BinaryTreeNode类中增加两个私有数据成员
```cpp
private:
    BinaryTreeNode<T> *left; 
    BinaryTreeNode<T> *right; 
```
4.递归框架寻找父结点——注意返回
```cpp
template<class T>
BinaryTreeNode<T>* BinaryTree<T>::Parent(BinaryTreeNode<T>* rt,BinaryTreeNode<T>* current){
    BinaryTreeNode<T>* tmp;
    if(rt==NULL)
        return (NULL);
    if(current==rt->leftchild()||current==rt->rightchild())
        return rt;
    if ((tmp =Parent(rt- >leftchild(), current) != NULL)
        return tmp;
    if ((tmp =Parent(rt- > rightchild(), current) != NULL)
        return tmp;
    return NULL;
}
```
5.非递归框架找父结点
```cpp
BinaryTreeNode<T>* BinaryTree<T>::Parent(BinaryTreeNode<T> *current)  {
    using std::stack;
    stack<BinaryTreeNode<T>*> aStack;
    BinaryTreeNode<T>* pointer = root;
    aStack.push(NULL); 
    while (pointer) {  
        if (current == pointer->leftchild() || current == pointer->rightchild())
            return pointer; 
        if (pointer->rightchild() != NULL)    
            aStack.push(pointer->rightchild());
        if (pointer->leftchild() != NULL)
            pointer = pointer->leftchild();    
        else {  
            pointer=aStack.top(); 
            aStack.pop();   
        }
    }
}
```
6.空间开销分析
- 存储密度$alpha(<=1)$表示数据结构存储的效率，$alpha=$数据本身存储量/整个结构占用的存储总量
- 结构性开销$gamma=1-alpha$
- 每个结点存两个指针，一个指针域
  - 总空间：$(2 p+d) n$
  - 结构性开销：$2 p n$
-  C++ 可以用两种方法来实现不同的分支与叶结点：
  - 用union联合类型定义
  - 使用C++的子类来分别实现分支结点与叶结点，并采用虚函数isLeaf来区别分支结点与叶结点
- 早期节省内存资源:
  - 利用结点指针的一个空闲位（一个bit）来标记结点所属的类型
  - 利用指向叶的指针或者叶中的指针域来存储该叶结点的值
7.完全二叉树的下标公式（易推）
#v(2em)
=== 5.4 二叉搜索树（BST）
#v(1em)
一·基本概念

1.定义：或者是一棵空树；或者是具有下列性质的二叉树：对于任何一个结点，设其值为K； 则该结点的 左子树(若不空)的任意一个结点的值都 小于 K；该结点的 右子树(若不空)的任意一个结点的值都 大于 K；而且它的左右子树也分别为BST

2.性质： 中序遍历是正序的（由小到大的排列）

3.功能：
- 检索
#image("assets/BST检索.png")
- 插入
#image("assets/BST插入.png")
#v(2em)
- 删除
  - 度为0：直接删除
  - 度为1：用其子节点替代自身
  - 度为2：

  a.​寻找替代节点​：
    - ​后继节点​：目标节点右子树中的最小节点​（即右子树的最左节点）。
    - 前驱节点​：目标节点左子树中的最大节点​（即左子树的最右节点）。
    - 任选一种方式，通常使用后继节点
  b.​替换与删除​：
    - 将目标节点的值替换为后继/前驱节点的值。递归删除右子树（或左子树）中的后继/前驱节点（此时该节点必为叶子或单子节点，转为情况 1 或 2）。 
4.总结
- 组织内存索引
  - 适用于内存储器，常用红黑树、伸展树等，以维持平衡
  - 外存常用B/B+树
- 保持性质 vs 保持性能
=== 5.5 堆与优先队列
#v(1em)
一·堆

1.最小堆定义：对任意节点，其值小于或等于其子节点的值的完全二叉树

2.性质
- 完全二叉树的层次序列，可以用数组表示
- 堆中储存的数是局部有序的，堆不唯一
- 从逻辑角度看，堆实际上是一种树形结构

3.类定义
```cpp
template<class T>
class MinHeap{
private:
    T* heapArray;
    int CurrentSize;
    int MaxSize;
    void BuildHeap();
public:
    MinHeap(const int n);
    virtual ~MinHeap(){delete []heapArray;};
    bool isLeaf(int pos)const;
    int leftchild(int pos)const;
    int rightchild(int pos)const;
    int parent(int pos)const;
    bool Remove(int pos,T& node);
    bool Insert(const T& newNode);
    T& RemoveMin();
    void SiftUp(int position);
    void SiftDown(int left);
}
```
4.对最小堆用筛选法SiftDown调整
```cpp
template<class T>
void MinHeap<T>::SiftDown(int position){
    int i=position;
    int j=2*i+1;
    int Ttemp=heapArray[i];
    while (j < CurrentSize) {
        if((j < CurrentSize-1)&&(heapArray[j] > heapArray[j+1]))
            j++;  // j指向数值较小的子结点
        if (temp > heapArray[j]) {
            heapArray[i] = heapArray[j];
            i = j;
            j = 2*j + 1;    // 向下继续
        }
        else break;
    }
    heapArray[i]=temp;
}
```
5.对最小堆用筛选法 SiftUp 向上调整
```cpp
template<class T>
void MinHeap<T>::SiftUp(int position){
    int temppos=position;
    T temp=heapArray[temppos];
    while((temppos>0) && (heapArray[parent(temppos)] > temp))   {
        heapArray[temppos]=heapArray[parent(temppos)];
        temppos=parent(temppos);
    }
    heapArray[temppos]=temp;
}
```
6.建最小堆过程
- 方法
#image("assets/建最小堆之自底向上法.png")
#image("assets/建最小堆之动态构建法.png")
- 操作
  - 删除特定元素
  - 插入特定元素
- 建堆效率分析
  - 建堆算法时间代价：$O(n)$
#image("assets/建堆效率分析.png")
  - 插入结点、删除普通元素和删除最小元素的平均时间代价和最差时间代价都是$O(log(n))$

7.堆的应用
- 优先队列：堆的应用之一，支持插入、删除最小元素、查找最小元素等操作
- 堆排序：利用堆的性质进行排序，时间复杂度为$O(n log n)$
- 图算法：Dijkstra算法、Prim算法等都使用堆来优化性能    
#v(2em)
=== 5.6 Huffman树及其应用
#v(1em)
一·等长编码

1.定义：每个字符的编码长度相同的编码方式

2.包括：ASCII码、中文编码等

3.表示n个不同字符需要 $n$ 个二进制码字，长度为 $log_2(n)$ 位

二·数据压缩与不等长编码

1.特点：可以利用字符的出现频率来编码， 经常出现的字符的编码较短，不常出现的字符编码较长

2.优点：数据压缩既能节省磁盘空间，又能提高运算速度

三·前缀编码

1.定义：任何一个字符的编码都不是另外一个字符编码的前缀

2.特点：前缀编码可以唯一地表示一个字符串，且不会产生歧义

四·Huffman树与前缀编码

1.建立Huffman树
-  首先，按照“权”(例如频率)将字符排为一列
- 然后，选择权值最小的两个结点作为左右子树，构造一个新结点，其权值为两子树权值之和
- 重复上述过程，直到所有结点合并为一棵树
#image("assets/huffman树.png")

2.译码
- 从左至右逐位判别代码串，直至确定一个字符
- 译出了一个字符，再回到树根，从二进制位串中的下一位开始继续译码
```cpp

```
3.huffman性质
- 含有两个以上结点的一棵 Huffman 树中，字符使用频率最小的两个字符是兄弟结点，而且其深度不比树中其他任何叶结点浅
- 对于给定的一组字符，函数HuffmanTree实现了“最小外部路径权重”

4.Huffman树编码效率
#image("assets/huffman树效率分析.png")

5.应用
- 数据压缩：如ZIP、RAR等文件压缩格式
- 图像压缩：如JPEG图像格式
- 音频压缩：如MP3、AAC等音频格式
#v(3em)
==  第6章：树
#v(2em)
=== 6.1 
#v(1em)
一·定义：二叉树(binary tree)由结点的有限集合构成，这个有限集合或者为空集(empty)，或者为由一个根结点(root)及两棵互不相交、分别称作这个根的左子树(left subtree)和右子树(right subtree)的二叉树组成的集合

二·五种基本形态





