Gmail Filter Maker
==================

I made this silly app mostly as a means to play with Ruby. It helps the user quickly and easily create an XML file that can be imported into Gmail's filters and will filter email with labels according to those rules.

####The why:
When I was tutoring, I had many emails coming from students and parents, and I wanted to quickly make gmail labels that would auto-label incoming and outgoing messages with each student's name. To do so in gmail, I had to create 2-4 labels per student (separate rules for incoming, outgoing, and parents' and students' email addresses). I knew there had to be a better way, so I exported my existing labels and examined the XML so I could quickly mimic it to create new labels programmatically.

###How to use:
####Go to the app [here](http://damp-scrubland-2265.herokuapp.com/gmailapp).
Enter a label name followed by a colon then the email addresses you want associated with that label (each email address separated by commas). You can optionally add a pipe and any search terms you want associated with that label in quotes. Example:
<pre>
    labelName: email@gmail.com, other@yahoo.com | "Student Fullname"
</pre>
Separate entries with a return, press "Go!", and you get back some slick XML that you can upload in your gmail settings ("Settings" > "Filters" > scroll down to bottom: "Import filters"). BAM! Now you're auto-labeling up a storm!

###Future:
This was my first go at Ruby and with using Sinatra and Heroku. Needless to say, there's much improvement that could be done. For example, it would be great to model the filters with a class or something -- right now they are just plain ole' text. I should also OBVIOUSLY be cleaning user input. Heh. My apologies!

##License:
Use and abuse! Do what you will with this.
