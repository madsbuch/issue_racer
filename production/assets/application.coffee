jQuery ->
  init = do ->
    # load user

    issuePath = 'https://api.github.com/repos/laravel/framework/issues'

    $.getJSON issuePath, (response) ->
      for issue in response
        $('body').append """
          <p><img width='50px' src='#{issue.user.avatar_url}'/> #{issue.user.login}</p>
        """
