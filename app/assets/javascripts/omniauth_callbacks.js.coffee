# this is a known issue with facebook authentication
if window.location.hash is '#_=_'
  window.location = ''
