#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <signal.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>

void createChild(int sig) {
    int i = 0;

    if (sig == 17) {
        printf("子进程死了， 重新创建...\n");
    }

    if (fork() == 0) {
        exit(execl("./do_work", "kyo_work", NULL));
    }
}

int main(void)
{
    if (fork() == 0) {
        signal(SIGCHLD, createChild);

        createChild(0);

        while (1) {
            sleep(1);
        }
    }

    return 0;
}
