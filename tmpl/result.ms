<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" link="/rsrc/common.css"></style> 
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/css/bootstrap.min.css">
</head>
<body>
 <div class="panel panel-primary">
  <div class="panel-heading">
   <h1 class="panel-title">Word: {{word}}</h1>
  </div>
  <div class="panel-body">
   <h1>{{pron}}</h1>
  </div>
  <div class="panel-footer">
   {{#forvo_rate}}
   <h4>rate: {{forvo_rate}}</h4>
   {{/forvo_rate}}
   {{#mp3}}
   <audio muted="muted" controls="controls" volume="0.5">
    <source src="{{mp3}}" type="audio/mp3">
   </audio>
   {{/mp3}}   
  </div>
 </div>
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.6/js/bootstrap.min.js"></script>
</body>
</html>
