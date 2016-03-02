#!/bin/bash
# ----------------------------------------------------------------------
# Title:        English word pronunciation checker
# Author:       Daichi Shinozaki <dsdseg@gmail.com>
# URL:          https://github.com/dseg/pronunciation-checker
# Commentary:   You need to get the forvo.com API key (cost is $1 per month)
#               and the WordsAPI key (free).
#               API keys must be in ./.keys file.
# SeeAlso:      http://http://api.forvo.com/
#               https://www.wordsapi.com/
# History:      v0.1 02-Mar-2016 Initial release.
# ----------------------------------------------------------------------

# ----------------------------------------------------------------------
# Subroutines
# ----------------------------------------------------------------------

# Render the index page
render_index(){
  [ -n "$is_cgi" ] && echo -ne 'Content-type: text/html\n\n'
  mo < tmpl/index.ms
}

# Render the result page
render_result(){
  if [ -z "$is_cgi" ]; then
    local RED='\033[0;31m'
    local NOCOLOR='\033[0m'
    echo -e "word: $word, pronunciation: ${RED}$pron${NOCOLOR}"
    return
  fi
  [ -n $is_cgi ] && echo -ne 'Content-type: text/html\n\n'
  pron="$1" 
  word="$2" 
  [ -n "$3" ] && forvo_rate="$3"
  [ -n "$4" ] && mp3="$4"
  [ -n "$5" ] && ogg="$5"
  mo < tmpl/result.ms
}

# die, like Perl
die() {
  err=${1:='An error occured'}
  [ -n "$is_cgi" ] && echo -ne 'Content-type: text/plain\n\n'
  echo "FATAL: $err"
  exit 1
}

# Parse query string
declare -A query
parse_querystring(){
  local IFS='=&'
  local param=($QUERY_STRING)

  for ((i=0; i<${#param[@]}; i+=2))
  do
    query[${param[i]}]=${param[i+1]}
  done
}

# ---------------------------------------------------------------------
# Main
# ----------------------------------------------------------------------

# Check this is run as CGI
is_cgi=''
[ -n "$SCRIPT_NAME" ] && is_cgi=y

## Check for curl, jshon
curl=/usr/bin/curl
[ -f "$curl" ] || die 'curl not found.'
jshon=/usr/bin/jshon
[ -f "$jshon" ] || die 'jshon not found. Please get the jshon from http://kmkeen.com/jshon/'

# Read the API key
[ -f ./.keys ] && source ./.keys || die "Error reading the API key file from ./.keys."

## parameters for Forvo API
wordsapi_key=${WORDSAPI_KEY:?"No WordsAPI key found."}
forvo_key=${FORVO_KEY:?"No Forvo API key found."}

# Load the mush library which can handle mustache style templates
# https://github.com/tests-always-included/mo
source ./mo || die "The mo template engine doesn't found. Please download the mo first."

if [ -n "$is_cgi" ]; then
  parse_querystring
  if [ -z "${query['word']}" ]; then
    render_index
    exit 0
  fi
  word=${query['word']}
else
  word=${1:?'No word specified.'}
fi

# Embed the word to query into the query url
url="https://wordsapiv1.p.mashape.com/words/$word"

# Query to WordsAPI
res=$($curl "$url" -sL -H "X-Mashape-Key: $wordsapi_key" -H 'Accept: application/json')
if [ $? -ne 0 ]; then
  echo "Error getting response from wordsapi.com. Error code: $res"
  exit 1
fi

# TODO: Handle the error response from the server. 
# For example, 'API limit reached'

# Process the response from WordsAPI
pron=$($jshon -e pronunciation -e all -u <<<"$res")
if [ $? -ne 0 ]; then
  pron=$($jshon -e pronunciation -u <<<"$res")
fi
if [ $? -ne 0 ] || [ -z "$pron" ]; then
  render_result '' "$word"
  exit 1
fi

# Get the spoken pronuntiations (sound) from Forvo.com
url="http://apifree.forvo.com/key/$forvo_key/format/json/action/standard-pronunciation/word/$word/language/en"
res=$($curl -sL "$url")
if [ $? -ne 0 ]; then
  echo "Error getting response from forvo.com. errorcode: $res"
  exit 1
fi

# Extract the mp3 url and the phonetic transcription from the response json
# Note: Return result as 2 lines by the 'jshon' command
while true; do
  read forvo_rate
  read -r mp3
  read -r ogg  
  break
done < <($jshon -e items -e 0 -e rate -u -p -e pathmp3 -u -p -e pathogg -u <<<"$res")

render_result "$pron" "$word" "$forvo_rate" "$mp3" "$ogg"
exit 0
