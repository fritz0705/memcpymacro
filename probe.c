#include <stdint.h>
#include <stdio.h>

#define ARRAY_COPY(dst, src, len) {\
		struct {\
			struct {\
				uint8_t __[len];\
			} *__s, *__d;\
		} __cp = { .__s = (void*)(src), .__d = (void*)(dst) };\
		*(__cp.__d) = *(__cp.__s);\
	}

void probe()
{
	int src[10] = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
	int *dst = src + 2;

	ARRAY_COPY(dst, src, sizeof *src * 8);

	printf("%d %d %d %d %d %d %d %d %d %d\n", src[0], src[1], src[2], src[3],
		src[4], src[5], src[6], src[7], src[8], src[9]);
}

int main(int argc, char **argv)
{
	(void)argc, (void)argv;

	probe();

	return 0;
}

