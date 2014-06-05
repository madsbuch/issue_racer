# Resets the map
reset = ->
  $('#issueRacer').html("")

# Takes a raw github URL and makes the api url
formatUrl = (baseUrl) ->
  newurl = baseUrl.split('/')
  newurl[2] = "api."+newurl[2]+"/repos"
  newurl = newurl.join('/')+"/issues"
  newurl


# Does stuff
doStuff = (issuePath) ->
  $.getJSON issuePath+"?state=closed", (response) ->
    open = 0
    closed = 0
    for issue in response
      if issue.state == "open"
        open++
      else
        closed++

      $('#issueRacer').append """
        <p><img width='50px' src='#{issue.user.avatar_url}'/> #{issue.user.login}</p>
      """

    $('#issueRacer').append """
      <p>closed: #{closed} open: #{open}</p>
    """
    console.log open, closed

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

    
