---
title: Integration Examples
order: 6
duration: 1
last_updated: 07 March, 2025
---
<br>

### 1. **JWT Code Examples**
The following code examples have been developed by AAF and may assist your understanding when writing your own 
integration code. We have provided code written in Ruby, Python and PHP.

#### Ruby

```ruby
  require 'sinatra'
  require 'json'
  require 'json/jwt'
   
  use Rack::Session::Pool, :expire_after => 3600
   
  get '/' do
    erb :index
  end
   
  get '/welcome' do
    if session[:attributes]
      @attributes = session[:attributes]
      @jwt = session[:jwt]
      erb :welcome
    else
      redirect '/'
    end
  end
   
  get '/logout' do
    session.clear
    redirect '/'
  end
   
  post '/auth/jwt' do
    jws = params[:assertion]
   
    if jws
      begin
        jwt = JSON::JWT.decode(jws.to_s, "SECRET")
   
        # In a complete app we'd also store and validate the jti value to ensure there is no replay attack
        if jwt['iss'] == 'https://rapid.aaf.edu.au' && jwt['aud'] == 'https://aaf-echo.herokuapp.com' && 
           Time.now > Time.at(jwt['nbf']) && Time.now < Time.at(jwt['exp'])
          attributes = jwt['https://aaf.edu.au/attributes']
          session[:attributes] = attributes
          session[:jwt] = jwt
          redirect '/welcome'
        else
          halt 500, "Audience or timings are invalid"
        end
      rescue Exception => e
        halt 500, "Signature was invalid or JWT was otherwise erroneous"
      end
    else
      halt 500, "JWS was not found in request"
    end
  end
```

<br>
#### Python

```python
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

<br>

#### PHP

```php
  <?php
  
  use JWT\Authentication\JWT;
  
  Route::get('/', function()
  {
    return View::make('root');
  });
  
  Route::get('/welcome', function()
  {
    $jwt = Session::get('jwt');
    $jws = Session::get('jws');
    $attributes = $jwt->{'https://aaf.edu.au/attributes'};
    return View::make('welcome', array('jws' => $jws, 'jwt' => $jwt, 'attributes' => $attributes));
  });
  
  Route::get('/logout', function()
  {
    Session::flush();
    return Redirect::to('https://aaf-echo.gopagoda.com');
  });
  
  Route::post('/auth/jwt', function()
  {
    $jws = Input::get('assertion');
    $jwt = JWT::decode($jws, 'SECRET');
  
    # In a complete app we'd also store and validate the jti value to ensure there is no replay attack
    $now = strtotime("now");
    if( $jwt->iss == 'https://rapid.aaf.edu.au' && 
        $jwt->aud == 'https://aaf-echo.gopagoda.com' && $now > $jwt->nbf && $now < $jwt->exp) {
      Session::put('jws', $jws);
      Session::put('jwt', $jwt);
      return Redirect::to('https://aaf-echo.gopagoda.com/welcome');
    } else {
      App::abort(403,"JWS was invalid");
    }
  });
```

<br>

### 2. AAF Rapid Connect - Ruby Sample App
For a more developed example, [refer to this Ruby sample application](https://github.com/ausaccessfed/rapidconnect-sample-ruby). It is provided purely for illustrative
purposes. It should be noted that the code presented here should not be used as a base to build your application, but is provided to give you an idea of the concepts behind connecting a service, so you can pick it apart (everybody’s requirements are different and just cutting and pasting the code won’t generally work if you decide to do that). No effort has been made to audit the code's security, or make it production-ready.
