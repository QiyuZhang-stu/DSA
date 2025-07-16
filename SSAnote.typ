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
`
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
`

三.火车进出栈问题

四.栈的实现

1.顺序栈：使用向量实现，顺序表的简化版

a.顺序栈的类定义
`
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
`
b.按压入先后次序，最后压入的元素编号为4，然后依次为3,2,1

c.顺序栈的溢出：
   - 当栈满时，无法再入栈，可能导致内存溢出或程序崩溃（上溢）
   - 对空栈进行出栈操作，可能导致访问非法内存（下溢）

d.压入栈顶
`
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
`
e.弹出栈顶
`
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
`

2.链式栈：用单链表存储，指针方向从栈顶向下链接

a.链式栈的创建
`
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
`
b.链式栈的入栈
`
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
`
c.链式栈的出栈
`
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
`
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
  `
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
  `
【关键点】1.边进栈边计算

#h(4.5em)2.>10数的合并操作

#h(1em)d.后缀计算器的类定义
  `
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
  `
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
`
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
`
【关键点】1.`char`到`string`的转换`c->string(1,c)`

#h(6.5em)2.乘方右结合特判：`if (grade(top_op) > grade(c) || (grade(top_op) == grade(c) && c != '^'))`

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
`
template<class T> class Queue{
public:
    void clear();
    bool enQueue(const T item);
    bool deQueue(T& item);
    bool getFront(T& item);
    bool isEmpty();
    bool isFull();
};
`

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
`
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
`

2.链式队列（用单链表方式存储，队列中每个元素对应链表中的一个结点）

a.链式队列的表示（链接指针的方向是从队列的前端向尾端链接）
#image("assets/链式队列.png")
b.链式队列的类定义
`
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
`

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
   `
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
   `
e.栈和队列的相互模拟
#v(2em)
=== 3.3 栈的应用：递归到非递归
#v(1em)
一.简单的递归转换

1.【例】阶乘
- 递归：
`
int f(int n){
    if(n<=0)
        return 1;
    return n*f(n-1);
}
`

- 非递归：
`
int f(int n){
    int m=1;
    for(int i=1;i<=n;i++)
        m*=i;
    return m;
}
` 

- 尾递归：
`
int f(int n,int x){
    if(n<=0)
        return x;
    return f(n-1,x*n);
}
`

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
`
enumrdType{0, 1, 2}; //对应三种返回情况
public class knapNode{
    int s, n;         // 背包容量和物品数目
    rdType rd;    // 返回情况标号
    bool k;           // 结果单元
};
`
- 2. 设置 t+2个语句标号
  - label 0: 第一个可执行语句
  - label t+1: 设置在函数体结束处
  - label i (1 <= i <= t): 第i个递归返回处

- 3. 增加非递归入口
`
Stack<knapNode> stack;
knapNodetmp;
tmp.s= s; tmp.n= n, tmp.rd = 0;
stack.push(tmp);    // 入栈
`
- 4. 替换第 i (i = 1, …, t)个递归规则
  - 若函数体第i (i=1, ..., t)个递归调用语句形如recf(a1, a2, …, am)；则用以下语句替换：
  - 并增加标号为i的退栈语句
`
S.push(i, a1, ..., am);
goto label0;

label i: S.pop(&x); 
//根据取值x进行相应的返回处理
`
- 5. 所有递归出口处增加语句：
`
goto label t+1;
`
- 6. 标号为t+1的语句的格式
`
S.pop(&tmp);
switch (tmp.rd) {
case 0: return;
case 1: gotolabel1; break;
// ……
cast t: gotolabelt; break;
default: break;
}
`
- 7. 改写循环和嵌套中的递归
- 8. 优化处理

2.[简化的0-1背包问题] 我们有n件物品，物品i的重量为w[i] 。如果限定每种物品
（0）要么完全放进背包（1）要么不放进背包；即物品是不可分割的。问：
能否从这n件物品中选择若干件放入背包，使其重量之和恰好为s
`
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
`