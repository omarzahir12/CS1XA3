# CS1XA3 Project02 - ZAHIRM1

## Overview
This webpage is zahirm1's custom CV/Portfolio, to showcase  personal and academic achievements for professional use.

The HTML and CSS were both imported from the following w3 schools template, but a considerable amount of changes were made in the HTML, and due to the extensive nature of the CSS, a lot of the classes were directly used. For certain tags, inline styling had to be used specifically for the individual margining of specific cards.

## Document Design Choice
As this was website was to reflect a CV, I decided to keep the overall design minimalistic, with a single page layout, so it is not overwhelming for any potential employer. On the left side of the page is featured some small facts about me so the viewer can get a quick glance at my values, skills and acheivements. The other half of the page contains the bulk of the information with my Work, Volunteer and Educational experiences outlined in a clean and concise manner. 

## Theme
The theme of this website was minimalism, but also to add a sense of comfort and personality. More than a few features were used to make the user feel comfortable, including the date/time button, as well as a wide-array of color options to choose from for a personal touch.

## References
- The html document used the following HTML and CSS Template from w3schools
https://www.w3schools.com/w3css/tryit.asp?filename=tryw3css_templates_cv&stacked=h
- My personal Font-Awesome icons apart from the ones that are present in the above template were taken from here: https://kit.fontawesome.com/db0c0d3862.js

## Custom Javascript Code

### Feature 1 - Display Time/Date Information

#### Description
This feature is used to display the current time, date, and time zone.

#### Execution
This feature makes use of the built-in `date()` method in JavaScript. The current date is stored in a variable and is displayed with a button association. The button toggles between the date and time option and extracts various methods from the date and displays them using various logic

#### Reference
Inspiration for the code was taken from:
https://www.toptal.com/software/definitive-guide-to-datetime-manipulation

### Feature 2 - Skill Bar Animation

#### Description
This feature animates out the bar for skills under the programming languages section.

#### Execution
This feature makes use of the built-in mouse over j-query event and within it, the built-in animate function is used, which controls the width of the bar. Two mouse events are used, `mouseover` and `mouseleave`, mouse over animates it out on the hover, and mouse leave animates it back to it's original position.

#### Reference
Inspiration for the code was taken from this video:
https://www.youtube.com/watch?v=DKaOpZ_Nlrk

### Feature 3 - Online/Offline Button

#### Description
This feature tells the user whether they are currently connected to the internet or not.

#### Execution
This feature makes use of the built-in navigator online property in javascript which returns a boolean True or False, and logic was used to display the appropriate input to the user

#### Reference
Inspiration for the code was taken from:
https://www.w3schools.com/jsref/prop_nav_online.asp

### Feature 4 - Color Theme Changer

#### Description
This feature allow for the user to choose between the 5 different color theme options given to them.

#### Execution
For this feature, the elements that change color (eg. the panels, background etc.), are either given a uniue identifying id or referenced by their class names. Then using the built in `addClass` and `removeClass` methods, the various groups have all their classes added and then given back, with the exception of the color class that is to be changed.

#### Reference
Inspiration for the code was taken from:
https://www.w3schools.com/jquery/html_removeclass.asp

### Feature 5 - Resume View/Download Button

#### Description
This feature allows the user to view/download my resume.

#### Execution
This feature uses the `window.location.href` command in JavaScript that opens the resume as a new tab. This is put into a function, which is then called using the `onlick` in line HTML property in the button tag.

#### Reference
Inspiration for the code was taken from:
https://www.w3schools.com/js/js_window_location.asp
