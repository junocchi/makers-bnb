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
      expect(response.body).to include('<link rel="stylesheet" href="/style.css" >')
      expect(response.body).to include('<input type="submit" name="Sign up!" />')
    end
  end
  
  context 'GET /login' do
    it 'should get the login page' do
      response = get('/login')

      expect(response.status).to eq(200)
      expect(response.body).to include('<title>CloudBnB</title>')
      expect(response.body).to include('<h1 class="mast">Feel at home, anywhere</h1>')
      expect(response.body).to include('<input type="submit" value="Log in"  />')
    end
  end

  context 'POST /login' do
    it "should log the user in" do
      response = post('/login', username: 'kasey_christiansen', password_digest: '$2a$12$iOiBEcDs1dyW6n82QKHPoeli4QB9teFM9NPX/37Poe/jtpRmta1aW')

      expect(response.status).to eq 200
    end
  end

  context 'GET /spaces' do
    it 'should return the spaces page after logging in' do
      response = post(
        '/login',
        username: 'tester',
        password: 'password'
      )

      response = get('/spaces')

      expect(response.status).to eq 200
      expect(response.body).to include('<label for="Available from DD/MM/YYYY"></label>')
      expect(response.body).to include('<label for="Available to DD/MM/YYYY"></label>')
      expect(response.body).to include('<link rel="stylesheet" href="/style.css" >')
    end

    it 'should redirect the user to /login page if not logged in' do
      response = get('/spaces')

      expect(response.status).to eq 200
    end
  end

  context 'GET /create-space' do
    it 'should return a page to list your space after logging in' do
      response = post(
        '/login',
        username: 'tester',
        password: 'password'
      )

      response = get('/create-space')

      expect(response.status).to eq 200
      expect(response.body).to include('<label for="description">Description</label>')
      expect(response.body).to include('<label for="price">Price per night</label>')
      expect(response.body).to include('<label for="start-date">Start date</label>')
      expect(response.body).to include('<label for="end-date">End date</label>')
    end

    it 'should redirect the user to /login page if not logged in' do
      response = get('/spaces')

      expect(response.status).to eq 200
    end
  end

  context 'GET /requests' do
    it 'should return the request page if logged in' do
      response = post(
        '/login',
        username: 'tester',
        password: 'password'
      )

      response = get('/requests')

      expect(response.status).to eq 200
      expect(response.body).to include('<h1 class="mast">Requests</h1>')
      expect(response.body).to include('<h2>Booking requests</h2>')
      expect(response.body).to include('<h2>Booking requests for my spaces</h2>')
    end

    it 'should redirect the user to the login page if not logged in' do
      response = get('/requests')

      expect(response.status).to eq 200
    end
  end

  context 'GET /book' do
    it 'renders the book page' do
      response = post(
        '/login',
        username: 'tester',
        password: 'password'
      )

      response = get('/spaces')
      expect(response.body).to include('<h1>Book a Space </h1>')
    end
  end
end
