---
layout: page
title: Example Ruby code
permalink: /rapidconnect_ruby/
nav_order: 1
parent: Rapid Connect
grand_parent: How to connect
---

# Ruby example of AAF JWT code

```
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