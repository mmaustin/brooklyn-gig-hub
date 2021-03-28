Specifications for the Sinatra Assessment
Specs:

 [x] Use Sinatra to build the app - (Utilized Sinatra);
 [x] Use ActiveRecord for storing information in a database - (Utilized ActiveRecord);
 [x] Include more than one model class (e.g. User, Post, Category) - (Has User, Gig, and Player models);
 [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - (User has_many gigs and players);
 [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - (Gigs and players belong_to User);
 [x] Include user accounts with unique login attribute (username or email) - (User object is retrieved from the database by username);
 [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - (Included routes that perform new, show, edit, and delete functions on the belongs_to models);
 [x] Ensure that users can't modify content created by other users - (User cannot access the edit and delete features of entities that don't belong to that user);
 [x] Include user input validations - (User is unable to create or edit content if all fields are not filled in);
 [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - (Used sinatra-flash to display user errors);
 [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
 Confirm

 [x] You have a large number of small Git commits
 [x] Your commit messages are meaningful
 [x] You made the changes in a commit that relate to the commit message
 [x] You don't include changes in a commit that aren't related to the commit message
