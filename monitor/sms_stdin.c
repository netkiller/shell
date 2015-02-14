#include <stdio.h>  
#include <string.h>  
#include <unistd.h>  
  
#define MAX_BUFFER_LENGTH 1024  
  
int main(int argc, char **argv)  
{  
    char *command;
    char *mobile;
    char buf[ MAX_BUFFER_LENGTH ];  
    if(argc != 2){
	printf("");
	return(1);
    }
    asprintf(&mobile, "%s", argv[1]);
    int length = 0;  
    if( (length = read( 0, buf,  MAX_BUFFER_LENGTH )) < 0 ) {  
        return -1;  
    }  
    buf[length] = '\0';  
    asprintf(&command, "test -e /usr/bin/gnokii && echo \"%s\" | gnokii --sendsms %s > /dev/null  2>&1", buf, mobile);
    system(command);
    //printf(command);  
    return 0;  
} 
