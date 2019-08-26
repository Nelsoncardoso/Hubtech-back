require 'rails_helper'

RSpec.describe TaskPolicy, type: :policy do
  before(:each) do
    @task = FactoryBot.create(:task)
  end

  let(:user) { FactoryBot.create(:user) }
  let(:ordinary) { TaskPolicy.new(@task, user) }


  permissions :show? do
    context "User show his tasks" do
      it "grants access if user is an ordinary" do
        expect(ordinary).to permitted_to(:show?)
      end
    end
  end

  permissions :update? do
    context "User update his tasks" do
      it "grants access if user is an ordinary" do
        expect(ordinary).to permitted_to(:update?)
      end
    end
  end

  permissions :delete? do
    context "User update his tasks" do
      it "grants access if user is an ordinary" do
        expect(ordinary).to permitted_to(:update?)
      end
    end
  end

end
