/*
 * Author: Joshua Chen
 * Date: 2014-09-22
 * Location: Shenzhen
 * Description: Demonstrate the deletion of a file
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>


static void wait_sig(int);
static void sig_int(int);
static void sig_alrm(int);
static int sig_saved = 0;

int
main(int argc, char *argv[])
{
    pid_t pid;
    int fd;
    int n;
    char *path = "/tmp/xxyyzz.tmp";
    char *msg = "1234567";
    char buf[4096];

    printf("pid = %d\n", getpid());

    if (signal(SIGINT, sig_int) == SIG_ERR)
    {
        perror("signal");
        exit(1);
    }

    // create the file
    if ((fd = open(path, O_RDWR|O_CREAT, S_IRUSR|S_IWUSR)) < 0)
    {
        perror("open");
        exit(1);
    }
    printf("file %s created\n", path);
    wait_sig(SIGINT);

    // unlink the file
    if (unlink(path) < 0)
    {
        perror("unlink");
        exit(1);
    }
    printf("file %s unlinked\n", path);
    wait_sig(SIGINT);

    if ((pid = fork()) < 0)
    {
        perror("fork");
        exit(1);
    }
    else if (pid == 0)  // in child, write to the file
    {
        if (write(fd, msg, strlen(msg)) != strlen(msg))
        {
            perror("write");
            exit(1);
        }

        printf("in child %d, wrote %d characters to %s\n  %s\n", getpid(), strlen(msg), path, msg);
        kill(getppid(), SIGINT);
        exit(0);
    }

    // in parent, read from the file
    wait_sig(SIGINT);

    if (lseek(fd, 0, SEEK_SET) < 0)
    {
        perror("lseek");
        exit(1);
    }

    if ((n = read(fd, buf, 7)) < 0)
    {
        perror("read");
        exit(1);
    }
    buf[n] = 0;

    printf("in parent %d, read %d characters from %s\n  %s\n", getpid(), n, path, buf);
    wait_sig(SIGINT);
    exit(0);
}

static void sig_int(int signo)
{
    sig_saved = signo;
}


static void wait_sig(int signo)
{
    while (1)
    {
        pause();
        if (sig_saved == signo)
        {
            sig_saved = 0;
            break;
        }
    }
}
