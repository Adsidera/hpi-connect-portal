# == Schema Information
#
# Table name: faqs
#
#  id         :integer          not null, primary key
#  question   :string(255)
#  answer     :text
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Faq do
	before(:each) do
    	@faq = Faq.new("question" => "How do I make edits to my profile?", "answer" => "Log in to your account. Then hover over My Profile at the top right of the page. Choose the Edit-Button.")
	end 

	describe "validation of parameters" do
		
		it "with question not present" do
			@faq.question = nil
			@faq.should be_invalid
		end

		it "with answer not present" do
			@faq.answer = nil
			@faq.should be_invalid
		end

		it "with all necessary parameters present" do
			@faq.should be_valid
		end

	end
	after(:each) do
		@chair = nil
	end
end