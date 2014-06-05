# Resets the map
reset = ->
  $('#collaboraters').html("")

# Takes a raw github URL and makes the api url
formatUrl = (baseUrl) ->
  theSplit = baseUrl.split('/')
  repo = theSplit[3]+"/"+theSplit[4]
  "https://api.github.com/repos/#{repo}/issues"

userList = []
# prints a user to the div
printIssue = (user) ->
  if $.inArray(user.login, userList) >= 0
    return

  userList.push(user.login)
  $('#collaboraters').append """
    <div data-name="#{user.login}" class="collaborator" style="float:left;">
      <img width='50px' src='#{user.avatar_url}'/>
    </div>
  """

# Does stuff
doStuff = (issuePath) ->

  # Open issues
  $.getJSON issuePath, (response) ->
    count=0
    for issue in response
      printIssue issue.user
      count++
    $('#collaboraters').attr("data-open", count)

    # Closed issues
    $.getJSON issuePath+"?state=closed", (response) ->
      count=0
      for issue in response
        printIssue issue.user
        count++
      $('#collaboraters').attr("data-closed", count)
      $(document).trigger('stuffDone')
  

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

    
