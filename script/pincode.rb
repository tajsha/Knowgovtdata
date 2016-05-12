require 'net/http'
require 'json'
i=600
stop = false
taluks = {}
while(stop == false) do
  url = "https://data.gov.in/api/datastore/resource.json?resource_id=0a076478-3fd3-4e2c-b2d2-581876f56d77&api-key=5f50a64949e68cf3fa3eadb5b1310d81&sort[statename]=asc&offset=#{i}&limit=100"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  result =  JSON.parse(response)
  puts i
  result['records'].uniq.each{|v|
   Pincode.find_or_create_by(:timestamp => v['timestamp'], :office_name => v['officename'], :pincode => v['pincode'],
                             :office_type => v['officeType'], :delivery_status => v['Deliverystatus'], :division_name => v['divisionname'],
                             :region_name => v['regionname'], :circle_name => v['circlename'], :taluk => v['Taluk'],
                             :district_name => v['Districtname'], :state_name => v['statename'], :telephone => v['Telephone'],
                             :related_sub_office => v['Related Suboffice'], :related_head_office => v['Related Headoffice']
                            )
  }
  stop = (result['count'] < 100)
  i += 1
end

