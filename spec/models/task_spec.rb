require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:each) do
    @task = FactoryBot.create(:task)
  end

  describe 'Associations' do
    it { should belong_to :user }
  end
  
  describe 'Validations' do
    context 'name' do
        it 'should not be blank' do
            @task.name = nil
            expect(@task).to_not be_valid
        end
    end

    context 'description' do
        it 'should not be blank' do
            @task.description = nil
            expect(@task).to_not be_valid
        end
    end

    context 'end_time' do
      it 'should not be blank' do
          @task.end_time = nil
          expect(@task).to_not be_valid
      end
    end
    
  end 
end
