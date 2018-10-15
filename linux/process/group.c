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
    printf("main pid = %d, ppid = %d, pgrp = %d\n", getpid(), getppid(), getpgrp());
    if (fork() == 0) {
    	printf("1 child pid = %d, ppid = %d, pgrp = %d\n", getpid(), getppid(), getpgrp());
        sleep(2);
        printf("child setpgrp = %d\n", setpgrp());
        /* printf("2 child pid = %d, ppid = %d, pgrp = %d\n", getpid(), getppid(), getpgrp()); */
        /* getchar(); */
        while (1) { sleep(1); }
        /* printf("2 child pid = %d, ppid = %d, pgrp = %d\n", getpid(), getppid(), getpgrp()); */
        exit(0);
    }
    sleep(4);
    kill(0, 9);
    /* wait(NULL); */
    /* while (1) { sleep(1); } */

    /* getchar(); */

    return 0;
}
