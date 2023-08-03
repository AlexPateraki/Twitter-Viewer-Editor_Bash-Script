# Twitter-Viewer-Editor-Bash-Script
Implementing a Twitter Viewer & Editor in a Bash script using the tweetsmall.txt file.

  The user can perform the following commands:
View the current tweet, display the tweet with the current tweet ID, move to the next tweet, change the current tweet ID to the next tweet in the dataset,
move to the previous tweet, change the current tweet ID to the previous tweet in the dataset, edit a tweet, delete the old version of a tweet and create a new version in the format: {"text": "...here goes the text...", "created at": "...here goes datetime..."}, write the new version to the correct line/position based on the ID/line number of the tweet that was edited (in memory or if saved to a file).  

Clarifications:
You are not allowed to call Python code from the Bash script (NO Python at all).
Your code doesn't need to be optimized for memory usage, processing speed, etc. It should be functionally correct.
You should create separate functions for each command of the Twitter Viewer & Editor and call them appropriately in the Bash script.
Note that the user's changes are not always saved, only when they select w or x.

Along with the tweetsmall.txt file, you are given two additional files, positive.txt and negative.txt. These files contain words (one per line) that are labeled as positive or negative, respectively.

Write a Bash script that reads each line of tweetsmall.txt and, for each line it reads:

-Counts the number of positive words in that tweet.
-Counts the number of negative words in that tweet.
-Writes to a file sentimentpertweet.txt the prevailing sentiment for each processed tweet. 

For example, for the tweet on line 1 of tweetsmall.txt, the sentimentpertweet.txt file should contain:
Tweet at line #1 has a positive sentiment if the number of positive words in the tweet is greater than the number of negative words.
Tweet at line #1 has a neutral sentiment if the number of positive words in the tweet is equal to the number of negative words.
Tweet at line #1 has a negative sentiment if neither of the above conditions is met.
