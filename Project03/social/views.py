from django.http import HttpResponse,HttpResponseNotFound
from django.shortcuts import render,redirect,get_object_or_404
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm, PasswordChangeForm
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib import messages
from social.forms import EditProfileForm

from . import models

def messages_view(request):
    """Private Page Only an Authorized User Can View, renders messages page
       Displays all posts and friends, also allows user to make new posts and like posts
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render private.djhtml
    """
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)


        # TODO Objective 9: query for posts (HINT only return posts needed to be displayed)
        posts = list(models.Post.objects.order_by('-timestamp'))
        request.session['postlimit'] = request.session.get('postlimit', 1)
        # TODO Objective 10: check if user has like post, attach as a new attribute to each post

        context = { 'user_info' : user_info
                  , 'posts' : posts }
        return render(request,'messages.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def account_view(request):
    """Private Page Only an Authorized User Can View, allows user to update their account information (i.e UserInfo fields), including changing their password
    Parameters
    ---------
      request: (HttpRequest) should be either a GET or POST
    Returns
    ---------
    out: (HttpResponse)
    GET - if user is authenticated, will render account.djhtml 
    POST - handle form submissions for changing password, or User Info
                        (if handled in this view)
    """
    if request.user.is_authenticated:
        form = AuthenticationForm(request.POST)
        user_info = models.UserInfo.objects.get(user=request.user)
        # TODO Objective 3: Create Forms and Handle POST to Update UserInfo / Password
        context = { 'user_info' : user_info,
                    'form' : form }
        return render(request,'account.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')


def user_change_view(request):
    """Private Page Only an Authorized User Can View, allows user to update
       their account information (i.e UserInfo fields), including changing
       their password
    Parameters
    ---------
      request: (HttpRequest) should be either a GET or POST
    Returns
    --------
      out: (HttpResponse)
                 GET - if user is authenticated, will render account.djhtml
                 POST - handle form submissions for changing password, or User Info
                        (if handled in this view)
    """
    if request.user.is_authenticated:
        # form = AuthenticationForm(request.POST)

        # TODO Objective 3: Create Forms and Handle POST to Update UserInfo / Password
        user_info = models.UserInfo.objects.get(user=request.user)
        failed = request.session.get('u_failed',False)
        form = EditProfileForm(request.POST or None, initial={'employment':user_info.employment, 'location':user_info.location, 'birthday':user_info.birthday, 'interests':user_info.interests.all()})
        if request.method == 'POST':
            form = EditProfileForm(request.POST or None, initial={'employment':user_info.employment, 'location':user_info.location, 'birthday':user_info.birthday, 'interests':user_info.interests.all()})
            if form.is_valid():
                failed = request.session.get('u_failed',False)
                employment = request.POST.get('employment','Unspecified')
                location = request.POST.get('location','Unspecified')
                birthday = request.POST.get('birthday',"None")
                interests = request.POST.get('interests')
                if models.Interest.objects.filter(label__iexact=interests):
                    ins = models.Interest.objects.filter(label__iexact=interests)
                else:
                    ins = models.Interest.objects.create(label=interests)
                user_info.employment = employment
                user_info.location = location
                user_info.birthday = birthday
                user_info.interests.add(ins)
                user_info.save()
                return redirect('social:messages_view')
            else:
                failed = request.session.get('u_failed',True)
        context = { 'user' : request.user , 'change_userinfo_form' : form , 'user_info' : user_info , 'u_failed' : failed }
        return render(request,"account.djhtml",context)
    request.session['failed'] = True
    return redirect('login:login_view')

def password_change_view(request):
    if not request.user.is_authenticated:
        redirect('login:login_view')

    if request.method == 'POST':
        form = PasswordChangeForm(request.user, request.POST)
        if form.is_valid():
            user = form.save()
            update_session_auth_hash(request, user) 
            return redirect('login:login_view')
    else:
        form = PasswordChangeForm(request.user)
    context = { 'user' : request.user
                ,'change_form' : form }
    return render(request, 'account.djhtml',context)

def people_view(request):
    """Private Page Only an Authorized User Can View, renders people page
       Displays all users who are not friends of the current user and friend requests
    Parameters
    ---------
      request: (HttpRequest) - should contain an authorized user
    Returns
    --------
      out: (HttpResponse) - if user is authenticated, will render people.djhtml
    """
    if request.user.is_authenticated:
        user_info = models.UserInfo.objects.get(user=request.user)
        # TODO Objective 4: create a list of all users who aren't friends to the current user (and limit size)
        all_people = []
        for pers in models.UserInfo.objects.exclude(user=user_info.user):
            friend = list(user_info.friends.all())
            if pers not in friend:
                all_people += [pers]
        request.session['limit'] = request.session.get('limit', 1)
        # TODO Objective 5: create a list of all friend requests to current user
        friend_requests = []
        for f_r in models.FriendRequest.objects.filter(to_user=user_info).all():
            friend_requests += [f_r.from_user]
        context = { 'user_info' : user_info,
                    'all_people' : all_people,
                    'friend_requests' : friend_requests }

        return render(request,'people.djhtml',context)

    request.session['failed'] = True
    return redirect('login:login_view')

def like_view(request):
    '''Handles POST Request recieved from clicking Like button in messages.djhtml,
       sent by messages.js, by updating the corrresponding entry in the Post Model
       by adding user to its likes field
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postID,
                                a string of format post-n where n is an id in the
                                Post model

	Returns
	-------
   	  out : (HttpResponse) - queries the Post model for the corresponding postID, and
                             adds the current user to the likes attribute, then returns
                             an empty HttpResponse, 404 if any error occurs
    '''
    postIDReq = request.POST.get('postID')
    if postIDReq is not None:
        # remove 'post-' from postID and convert to int
        # TODO Objective 10: parse post id from postIDReq
        postID = 0

        if request.user.is_authenticated:
            # TODO Objective 10: update Post model entry to add user to likes field

            #return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('like_view called without postID in POST')

def post_submit_view(request):
    '''Handles POST Request recieved from submitting a post in messages.djhtml by adding an entry
       to the Post Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute postContent, a string of content

	Returns
	-------
   	  out : (HttpResponse) - after adding a new entry to the POST model, returns an empty HttpResponse,
                             or 404 if any error occurs
    '''
    # postContent = request.POST.get('postContent')
    content = request.POST.get('content')
    if content is not None:
        if request.user.is_authenticated:
            # TODO Objective 8: Add a new entry to the Post model
            models.Post.objects.create(owner=models.UserInfo.objects.get(user=request.user),content=content)
            #return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('post_submit_view called without postContent in POST')

def more_post_view(request):
    '''Handles POST Request requesting to increase the amount of Post's displayed in messages.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating hte num_posts sessions variable
    '''
    if request.user.is_authenticated:
        # update the # of posts dispalyed

        # TODO Objective 9: update how many posts are displayed/returned by messages_view
        request.session['postlimit'] += 1
        # return status='success'
        return HttpResponse()

    return redirect('login:login_view')

def more_ppl_view(request):
    '''Handles POST Request requesting to increase the amount of People displayed in people.djhtml
    Parameters
	----------
	  request : (HttpRequest) - should be an empty POST

	Returns
	-------
   	  out : (HttpResponse) - should return an empty HttpResponse after updating the num ppl sessions variable
    '''
    if request.user.is_authenticated:
        # update the # of people dispalyed

        # TODO Objective 4: increment session variable for keeping track of num ppl displayed
        request.session['limit'] = request.session['limit'] + 1
        # return status='success'
        return HttpResponse()

    return redirect('login:login_view')

def friend_request_view(request):
    '''Handles POST Request recieved from clicking Friend Request button in people.djhtml,
       sent by people.js, by adding an entry to the FriendRequest Model
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute frID,
                                a string of format fr-name where name is a valid username

	Returns
	-------
   	  out : (HttpResponse) - adds an etnry to the FriendRequest Model, then returns
                             an empty HttpResponse, 404 if POST data doesn't contain frID
    '''
    frID = request.POST.get('frID')
    if frID is not None:
        # remove 'fr-' from frID
        username = frID[3:]
        # models.UserInfo.objects.get(user=request.user)
        if request.user.is_authenticated:
            # TODO Objective 5: add new entry to FriendRequest
            t = models.UserInfo.objects.get(user=request.user)
            f = models.UserInfo.objects.get(user_id=username)
            if not models.FriendRequest.objects.filter(from_user=t, to_user=f).exists():
                f_r = models.FriendRequest.objects.create(to_user=f, from_user=t)
            # return status='success'
            return HttpResponse()
        else:
            return redirect('login:login_view')

    return HttpResponseNotFound('friend_request_view called without frID in POST')

def accept_decline_view(request):
    '''Handles POST Request recieved from accepting or declining a friend request in people.djhtml,
       sent by people.js, deletes corresponding FriendRequest entry and adds to users friends relation
       if accepted
    Parameters
	----------
	  request : (HttpRequest) - should contain json data with attribute decision,
                                a string of format A-name or D-name where name is
                                a valid username (the user who sent the request)

	Returns
	-------
   	  out : (HttpResponse) - deletes entry to FriendRequest table, appends friends in UserInfo Models,
                             then returns an empty HttpResponse, 404 if POST data doesn't contain decision
    '''
    # data = request.POST.get('decision')
    frID = request.POST.get('frID')
    decision = frID [:2]
    if frID is not None:
        username = frID [2:]
        # TODO Objective 6: parse decision from data
        if request.user.is_authenticated:

            # TODO Objective 6: delete FriendRequest entry and update friends in both Users

            # return status='success'
            to = models.UserInfo.objects.get(user=request.user)
            fro = models.UserInfo.objects.get(user_id=username)

            #if models.FriendRequest.objects.filter(from_user=to, to_user=fro).exists():
            req = models.FriendRequest.objects.filter(to_user=fro, from_user=to).delete()
            if decision == 'A-':
                to.friends.add(fro)
                fro.friends.add(to)
                to.save()
                fro.save()
            return HttpResponse()

        else:
            return redirect('login:login_view')
    return HttpResponseNotFound('accept-decline-view called without decision in POST')
