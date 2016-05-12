class HomeController < ApplicationController
  def index
  end

  def pincodes
    results = Pincode.select(:state_name, :district_name, :taluk).all.uniq.compact
    states = []
    @districts = {}
    @taluks = {}
    results.each{|r|
      states << r.state_name
      @districts[r.state_name] = [] unless @districts[r.state_name].present?
      @districts[r.state_name] << r.district_name
      @taluks[r.state_name] = {} unless @taluks[r.state_name]
      @taluks[r.state_name][r.district_name] = [] unless @taluks[r.state_name][r.district_name].present?
      @taluks[r.state_name][r.district_name] << r.taluk
    }
    @states = states.uniq.compact.sort
    @districts.each{|k, v|
      d = v.uniq.compact.sort
      @districts[k] = d
    }

    @taluks.each{|k, v|
      v.each{|k1, v1|
        t = v1.uniq.compact.sort
        @taluks[k][k1] = t
      }
    }

  end
end
