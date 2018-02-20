require 'net/http'
require 'json'
State.all.each do |state|
  i=1
  stop = false
  taluks = {}
  while(stop == false) do
    url = "https://api.data.gov.in/resource/fced6df9-a360-4e08-8ca0-f283fc74ce15?format=json&api-key=579b464db66ec23bdd000001915ff135a4c244e75f6371e952361b24&filters[_state]=#{state.name}&fields=_district&offset=#{i}&limit=1000"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result =  JSON.parse(response)
    puts i
    result['records'].uniq.each{|v|
      state.districts.find_or_create_by(:name => v["_district"])
    }
    stop = (result['count'] < 1000)
    i += 1000
  end
end

