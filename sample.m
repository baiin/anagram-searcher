#include <Foundation/Foundation.h>


BOOL anagramOf(NSString *string1, NSString *string2)
{
    if (string1.length != string2.length)
    {
    	return NO;
    }

    for (int i = 0; i < string1.length; i++) 
    {
        int h = 0;
        int q = 0;

        for (int k = 0;  k < string1.length; k++) 
        {
            if ([string1 characterAtIndex:i] == [string1 characterAtIndex:k]) 
            {
                h++;
            }
            
            if ([string1 characterAtIndex:i] == [string2 characterAtIndex:k]) 
            {
                q++;
            }
        }

        if (h != q) 
        {
            return NO;
        }
    }

    return YES;
}


int		main(void)
{
	NSAutoreleasePool 	*pool = [[NSAutoreleasePool alloc] init];

	// load the file and store into array
    NSString 			*entireFileInString = [NSString stringWithContentsOfFile: @"sample"];
    NSArray  			*lines = [entireFileInString componentsSeparatedByString: @"\n"];

    // sort elements of the array by length of string
    NSSortDescriptor    *sorter = [[NSSortDescriptor alloc] initWithKey:@"length" ascending:YES];
    NSArray             *sortDescriptors = [NSArray arrayWithObject: sorter];
    NSArray             *sortedArray = [lines sortedArrayUsingDescriptors: sortDescriptors];

    NSMutableArray 		*highAnagramList = [[NSMutableArray alloc] init];
    int  				currentHigh = -1;

    for(NSString *a in sortedArray)
	{
		NSMutableArray 	*anagramList = [[NSMutableArray alloc] init];
		int 			numOfAnagrams = 0;

		[anagramList addObject: a];

		for(NSString *b in sortedArray)
		{
			if ([a isEqualToString: b])
			{
				// does not count
			}
			else
			{
				if(anagramOf(a, b) == YES)
				{
					++numOfAnagrams;
					[anagramList addObject: b];
					NSLog(@"Anagram found: %@, %@", a, b);
				}
			}	
		}

		if(currentHigh == -1 || numOfAnagrams > currentHigh)
		{
			currentHigh = numOfAnagrams;
			highAnagramList = [NSMutableArray arrayWithArray: anagramList];
		}
	}

	NSLog(@"Set with most anagrams: %@", highAnagramList);

	[pool drain];

	return 0;
}


