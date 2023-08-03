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
