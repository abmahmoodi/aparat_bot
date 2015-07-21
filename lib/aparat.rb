require 'json'
require 'typhoeus'
class Aparat
  URL = 'http://www.aparat.com/'

  def video_by_search(keyword)
    keyword = keyword.gsub(' ', '%20')
    j_p = api_response('videoBySearch', "text/#{keyword}")
    uid = j_p['videobysearch'][0]['uid']
    "#{URL}v/#{uid}"
  end
  
  def best_video(number)
    j_p = api_response('mostviewedvideos')
    urls = []
    (0..number - 1).each do |i|
      uid = j_p['mostviewedvideos'][i]['uid']
      urls << "#{URL}v/#{uid}"
    end
    urls
  end
  
  private
  def api_response(api_method, param = nil)
    if param
      request = Typhoeus::Request.new("#{URL}etc/api/#{api_method}/#{param}", method: :get)
    else
      request = Typhoeus::Request.new("#{URL}etc/api/#{api_method}", method: :get)
    end
    response = request.run
    JSON.parse(response.response_body)
  end
end

# a = Aparat.new
# p a.best_video(2)
