<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="/rsrc/common.css"></style> 
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/css/bootstrap.min.css">
</head>
<body>
 <div class="panel panel-primary">
  <div class="panel-heading">
   <h1 class="panel-title">Word: {{word}}</h1>
  </div>
  <div class="panel-body">
   {{#pron}}
   <h1>{{pron}}</h1>
   {{/pron}}
   {{^pron}}
   <h2>No match found.</h2>
   {{/pron}}
  </div>
  <div class="panel-footer">
   {{#forvo_rate}}
   <h4>rate: {{forvo_rate}}</h4>
   {{/forvo_rate}}
   {{#mp3}}
   <audio controls="controls" autoload="none" volume="1">
    <source src="{{mp3}}" type="audio/mp3">
   </audio>
   {{/mp3}}   
  </div>
 </div>
 <hr>
 <form class="form-horizontal" action="/pron/pron.cgi" method="GET">
  <fieldset>
   <!-- Form Name -->
   <legend>Check another word</legend>
   <!-- Text input-->
   <div class="form-group">
    <label class="col-md-4 control-label" for="word">Word</label>
    <div class="col-md-4">
     <input id="word" name="word" type="text" placeholder="word" class="form-control input-md" required="">
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
