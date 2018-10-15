#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>

int main(void)
{
    printf("main pid = %d, ppid = %d\n", getpid(), getppid());
    if (fork() == 0) {
        printf("1 child pid = %d, ppid = %d\n", getpid(), getppid());
        sleep(1);
        /* printf("2 child pid = %d, ppid = %d\n", getpid(), getppid()); */
        exit(0);
    }
    /* wait(NULL); */

    printf("main .....\n");

    getchar();

    return 0;
}
