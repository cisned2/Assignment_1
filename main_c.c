#include <stdio.h>

int main() {
	int temp;
	int XH = 2;
	int XL = 34;
	int sum = 0;
	int divisible5 = 0;
	int notdivisible5 = 0;
	int sumList[299];


	for (temp = 0; temp < 300; temp++) {
	
		sumList[temp] = (XH + XL) % 256; // Add low + high
	
		if (XL < 256)	// If XL not above limit then increment XL
			XL = XL + 1; // Incrememnt XL

		if (XL > 255)  { // If XL is over limit then reset and inc XH
			XL = 0; // Reset XL
			XH = XH + 1; // Increment XH
		}

		if (sumList[temp] % 5 == 0) {
			divisible5 = divisible5 + sumList[temp]; // Add divisible by 5 numbers
		}

		else {
			notdivisible5 = notdivisible5 + sumList[temp]; // Add non-divisible by 5 numbers
		}
	}

	for (temp = 0; temp < 300; temp++) {	// Print out list of numbers stored
		if ((temp % 13) == 0)
			printf("\n");
		printf("%x ", sumList[temp]);
	}
	printf("------------------------------------------\n");
	printf("\nSum of numbers divisible by 5 = %d\n", divisible5);
	printf("\nSum of numbers not divisible by 5 = %d\n", notdivisible5);
}