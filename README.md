# Project 4 - *Instagram*

**Instagram** is a photo sharing app using Parse as its backend.

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [YES] User can sign up to create a new account using Parse authentication
- [YES] User can log in and log out of his or her account
- [YES] The current signed in user is persisted across app restarts
- [YES] User can take a photo, add a caption, and post it to "Instagram"
- [YES] User can view the last 20 posts submitted to "Instagram"
- [YES] User can pull to refresh the last 20 posts submitted to "Instagram"
- [YES] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [YES] Run your app on your phone and use the camera to take the photo
- [YES] Style the login page to look like the real Instagram login page.
- [YES] Style the feed to look like the real Instagram feed.
- [YES] User can use a tab bar to switch between all "Instagram" posts and posts published only by the user. AKA, tabs for Home Feed and Profile
- [YES] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [YES] Show the username and creation time for each post
- [YES] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- User Profiles:
- [YES] Allow the logged in user to add a profile photo
- [YES] Display the profile photo with each post
- [] Tapping on a post's username or profile photo goes to that user's profile page
- [YES] User can comment on a post and see all comments for each post in the post details screen.
- [YES] User can like a post and see number of likes for each post in the post details screen.
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [YES] List anything else that you can get done to improve the app functionality!
- [YES] User can open a map to see locations
- [YES] User can search for locations on map and choose one to add to picture
- [YES] Chosen map location is printed on the feed under the username, like the real Instagram app
- [YES] Likes on a post shows the first user who liked it, just as real Instagram, then shows the rest of the likes as a number. "Liked by john and 15 others"
- [YES] Edit profile page can be opened to a new view to edit all the information, as real Instagram
- [YES] Error shows up if user enters empty username or password

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Discussing the transfer of information and the most efficient way to transfer information.
2. Discussing delegates, protocols, and blocks to further understand how to optimize code with them.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library


## Notes

Describe any challenges encountered while building the app.

I encountered various challenges. The most difficult and challenging part of this app was the transfer and management of information, as I tried to extend the app through various views to make it as similar as the real app as possible. Therefore, there was ana extensive transfer of information which proved a difficult task. With the help of my peers and instructors, I was able to think through and solve the main difficulties. I still am curious about more efficient ways to transfer and maintain information through protocols and delegates.

## License

Copyright [2018] [Nicolas Machado]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
