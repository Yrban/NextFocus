# NextFocus
This is a demonstration of how to use @FocusState in a child view(s)

This is based off of an answer I gave on StackOverflow. This allows the programmer to use a child view with a TextField to still take advantage of @FocusedState. The key is passing in a closure which encapsulates the logic to move to the next view so it can be called in the child view's .onSubmit.
