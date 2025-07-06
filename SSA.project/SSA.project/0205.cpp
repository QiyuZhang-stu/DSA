#include <iostream>
#include <vector>
#include <algorithm>
#include <limits>
using namespace std;

struct Term {
    int coef;
    int exp;
};

vector<Term> readPoly() {
    vector<Term> poly;
    int coef, exp;
    while (cin >> coef >> exp) {
        if (exp < 0) break;
        poly.push_back({ coef, exp });
    }

    // 按指数降序排序
    sort(poly.begin(), poly.end(), [](const Term& a, const Term& b) {
        return a.exp > b.exp;
        });

    // === 新增：合并同类项 ===
    vector<Term> merged;
    if (!poly.empty()) {
        int cur_coef = poly[0].coef;
        int cur_exp = poly[0].exp;

        for (int i = 1; i < poly.size(); ++i) {
            if (poly[i].exp == cur_exp) {
                cur_coef += poly[i].coef;  // 合并相同指数项
            }
            else {
                if (cur_coef != 0)        // 忽略系数为0的项
                    merged.push_back({ cur_coef, cur_exp });
                cur_coef = poly[i].coef;
                cur_exp = poly[i].exp;
            }
        }
        if (cur_coef != 0)
            merged.push_back({ cur_coef, cur_exp });
    }
    // =======================

    cin.ignore(numeric_limits<streamsize>::max(), '\n');
    return merged;  // 返回合并后的多项式
}

vector<Term> addPolys(vector<Term>& poly1, vector<Term>& poly2) {
    vector<Term> result;
    int i = 0, j = 0;
    while (i < poly1.size() && j < poly2.size()) {
        if (poly1[i].exp > poly2[j].exp) {
            if (poly1[i].coef != 0)
                result.push_back(poly1[i]);
            i++;
        }
        else if (poly1[i].exp < poly2[j].exp) {
            if (poly2[j].coef != 0)
                result.push_back(poly2[j]);
            j++;
        }
        else {
            int newCoef = poly1[i].coef + poly2[j].coef;
            if (newCoef != 0) {
                result.push_back({ newCoef, poly1[i].exp });
            }
            i++;
            j++;
        }
    }
    while (i < poly1.size()) {
        if (poly1[i].coef != 0)
            result.push_back(poly1[i]);
        i++;
    }
    while (j < poly2.size()) {
        if (poly2[j].coef != 0)
            result.push_back(poly2[j]);
        j++;
    }
    return result;
}

void printPoly(const vector<Term>& poly) {
    if (poly.empty()) {
        cout << endl;
        return;
    }
    cout << "[ " << poly[0].coef << " " << poly[0].exp << " ]";
    for (int i = 1; i < poly.size(); i++) {
        cout << " [ " << poly[i].coef << " " << poly[i].exp << " ]";
    }
    cout << endl;
}

int main() {
    int n;
    cin >> n;
    for (int i = 0; i < n; i++) {
        vector<Term> poly1 = readPoly();
        vector<Term> poly2 = readPoly();
        vector<Term> result = addPolys(poly1, poly2);
        printPoly(result);
    }
    return 0;
}