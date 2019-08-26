require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  describe 'Associations' do
    it { should have_many :tasks }
  end

  
  describe 'Validations' do
    context 'email' do
        it 'should not be blank' do
            user_repeated = FactoryBot.create(:user)
            user_repeated.email = nil
            expect(user_repeated).to_not be_valid
        end
    end

    context 'name' do
        it 'should not be blank' do
            @user.name = nil
            expect(@user).to_not be_valid
        end
    end
    
  end 
end
