# Resets the map
reset = ->
  $('#issueRacer').html("")

# Takes a raw github URL and makes the api url
formatUrl = (baseUrl) ->
  theSplit = baseUrl.split('/')
  repo = theSplit[3]+"/"+theSplit[4]
  "https://api.github.com/repos/#{repo}/issues?state=closed"

# prints a user to the div
printIssue = (user) ->
  $('#issueRacer').append """
    <div>
      <img width='50px' src='#{user.avatar_url}'/>
      #{user.login}
    </div>
  """

# Does stuff
doStuff = (issuePath) ->
  
  $.getJSON issuePath, (response) ->
    for issue in response
      printIssue issue.user

#  Initialize everything!
$ ->
    init = do ->
    # load user

    issuePath = 'https://api.github.com/repos/laravel/framework/issues'
    doStuff issuePath
    $(document).on "change", "[name='repo']", (e) ->
       path = $("[name='repo']").val()
       # validate here
       reset()
       doStuff (formatUrl path)

    
