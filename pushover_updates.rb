require "net/https"

Earthquake.init do
    output do |item|
        case item["event"]
        when "follow"
            user = twitter.show(item["source"]["screen_name"])
            if user.key?("error")
                user = twitter.status(m[1])["user"] || {}
            end
            _send_to_pushover("#{user["description"]}",
                              "Follower : #{item["source"]["screen_name"]} (#{item["source"]["name"]})",
                              "https://twitter.com/#{item["source"]["screen_name"]}")
        when "favorite"
            _send_to_pushover("#{item["target_object"]["text"]}",
                              "Favori : #{item["source"]["screen_name"]}",
                              "https://twitter.com/Neurolit/status/#{item["target_object"]["id"]}")
        end
    end

    command :pushover do
        puts _send_to_pushover("Sent by earthquake","Test")
    end

    def self._send_to_pushover(message,title,message_url="")
        url = URI.parse("https://api.pushover.net/1/messages.json")
        req = Net::HTTP::Post.new(url.path)
        req.set_form_data({
            :token => Earthquake.config[:pushover][:token],
            :user => Earthquake.config[:pushover][:user],
            :message => message,
            :title => title,
            :url => message_url
        })
        res = Net::HTTP.new(url.host, url.port)
        res.use_ssl = true
        res.verify_mode = OpenSSL::SSL::VERIFY_PEER
        res.start {|http| http.request(req) }
        return Earthquake.config[:pushover][:token]
    end
end
