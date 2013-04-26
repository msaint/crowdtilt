# Crowdtilt API Ruby Client

An extremely light-weight ruby-based http client for the Crowdtilt API

For the latest information on this project, take a look at:

* [This project's source code repo](https://github.com/msaint/crowdtilt)
* [The Crowdtilt API documentation](https://github.com/Crowdtilt/crowdtilt-api-spec)

##Usage Examples##

###Including the gem in your Gemfile###

    gem 'crowdtilt', :github => 'msaint/crowdtilt'


###Initializing the client###
Your api_key / api_secret is required to initialize the client.  Please email [support.api@crowdtilt.com](mailto: support.api@crowdtilt.com) to request credentials.

You should specify with the `mode` parameter whether you are attempting to access the `sandbox` API or the `production` API.

    Crowdtilt.configure :api_key => YOUR_API_KEY, 
                        :api_secret => YOUR_API_SECRET, 
                        :mode => API_MODE   # 'sandbox' or 'production'

###API methods###

Responses are returned as hashes.

Errors returned by the API will be raised as exceptions.

**Examples:**

Create a user:
    
    user = Crowdtilt.create_user({
      :firstname => 'John',
      :lastname => 'Smith',
      :email => 'js@example.com'
    })

Get a list of users:

    users = Crowdtilt.get_users
    
Get a specific of user:

    user = Crowdtilt.get_user('USR123')
    
Update a user:

    user = Crowdtilt.update_user('USR123', { :email => 'newemail@foo.com' })

**Raw requests:**

You can make raw requests by invoking the lower level api methods `get`, `post`, and `put`.  See [Crowdtilt's API documentation](https://github.com/Crowdtilt/crowdtilt-api-spec) for more information about the list of available resources.  Methods are called by simply passing in the URI of the resource you are accessing, along with any needed data as a hash object.

Create a user:

    user = {
      :firstname => 'John',
      :lastname => 'Smith',
      :email => 'js@example.com'
    }

    response = Crowdtilt.post('/users', { :user => user })

Get a list of users:

    response = Crowdtilt.get('/users')
