# README

## Installation

```bash
rvm use --create ruby-3.2.3@presail
bundle install
rails db:create db:migrate
bin/dev
```

## task 1:

This is a simple Ruby on Rails app that allows users to authenticate and create a server session, using MetaMask to authenticate users with the Rails backend.

Techno used: Rails 7, Turbo, Stimulus, [ethers](https://docs.ethers.org/v6/) (to interact with metamask in frontend), [SIWE](https://docs.login.xyz/) (for backend message signing) 


### Login Workflow

1. Frontend request a wallet address from MetaMask and request the backend for a message to sign
2. Backend generates a nonce, and creates a SIWE Message for the given user's wallet address.
3. Frontend request user to sign the message with MetaMask
4. Frontend sends the signed message to the backend
5. Backend verifies the signature and creates or find a user with the given wallet address and sign in the user in Rails.
6. Frontend is now authenticated and can access protected Rails user's resources.

## task 2: tests

I wrote the pending rspec tests to have an idea of what would be the minimum logic to be tested, it includes request tests and unit tests.
Tests suites can be read running `rspec` in the terminal.

This only tests the backend part: the controller and the user model. To go a step further, we could add frontend logic tests and add end to end testing, for example with jest and synpress (for metamask interaction).
The app would be better tested with end to end tests but they are generally slower and more fragile than unit/integration tests.
Also I would add a CI/CD pipeline to make sure app is tested and deployed automatically.
