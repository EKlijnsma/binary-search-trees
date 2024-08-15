# binary-search-trees
The Odin Project - Binary Search Trees

Honestly this was quite a challenging project that took me a while. 
It did not help that the holidays kicked in, taking away the routine of working on this. 

Initially I struggled a bit with the delete function. I took me a while to grasp the fact that it works best to provide a root as parameter for most functions. 
Eventually I managed to make it work and in the end I struggled most with the inorder, preorder and postorder functions. 
I implemented them as recursive functions, but that gave me a challenge: 
- for the recursion to work I needed to return Node class instances
- for the assignment requirements the function should return the node values when no block is passed

My final approach to this was to make a recursive helper function that is being called from the main inorder, preorder and postorder functions.
To make I more generic I declared constants in my Tree class to pass as arguments to the helper function so I could use it in all 3 cases. 

After all I learnt a lot from this project and really enjoyed the challenge.
