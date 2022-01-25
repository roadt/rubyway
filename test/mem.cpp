#include <string>
#include <cstdlib>
#include <cstdio>

using namespace std;

int main (int argc, char const *argv[]) {
    string s(100000000, '-');
    string b = string(s, 1);
    b[0] = 'a';
    printf("%lu\n", b.size());
    getchar();
    return 0;
}
