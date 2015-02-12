#include <stdio.h>
#include <string.h>

int main (int argc, char **argv)
{
	char *command;
	char *mobile, *text;
	if(argc != 3){
		printf("");
		return(1);
	}
	asprintf(&mobile, "%s", argv[1]);
	asprintf(&text, "%s", argv[2]);
	asprintf(&command, "test -e /usr/bin/gnokii && echo \"%s\" | gnokii --sendsms %s > /dev/null  2>&1", text, mobile);
	//printf(command);
   	system(command);

   return(0);
} 
