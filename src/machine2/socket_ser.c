#include<sys/types.h>
#include<sys/socket.h>
#include<stdio.h>
#include<unistd.h>
#include<netdb.h>
#include<arpa/inet.h>
#include<netinet/in.h>
#include<string.h>

int main(int argc,char *argv[])
    {
    int client,socket;

    struct sockaddr_in serAdd,cliAdd;
    socklen_t numCli;

    char recvBuffer[1000],sendBuffer[1000];
    pid_t cpid;

    bzero(&serAdd,sizeof(serAdd));

    serAdd.sin_family=AF_INET;
    serAdd.sin_addr.s_addr=htonl(INADDR_ANY);
    serAdd.sin_port=htons(5500);

    socket=socket(AF_INET,SOCK_STREAM,0);

    bind(socket,(struct sockaddr*)&serAdd,sizeof(serAdd));

    listen(socket,5);

    printf("%s\n","Server is  running on port %d", serAdd.sin_port);
    
    client=accept(socket,(struct sockaddr*)&cliAdd,&numCli);
    
    cpid=fork();

    if(cpid==0)
    {
        while(1)
        {
            bzero(&recvBuffer,sizeof(recvBuffer));
            recv(client,recvBuffer,sizeof(recvBuffer),0);
            printf("\nCLIENT : %s\n",recvBuffer);
        }
    }
    else
    {
        while(1)
        {

            bzero(&sendBuffer,sizeof(sendBuffer));
            printf("\nmsg> ");
            fgets(sendBuffer,10000,stdin);
            send(client,sendBuffer,strlen(sendBuffer)+1,0);
            printf("\nMessage sent !\n");
        }
    }
    return 0;
}


// nc <IP> 5500 to connect to the server
