#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>

int main(void)
{
    int i = 0;

    while (1) {
        printf("%d kyo do work...\n", i++);
        sleep(1);
    }

    return 0;
}
