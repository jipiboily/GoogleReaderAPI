module GoogleReader

  # the main api
  class API
    
    BASE_URL = "http://www.google.com/reader/api/0/"
    
    require "user"
    require "json"
    
    # specify email and password in the arg hash
    def initialize(opthash)
      @user = GoogleReader::User.new(opthash)
    end
    
    # get the unread count for the current user
    def unread_count
      json = fetch_unread
      if json['unreadcounts'].first
        json['unreadcounts'].first['count']
      else
        0
      end
    end
    
    def unread
      fetch_unread['unreadcounts']
    end

    def user_info
      fetch_user_info
    end
    
    private
    
    # will return the json object for the unread_request
    def fetch_unread
      get_link "unread-count" , :allcomments => true,:output => :json,:ck => Time.now.to_i
    end
    
    def fetch_user_info
      get_link "user-info" ,:ck => Time.now.to_i
    end
    
    def get_link(link,args={})
      link = BASE_URL + link
      JSON[@user.get_request(link,args)]
    end
    
  end

end