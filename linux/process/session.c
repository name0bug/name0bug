#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>

void sig_handler(int sig) {
    printf("signal pid = %d, ppid = %d, pgrp = %d, sid = %d\n",
            getpid(), getppid(), getpgrp(), getsid(getpid()));
}

int main(void)
{
    printf("main pid = %d, ppid = %d, pgrp = %d, sid = %d\n",
                getpid(), getppid(), getpgrp(), getsid(getpid()));


    if (fork() == 0) {
    	printf("1 child pid = %d, ppid = %d, pgrp = %d, sid = %d\n",
                getpid(), getppid(), getpgrp(), getsid(getpid()));
        sleep(2);
        printf("child setsid = %d\n", setsid());
    	printf("1 child pid = %d, ppid = %d, pgrp = %d, sid = %d\n",
                getpid(), getppid(), getpgrp(), getsid(getpid()));

        signal(2, sig_handler);

        while (1) { sleep(1); }
        exit(0);
    }
    while (1) { sleep(1); }

    return 0;
}
