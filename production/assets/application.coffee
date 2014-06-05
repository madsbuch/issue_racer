jQuery ->
    init = do ->
    # load user

    issuePath = 'https://api.github.com/repos/laravel/framework/issues'

    $.getJSON issuePath, (response) ->
      open = 0
      closed = 0
      for issue in response
        if issue.state == "open"
          open++
        else
          closed++

        $('body').append """
          <p><img width='50px' src='#{issue.user.avatar_url}'/> #{issue.user.login}</p>
        """

      $('body').append """
        <p>closed: #{closed} open: #{open}</p>
      """
      console.log open
