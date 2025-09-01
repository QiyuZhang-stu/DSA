#include<iostream>

using namespace std;

int main() {
	int N, M, k, x, y;
	cin >> N >> M;
	for (k = 0; k < 30; k++) {
		if (M < 4 * k * (N - k)) break;
	}
	k--;
	int a = 4 * k * (N - k);
	int b = N - 2*k;
	if (M > a + 2 * b - 1) {
		if (M > a + 3 * b - 2) {
			x = N - k - (M - (a + 3 * b - 2));
			y = k + 1;
		}
		else {
			x = N - k;
			y = k + 1 + ((a + 3 * b - 2) - M);
		}
	}
	else {
		if (M < a + b) {
			x = k + 1;
			y = k + 1 + (M - (a + 1));
		}
		else {
			x = k + 1 + (M - (a + b));
			y = N - k;
		}
	}
	cout << x << " " << y;
	return 0;
}

//(2,1):(n-1)*4		
//(3,2):[(n-1)+(n-3)]*4
//(4,3):[(n-1)+(n-3)+(n-5)]*4
//(k+1,k):k(n-k)*4    
//左上(k+1,k+1):4k(n-k)+1
//右上(k+1,n-k):4k(n-k)+n-2k
//右下:(n-k,n-k)4k(n-k)+2(n-2k)-1
//左下(n-k,k+1):4k(n-k)+3(n-2k)-2
