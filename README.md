##Members-Only App

###Purpose
This app is an exercise in user modeling, authentication, and authorization. 

###Approach
Users who are 'members' of the site are able to log-in and write posts with nice things to say about the 'non-members'. Non-members can see the nice posts, but they cannot see who wrote them, only members can see that information. 

###Authentication
Login sessions are taken care of by the `sessions_controller`. Upon creation of new users (via the command line), User passwords are hashed and stored in the database as a password_digest (via the BCrypt gem). Users are also given an encrypted `remember_token` upon creation. When users log in, the email and password provided are compared against the email and hashed password listed in the database. The password remains protected, utilizing the power of BCrypt to keep it hashed as it compares against what the user has entered to log in. 

###Remembering
User sessions are remembered via the user's hashed `remember_token` and its comparison with the cookie that's stored on the user's browser. If a user closes the browser without signing out, their session is stored so that the next time they navigate to the site, their session is recovered and they are still signed in. They can use the logout feature to end their session, thereby deleting the cookie from their browser, until they sign in again. 

###Post Visibility
Blog posts can be seen without the viewer being signed in to the site. However, to see the author of the posts, the viewer needs to sign in. The views adjust depending upon whether or not a user is `logged_in?`. This functionality could also be scaled up for different purposes with a few tweaks to the User model. For instance, if certain posts should only be seen by site mods, that `mod?` attribute could be added to the user model and treated as either true or false for each user. 

###Modest styling
The site is styled modestly with the Twitter bootstrap framework, the main focus of the exercise being on the back-end capabilities. 