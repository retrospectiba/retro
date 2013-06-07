# encoding : utf-8
require "spec_helper"

describe Retrospectives::BadsController do
  describe 'routing' do

    it "routes to #create" do
      post("/retrospectives/5/bads").should route_to("retrospectives/bads#create", :retrospective_id => "5")
    end

    it "routes to #update" do
      put("/retrospectives/1/bads/17").should route_to("retrospectives/bads#update", :retrospective_id => "1", :id => "17")
    end

    it "routes to #destroy" do
      delete("/retrospectives/78/bads/4").should route_to("retrospectives/bads#destroy", :retrospective_id => "78", :id => "4")
    end

    it "routes to #create" do
      post("/retrospectives/5/goods").should route_to("retrospectives/goods#create", :retrospective_id => "5")
    end

    it "routes to #update" do
      put("/retrospectives/1/goods/17").should route_to("retrospectives/goods#update", :retrospective_id => "1", :id => "17")
    end

    it "routes to #destroy" do
      delete("/retrospectives/78/goods/4").should route_to("retrospectives/goods#destroy", :retrospective_id => "78", :id => "4")
    end

  end
end
