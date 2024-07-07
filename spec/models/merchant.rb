require "rails_helper"


RSpec.describe Merchant, type: :model do
 # Test validations
 	let(:merchant) {FactoryBot.build(:merchant)}

 	context "Merchant Name" do
 		it "should return name" do
 			expect(merchant.first_name).to eq "Yose"
 		end
 	end

end