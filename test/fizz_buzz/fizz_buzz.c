/* Syscalls provided by SPIM */
int syscall_read_int(void);
void syscall_exit2(int i);
void syscall_print_int(int i);
void syscall_print_string(char *c);

/*
 * atoi - converts a string to an integer
 *
 * Parameters:
 *   char *str - string to convert
 *
 * Returns:
 *  integer
 *
 *   See: https://www.techonthenet.com/c_language/standard_library_functions/stdlib_h/atoi.php
 */
int atoi(char *str)
{
	int i;
	int result;

	result = 0;

	for (i = 0; str[i] != '\0'; i++)
		result = (str[i] - '0') + (result * 10);

	return result;
}

void main(int argc, char **argv)
{
	int i, fizz, buzz, max;

	if (argc < 2) {
		syscall_print_string
		    ("First argument should be value to count up to.\n");
		syscall_exit2(1);
	}

	max = atoi(argv[1]);

	for (i = 1; i <= max; i++) {
		if ((fizz = i % 3 == 0)) {
			syscall_print_string("Fizz");
		}

		if ((buzz = i % 5 == 0)) {
			syscall_print_string("Buzz");
		}

		if (!(fizz || buzz)) {
			syscall_print_int(i);
		}

		syscall_print_string("\n");
	}
}
