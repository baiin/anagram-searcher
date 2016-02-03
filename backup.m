// RJ CHING
// CPSC 411
// HW #2

#include <Foundation/Foundation.h>
#include <sys/time.h>
#include <time.h>


int main(void)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    // create a time stamp to signify start of program
    time_t      start_time;
    start_time = time(NULL);
    
    // load the file and store into array
    NSString *entireFileInString = [NSString stringWithContentsOfFile: @"sample"];
    NSArray  *lines = [entireFileInString componentsSeparatedByString: @"\n"];

    // sort elements of the array by length of string
    NSSortDescriptor    *sorter = [[NSSortDescriptor alloc] initWithKey:@"length" ascending:YES];
    NSArray             *sortDescriptors = [NSArray arrayWithObject: sorter];
    NSArray             *sortedArray = [lines sortedArrayUsingDescriptors: sortDescriptors];

    NSMutableArray  *mostAnagrams = [[NSMutableArray alloc] init];
    int             mostAnagramsCount = -1;

    for(NSString *a in sortedArray)
    {
        //a = [a lowercaseString];
        int         length_a = a.length;

        // counts the number of anagram sets in this string
        NSNumber    *count = [NSNumber numberWithInt: 0];

        for(NSString *b in sortedArray)
        {
            //b = [b lowercaseString];
            int     length_b = b.length;
            
            // if the length of this string is longer than the string its looking in, 
            // then break, since an anagram can not exist if the string we are looking for
            // is longer than the string we are looking in.
            if(length_b >= length_a)
            {
                break;
            }  

            // check if the string is a subset of the string in the outer-loop
            if([a rangeOfString: b].location == NSNotFound)
            {
                // Not Found
            }
            else
            {
                // increment counter if it is a subset
                int value = [count intValue];
                count = [NSNumber numberWithInt: value + 1];
            }
        }

        int counted = [count intValue];

        // if this word has more anagrams, clear the array
        // add this string, as the current high-anagram string 
        if(mostAnagramsCount == -1 || counted > mostAnagramsCount)
        {
            [mostAnagrams removeAllObjects];
            [mostAnagrams addObject: a];
            mostAnagramsCount = counted;
        }
        else if(counted == mostAnagramsCount)
        {
            // if count is equal to the current high-anagram count
            // append string to array
            [mostAnagrams addObject: a];
        }

    	NSLog(@"Value: %@, Count: %@", a, count);
    }

    NSLog(@"Words with the most anagrams: %@", mostAnagrams);

    // create a time stamp to signify the end of the program
    time_t      stop_time;
    stop_time = time(NULL);

    printf("Start Time: %s", asctime(localtime(&start_time)));
    printf("Stop Time: %s", asctime(localtime(&stop_time)));

    [pool drain];

	return 0;
}