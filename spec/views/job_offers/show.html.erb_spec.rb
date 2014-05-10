require 'spec_helper'

describe "job_offers/show" do
  before(:each) do
    @employer = FactoryGirl.create(:employer)
    @job_offer = assign(:job_offer, stub_model(JobOffer,
      :description => "Description",
      :title => "Title",
      :employer => @employer,
      :start_date => Date.current + 10,
      :responsible_user => FactoryGirl.create(:staff),
      :status => FactoryGirl.create(:job_status, :name => "active")
    ))
    view.stub(:can?) { false }
    view.stub(:current_user) { FactoryGirl.create(:user) }
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Description/)
    rendered.should match(/Title/)
  end

  it "renders no applications if not signed in" do
    render
    rendered.should_not match(/Applications/)
    rendered.should_not match(/Apply/)
  end

 # it "hides the edit button if the job is running" do
 #   @job_offer.status = FactoryGirl.create(:job_status, :name => "running")
 #   @job_offer.save

 #   render

  #  rendered.should_not match(/Edit/)
  #end

  it "renders the default compensation text if applicable" do
    @job_offer.compensation = 10.0
    @job_offer.save

    render

    rendered.should match(I18n.t('job_offers.default_compensation'))
  end

  it "renders the actual compensation if its not the default one" do
    @job_offer.compensation = 11.0
    @job_offer.save

    render

    rendered.should match(@job_offer.compensation.to_s + " " + I18n.t('job_offers.compensation_description'))
  end
end
