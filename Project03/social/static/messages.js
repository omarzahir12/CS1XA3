/* ********************************************************************************************
   | Handle Submitting Posts - called by $('#post-button').click(submitPost)
   ********************************************************************************************
   */

function submitPostResponse(data,status) {
    if (status == 'success') {
        location.reload();
    }
    else {
        alert('failed to create friend request ' + status);
    }
}

function submitPost(event) {
    // submit empty data
    //let text = $('#post-text');
    //let content = $('#post-text');
    let content = document.getElementById("post-text").innerHTML;
    // globally defined in messages.djhtml using i{% url 'social:more_post_view' %}
    let data = { 'content' : content };
    let url_path = post_submit_url;
    // AJAX post
    $.post(url_path,
           data,
           submitPostResponse);
}
    // TODO Objective 8: send contents of post-text via AJAX Post to post_submit_view (reload page upon success)

/* ********************************************************************************************
   | Handle Liking Posts - called by $('.like-button').click(submitLike)
   ********************************************************************************************
   */
function submitLike(event) {
    alert('Like Bn Pressed');
    // TODO Objective 10: send post-n id via AJAX POST to like_view (reload page upon success)
}

/* ********************************************************************************************
   | Handle Requesting More Posts - called by $('#more-button').click(submitMore)
   ********************************************************************************************
   */
function moreResponse(data,status) {
    if (status == 'success') {
        // reload page to display new Post
        location.reload();
    }
    else {
        alert('failed to request more posts' + status);
    }
}

function submitMore(event) {
    // submit empty data
    let json_data = { };
    // globally defined in messages.djhtml using i{% url 'social:more_post_view' %}
    let url_path = more_post_url;

    // AJAX post
    $.post(url_path,
           json_data,
           moreResponse);
}

/* ********************************************************************************************
   | Handle Requesting More Posts - called by $('#more-button').click(submitMore)
   ********************************************************************************************
   */
function moreInfo(data,status) {
    if (status == 'success') {
        // reload page to display new Info
        location.reload();
    }
    else {
        alert('failed to request more posts' + status);
    }
}

function onSubmit(event) {
    event.preventDefault();
    let form= $(this);
    let emp = form.find("input[name='emp']").val();
    let loc = form.find("input[name='loc']").val();
    let bday = form.find("input[name='bday']").val();
    let inter = form.find("input[name='inter']").val();
    let json_data = { "emp" : emp , "loc" : loc , "bday" : bday , "inter" : inter};
    // globally defined in messages.djhtml using i{% url 'social:more_post_view' %}
    let url_path = '/e/zahirm1/social/accountchange/';

    // AJAX post
    $.post(url_path,
           json_data,
           moreInfo);
}


/* ********************************************************************************************
   | Document Ready (Only Execute After Document Has Been Loaded)
   ********************************************************************************************
   */
$(document).ready(function() {
    // handle post submission
    $('#post-button').click(submitPost);
    // handle likes
    $('.like-button').click(submitLike);
    // handle more posts
    $('#more-button').click(submitMore);
    // update account info for objective 3
    $('#account_change_form').submit(onSubmit);
});
