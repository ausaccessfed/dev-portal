---
title: Connection Types
order: 2
duration: 1
---

Choose which protocol your service will use to connect. Each protocol has its own benefits and drawbacks and the choice will depend on your organisation's requirements and preferences.

<div class="row row-cols-1 row-cols-md-2 g-4 mt-4">
  <div class="col">
    <div class="card">
    <div class="card-header text-white bg-dark">OpenID Connect</div>
      <div class="card-body">
        <p class="card-text">An OpenID Connect implementation (officially the service is called "AAF Central")</p>
        <ul class="list-group list-group-flush">
          <li class="list-group-item"><i class="fa-regular fa-circle-check"></i> Recommended for most connections</li>
          <li class="list-group-item"><i class="fa-regular fa-circle-check"></i> Feature-rich</li>
          <li class="list-group-item"><i class="fa-regular fa-circle-check"></i> Many open-source libraries</li>
        </ul>
        <a href="#" class="btn btn-primary">Go somewhere</a>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card text-white bg-primary mb-3">
      <div class="card-header">Rapid Connect</div>
      <div class="card-body">
        <p class="card-text">A JSON Web Token authentication option</p>
        <ul class="list-group list-group-flush">
          <li class="list-group-item"><i class="fa-regular fa-circle-check"></i> Simple</li>
          <li class="list-group-item"><i class="fa-regular fa-circle-check"></i> Easy to test and deploy</li>
          <li class="list-group-item"><i class="fa-regular fa-circle-check"></i> Connect your service to our test 
environment, straight away, for free. There's no need to wait for an approval 
  process.</li>
        </ul>
      </div>
    </div>
    </div>
  </div>
  <div class="col">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">Card title</h5>
        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content.</p>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">Card title</h5>
        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
      </div>
    </div>
  </div>

Rapid Connect
**A JSON Web Token authentication option**
- [x] 
- [x] 
    - 
    - With Rapid Connect, you can deploy your services anywhere. Connect on-premise services, or use cloud providers 
      like AWS, Azure, Google, or Heroku.
- [x] Wide language support
    - Rapid Connect integrates natively into commonly used development languages like Python, PHP, Java, and Ruby.
- [x] Low code
    - With Rapid Connect, you can set up authentication in as few as 20 lines of Ruby. Implementations in other 
  languages are similarly slim.

*Drawbacks*
- Narrow feature set
- Few open-source libraries

SAML

- [x] Feature-rich
- [x] Many open-source libraries
- [x] Allows participation in eduGAIN
- [x] Use the SAML protocols which are implemented using [Shibboleth](https://www.shibboleth.net/) or [SimpleSAMLphp](https://simplesamlphp.org/)
  as open source options

*Drawbacks*
- Complex