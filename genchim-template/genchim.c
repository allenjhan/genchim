
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <stdlib.h>


int main(int argc, char* argv[])
{
    if (argc == 3){
	int filename_length = strlen(argv[1]);
	int latex_length = strlen(argv[2]);
	char generate[] = "./genchim.sh ";
	int generate_length = strlen(generate);
	int total_length = generate_length + filename_length + latex_length + 5; //5 is an arbitrary number
	char *final_string = (char *) malloc(total_length);

	strcpy(final_string, generate);
	strcat(final_string, argv[1]);
        strcat(final_string, ".tex ");
	strcat(final_string, argv[2]);
        //printf("%s\n", final_string); // debug statement

	int store_stdout = dup(1);
	freopen("/dev/null", "w", stdout);
	system(final_string);

	fclose(stdout);
	stdout = fdopen(store_stdout, "w");
	printf("[[./chessimage/%s%s]]", argv[1], ".png");
    }    

    exit(0);
}
