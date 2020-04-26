# CS1XA3 Project03 - ZAHIRM1

## Usage
Install conda environment with `conda django env`

Run locally with
`python manage.py runserver localhost: 8000` in the main `Project03` directory.

Run on mac1xa3.ca with `python manage.py runserver localhost: 10115`
 
Log in with:
 
Username: TestUser
 
Password: somethinglong

Username: someotherguy

Password: somethinglong

Username: someoneelse

Password: somethinglong

Username: anotherguy

Password: somethingreallylong

 ## Objective 01
#### Description:

- This feature is displayed in `signup.djhtml` which is rendered by
`sign_up_view`

- The form makes a `AJAX POST` Request to create a new user

- The request to create a user is sent to `sign_up_view` where the entry creation is automated.

- Upon a successful response, the user is signed in and redirected to the messages page

#### Exceptions:
- If the user fails to create successfully, the `e/zahirm1/signup` will reload

## Objective 02
#### Description:

- This feature is displayed in `social_base.djhtml` which has been edited to display the information of the user using the model variables of the user that are given in `models.py`

#### Exceptions:

- If the user has no current attributes like employment, interests etc. then nothing is displayed

## Objective 03
#### Description:

- This objective provides users with forms to edit their password and personal user information

- For the change password function, this objecive makes use of an imported form from django templates

- For the user info update form, a new file, `forms.py` was created, and was personally edited to add for the given user attributes. This was then referenced in `account.djhtml`.

- The forms were set up to send a POST request to `account_view` in views.py where the entry was processed.

#### Exceptions:

- The information provided to the form must be updated for all fields everytime otherwise the from is not submitted.

## Objective 4
#### Description:

- This objective is responsible for displaying the list of people that are not the users friends

- The middle column of the friend page is rendered by the `people_view` function that iterates over a for loop of the users current friends and displayes them as a variable through `people.djhtml`

- The more button is linked with `people.js` that send an `AJAX POST` request to `more_ppl_view`, which displays another user profile, through a session variable, for every subsequent press of the button

#### Exceptions:

- If the more button is pressed without any subsequent users to show, nothing is done

## Objective 5
#### Description:

- This objective allows the user to send friend requests to those users that were displayed in objective 4

- Once the friend request button is pressed, an AJAX POST request is sent through `people.js`, which send the users friend id to `views.py`, and creates a friend request model entry with the two `UserInfo` objects, one for the sender and one for the receiver

- Then using the new created data, `people.djhtml` is updated appropriately in order to display the friend request that the user has received from the previously created entries

#### Exceptions:

- If there are no friend requests to display, nothing is shown.

## Objective 6
#### Description:

- This objective is responisble for allowing the user to accept or decline the friend requests that they have received (done in Objective 5)

- The `poeple.js` is set up to send an AJAX POST request to `accept_decline_view` which in addition is given the property of whether the button clicked was the accept or decline

- In `accept_decline_view`, regardless of which button was pressed, the friend request entry model is deleted

- A boolean is present to determine whether the button was accept, and if it was, both users are added to each other's friends models and the entry is saved

#### Note:

Although the friend request is accepted (as indicated by the completion of obective 7) unfortunately, the friend request is still visible, although I am quite certain my implementation was right and the friend request entry was deleted.

## Objective 7

#### Description:

- This objective is responsible for displaying all of the users that the user is currently friends with

- This objective is implemented by a simple `for` loop in `messages.djhtml` that iterates over the users current friends and replaces the html file with the appropriate information

#### Exception:
 - If there are no friends to display, nothing is shown

## Objective 8

#### Description:

- This objective is responsible for creating creating and storing posts in the database

- `messages.js` is set up to send a AJAX POST request to `post_submit_view` in `views.py` when the post button is submitted

- `post_submit_view` creates a new entry in the post model with the contents of the post that were given to it by the AJAX POST request

#### Exceptions:

- If the post is empty, no entry will be added to the model

## Objective 9

#### Description:

- This objective is responsible for displaying all the entries in the post models by the various users

- `messages.djhtml` is rendered to display the various posts by the different users, along with their names, being given this information by `messages_view`

- `messages_view` also ensures that the posts are sorted appropriately, from newest to oldest

- The `More` button is rendered effective by `more_post_view`, which uses a session variable that keeps track of how many posts are currently displaying

#### Exception:

- If there are no more posts to show then the `More` button will be ineffective

## Objective 10

#### Description:
- The purpose of this objective is to enable and keep track of the like button for individual posts and ensure the user can only like each post once

#### Exceptions:
- Once the user has clicked the like button, they are unable to like it again

#### Note:

Unfortunately, I was unable to attempt and complete this objective
