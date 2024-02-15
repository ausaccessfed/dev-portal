---
layout: page
title: Example Python code
permalink: /rapidconnect_python/
nav_exclude: true
parent: Rapid Connect
grand_parent: How to connect
---

# Python example of AAF JWT code

```
import webapp2
import os
import jwt

from webapp2_extras import sessions
from google.appengine.ext.webapp import template

config = {}
config['webapp2_extras.sessions'] = {
    'secret_key': 'LOCAL_SECRET',
}
config['aaf.edu.au'] = {
  'iss': 'https://rapid.aaf.edu.au',
  'aud': 'https://aaf-echo.appspot.com',
}

class BaseHandler(webapp2.RequestHandler):
  def dispatch(self):
    self.session_store = sessions.get_store(request=self.request)

    try:
      webapp2.RequestHandler.dispatch(self)
    finally:
      self.session_store.save_sessions(self.response)

  @webapp2.cached_property
  def session(self):
      return self.session_store.get_session()

class RootHandler(BaseHandler):
  def get(self):
    print self.session
    self.response.out.write(template.render('views/index.html', {}))

class WelcomeHandler(BaseHandler):
  def get(self):
    if 'attributes' in self.session:
      self.response.out.write(template.render('views/welcome.html', {'attributes':sorted(self.session['attributes'].iteritems()), 'jwt':sorted(self.session['jwt'].iteritems()), 'jws':self.session['jws']}))
    else:
     self.redirect('/')

class AuthHandler(BaseHandler):
  def post(self):
    try:
      # Verifies signature and expiry time
      verified_jwt = jwt.decode(self.request.POST['assertion'], "SECRET")
      
      # In a complete app we'd also store and validate the jti value to ensure there is no replay attack
      if verified_jwt['aud'] == config['aaf.edu.au']['aud'] &&
         verified_jwt['iss'] == config['aaf.edu.au']['iss']:
        self.session['attributes'] = verified_jwt['https://aaf.edu.au/attributes']
        self.session['jwt'] = verified_jwt
        self.session['jws'] = self.request.POST['assertion']
        self.redirect('/welcome')
      else:
        self.status = 403
        self.response.write('Error: Not for this audience')
    except jwt.ExpiredSignature:
      self.status = 403
      self.response.write('Error: Security cookie has expired')

class LogoutHandler(BaseHandler):
  def get(self):
    self.session.clear()
    self.redirect('/')

app = webapp2.WSGIApplication([
  (r'/', RootHandler),
  (r'/welcome', WelcomeHandler),
  (r'/auth/jwt', AuthHandler),
  (r'/logout', LogoutHandler),
], config=config)
```