def store_url(url, **flash_hash)
  (session[:return_to] ||= []).push [url, flash_hash]
end
