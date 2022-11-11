/*
 * Disable power management: similar to ``processor.max_cstate=1 idle=poll``
 * in kernel arguments, check https://access.redhat.com/articles/65410
 */

#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

static int pm_qos_fd = -1;

void start_low_latency(void)
{
    int target = 0;//0是最低延迟，1是不完全禁用电源管理机制的最低延迟

    if (pm_qos_fd >= 0)
        return;

    pm_qos_fd = open("/dev/cpu_dma_latency", O_RDWR); // fopen得到好像不是fd，而是一个数据结构
    if (pm_qos_fd < 0) {
        fprintf(stderr, "Failed to open PM QOS file: %s\n", strerror(errno));
        exit(errno);
    }
    write(pm_qos_fd, &target, sizeof(target));
}

void stop_low_latency(void)
{
    if (pm_qos_fd >= 0) { //close之后，就stop low_latency了？不需要写东西进去的吗？
        close(pm_qos_fd);
    }
}

int main(int argc, char **argv)
{
    //写0进 /dev/cpu_dma_latency，禁用dvfs等电源管理机制，来达到最低的延迟
    //使用这个来和benchmark比较，是不是算是作弊？
    start_low_latency();
    pause(); //暂停，直到某个signal唤醒它
    stop_low_latency();

    return 0;
}
