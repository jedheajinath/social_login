module ApplicationHelper
def sign_in_url(provider)
    provider = 'google' if provider == 'google_oauth2'
    raw("<span class='btn btn-block btn-social btn-#{provider}'>
    <i class='fa fa-#{provider}'></i> Sign in with #{provider.titleize}
    </span>")
  end
end
