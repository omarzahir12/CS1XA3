function Resume ()
{
    window.location.href='Resume-PDF.pdf'
}

$(document).ready(function()
{
    var counter = 1;                                                            // sets counter for determining the toggle for time/date button
    $("#time_button").click(function() 
    { 
        var t = new Date();                                                     // gets standard date, and the following variables hold specific parts of the date
        var d = t.getDate();
        var m = t.getMonth();
        var y = t.getFullYear();
        var day = t.getDay();
        var h = t.getHours();
        var min = t.getMinutes();
        var timetype = "PM";
        if ((h < 12)) {
            timetype = "AM"
        }
        var mn = [                                                              // used to convert the value of the month in numbers into the name
            "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
          ]; 
          var dow = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];          // used to convert the value of the day in numbers into the name
        if ((counter % 2) == 0) {                                               // gives the day for even and time for odd values of counter
        document.getElementById("t-disp").innerHTML = dow [day] + ", " + mn[m] + " " + d; // gives the day, date and month
        document.getElementById("time_button").innerHTML = "What Time is it?"
        }
        else if ((counter % 2) != 0) {
            if (min < 10) {                                                     // this is to add a 0 infront of single minute time
                min = '0'+min
            }
            document.getElementById("t-disp").innerHTML = h%12+":"+min+" "+timetype;         //gives the hour:minute time
            document.getElementById("time_button").innerHTML = "What Date is it?" //changes display to time and date
            }
        counter ++
    });

    $("#offline").click(function()
    {
        
        if (navigator.onLine) {                                                  //method that returns true if there is a connection and false if not
            document.getElementById("off").innerHTML = "You Are Online!";       //gives appropriate disclaimer
        }	
        else {
            document.getElementById("off").innerHTML = "You Are Offline...";
        }
        
    });

    $("#bb").mouseover(function()                                               //animates all the skill bars on the hover
    {
        $('#py').animate({width:'90%'}, 2000)
        $('#jv').animate({width:'80%'}, 2000)
        $('#web').animate({width:'70%'}, 2000)
        $('#hk').animate({width:'80%'}, 2000)
        $('#sh').animate({width:'80%'}, 2000)
    });

    $("#bb").mouseleave(function()                                              //animates them back after hover
    {
        $('#py').animate({width:'12%'}, 1000)
        $('#jv').animate({width:'12%'}, 1000)
        $('#web').animate({width:'12%'}, 1000)
        $('#hk').animate({width:'12%'}, 1000)
        $('#sh').animate({width:'12%'}, 1000)
    });

    $("#soybean_eclipse").click(function() // the following functions target certain types of elements on the page, removing their current classes and adding everything back except for a different color
    {                                       
        $('.card').removeClass().addClass('zoom card w3-soybean w3-text-grey w3-card-4');
        $('.cardb').removeClass().addClass('zoom cardb w3-container w3-soybean w3-card w3-margin-bottom');
        $('.cardrb').removeClass().addClass('zoom cardrb w3-container w3-soybean w3-card round-edge w3-margin-bottom');
        $('#back').removeClass().addClass('w3-eclipse');
        $('#time_button').removeClass().addClass('w3-soybean nobord w3-hover-eclipse');
        $('#offline').removeClass().addClass('w3-soybean nobord w3-hover-eclipse');
        $('#resume').removeClass().addClass('w3-soybean nobord w3-hover-eclipse');
    });
    
    $("#mint_midnight").click(function()
    {
        $('.card').removeClass().addClass('zoom card w3-mint w3-text-grey w3-card-4');
        $('.cardb').removeClass().addClass('zoom cardb w3-container w3-card w3-mint w3-margin-bottom');
        $('.cardrb').removeClass().addClass('zoom cardrb w3-container round-edge w3-card w3-mint w3-margin-bottom');
        $('#back').removeClass().addClass('w3-midnight');
        $('#time_button').removeClass().addClass('w3-mint nobord w3-hover-midnight');
        $('#offline').removeClass().addClass('w3-mint nobord w3-hover-midnight');
        $('#resume').removeClass().addClass('w3-mint nobord w3-hover-midnight');
    });

    $("#inca_sage").click(function()
    {
        $(".card").removeClass().addClass('zoom card w3-inca w3-text-grey w3-card-4');
        $(".cardb").removeClass().addClass('zoom cardb w3-container w3-card w3-inca w3-margin-bottom');
        $(".cardrb").removeClass().addClass('zoom cardrb w3-container round-edge w3-card w3-inca w3-margin-bottom');
        $("#back").removeClass().addClass('w3-sage');
        $('#time_button').removeClass().addClass('w3-inca nobord w3-hover-sage');
        $('#offline').removeClass().addClass('w3-inca nobord w3-hover-sage');
        $('#resume').removeClass().addClass('w3-inca nobord w3-hover-sage');
    });

    $("#mellow_fire").click(function()
    {
        $('.card').removeClass().addClass('zoom card w3-mellow w3-text-grey w3-card-4');
        $('.cardb').removeClass().addClass('zoom cardb w3-container w3-card w3-mellow w3-margin-bottom');
        $('.cardrb').removeClass().addClass('zoom cardrb w3-container round-edge w3-card w3-mellow w3-margin-bottom');
        $('#back').removeClass().addClass('w3-fire');
        $('#time_button').removeClass().addClass('w3-mellow nobord w3-hover-fire');
        $('#offline').removeClass().addClass('w3-mellow nobord w3-hover-fire');
        $('#resume').removeClass().addClass('w3-mellow nobord w3-hover-fire');
    });

    $("#princess_aspen").click(function() 
    { 
        $('.card').removeClass().addClass('zoom card w3-princess w3-text-grey w3-card-4');
        $('.cardb').removeClass().addClass('zoom cardb w3-container w3-card w3-princess w3-margin-bottom');
        $('.cardrb').removeClass().addClass('zoom cardrb w3-container w3-card round-edge w3-princess w3-margin-bottom');
        $('#back').removeClass().addClass('w3-aspen');
        $('#time_button').removeClass().addClass('w3-princess nobord w3-hover-aspen');
        $('#offline').removeClass().addClass('w3-princess nobord w3-hover-aspen');
        $('#resume').removeClass().addClass('w3-princess nobord w3-hover-aspen');
    });

});
