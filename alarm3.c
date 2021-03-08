#include "libmini.h"

void handler(int s) { write(1, "1", 1);} /*  do nothing */

int main() {

//
	struct sigaction myact;
	struct sigaction oact;
	memset(&myact, 0, sizeof(myact));
	memset(&oact, 0, sizeof(oact));
	myact.sa_handler = handler;
	sigemptyset(&myact.sa_mask);
//

	sigset_t s;
	sigemptyset(&s);
	sigaddset(&s, SIGALRM);
	sigprocmask(SIG_BLOCK, &s, NULL);
	//signal(SIGALRM, SIG_IGN);
	//signal(SIGINT, handler);
	//alarm(1);
	sigaction(SIGINT,&myact,0);
	pause();

	if(sigpending(&s) < 0) perror("sigpending");
	if(sigismember(&s, SIGALRM)) {
		char m[] = "sigalrm is pending.\n";
		write(1, m, sizeof(m));
	} else {
		char m[] = "sigalrm is not pending.\n";
		write(1, m, sizeof(m));
	}
	return 0;
	
}
