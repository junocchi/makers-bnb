require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

describe Application do
  include Rack::Test::Methods
  
  let(:app) { Application.new }

  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include('<title>CloudBnB</title>')
      expect(response.body).to include('<div class="logo"> <img src="images/logo_cloudbnb.jpeg" alt="Cloudbnb logo" /> </div>')
      expect(response.body).to include('<input type="text" placeholder="email address">')
    end
  end
  
  context 'GET /login' do
    it 'should get the login page' do
      response = get('/login')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1 class="mast">Feel at home, anywhere</h1>')
      expect(response.body).to include('<form method="POST" action="login">')
      expect(response.body).to include('<input type="submit" value="Log in"  />')
    end
  end

  context 'POST /login' do
    it "should log the user in" do
      response = post('/login', username: 'kasey_christiansen', password_digest: '$2a$12$iOiBEcDs1dyW6n82QKHPoeli4QB9teFM9NPX/37Poe/jtpRmta1aW')

    end
  end

  context 'GET /spaces' do
    xit 'should return the spaces page after logging in' do
      response = get('/spaces')

      expect(response.status).to eq 200
      expect(response.body).to include('<label for="Available from DD/MM/YYYY"></label>')
      expect(response.body).to include('<label for="Available to DD/MM/YYYY"></label>')
      expect(response.body).to include('<link rel="stylesheet" href="/style.css" >')
    end

    it 'should redirect the user to /login page if not logged in' do
      response = get('/spaces')

      expect(response.status).to eq 302
    end
  end

  context 'GET /create-space' do
    xit 'should return a page to list your space after logging in' do
      response = get('/create-space')

      expect(response.status).to eq 200
      expect(response.body).to include('<<label for="property_name">Name</label>')
      expect(response.body).to include('<label for="description">Description</label>')
      expect(response.body).to include('<label for="price">Price per night</label>')
      expect(response.body).to include('<label for="start-date">Start date</label>')
      expect(response.body).to include('<label for="end-date">End date</label>')
    end

    it 'should redirect the user to /login page if not logged in' do
      response = get('/spaces')

      expect(response.status).to eq 302
    end
  end

  context 'GET /requests' do
    xit 'should return the request page if logged in' do
      response = get('/requests')

      expect(response.status).to eq 200
      expect(response.body).to include()
      expect(response.body).to include()
      expect(response.body).to include()
    end

    it 'should redirect the user to the login page if not logged in' do
      response = get('/requests')

      expect(response.status).to eq 302
    end
  end

  context 'GET to /book' do
    it 'renders the book page' do
      # post(
      #   '/register',
      #   username: 'tester',
      #   firstname: 'Testy',
      #   lastname: 'McTest',
      #   email: 'tester@test.com',
      #   password: 'password'
      # )

      
      response = post(
        '/login',
        username: 'tester',
        password: 'password'
      )

      response = get('/spaces')
      expect(response.body).to include('<h1>Book a Space </h1>')

      # response = get('/book/1')
      # expect(response.status).to eq 200
      # space = Space.find(1)
      # expect(response.body).to include(space.description)
    end
  end
end
