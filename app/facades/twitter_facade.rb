require 'open3'

class TwitterFacade

    def self.get_tweets(handle)
        tweets = nil

        stdout, stderr, status = Open3.capture3("python3 ./lib/assets/python/twitter.py #{handle.downcase}")
        if status.success?
            # Process stdout
            tweets = JSON.parse(stdout)
        else
            # Handle errors in stderr
        end

        {
            'handle': handle,
            'tweets': tweets
        }
    end

end