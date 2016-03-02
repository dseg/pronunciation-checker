<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <title>An English Word Pronunciation Check Tool</title>
 <link rel="stylesheet" href="/pron/rsrc/common.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/css/bootstrap.min.css">
</head>
<body> 
 <form class="form-horizontal" action="/pron/pron.cgi" method="GET">
  <fieldset>
   <!-- Form Name -->
   <legend>Pronunciation Checker for English Word</legend>
   <!-- Text input-->
   <div class="form-group">
    <label class="col-md-4 control-label" for="word">Word</label>
    <div class="col-md-4">
     <input id="word" name="word" type="text" placeholder="type only one word" class="form-control input-md" required="">
    </div>
   </div>
   <!-- Button -->
   <div class="form-group">
    <label class="col-md-4 control-label" for="singlebutton"></label>
    <div class="col-md-4">
     <button class="btn btn-primary">Send</button>
    </div>
   </div>
  </fieldset>
 </form>
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/js/bootstrap.min.js"></script>
</body>
</html>
