---
layout: page
title: Example PHP code
permalink: /rapidconnect_php/
nav_exclude: true
parent: Rapid Connect
grand_parent: How to connect
---

# PHP example of AAF JWT code

```
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