require 'rails_helper'
 
RSpec.describe "Task", type: :request do

  describe "GET /index" do
    context "With Invalid authentication" do
        it_behaves_like :deny_without_authorization, :get, "/tasks" 
    end
 
    context "ordinary user with valid authentication" do
      before do
        @user = create(:user)
        sign_in @user
        @task = create(:task)
        get "/tasks"
      end
 
      it "returns 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "admin user with valid authentication" do
        before do
            @user = create(:user)
            @user.user_type = :admin
            sign_in @user
            @task = create(:task)
            get "/tasks"
        end

        it "returns 200" do
            expect(response).to have_http_status(200)
        end
    end

  end
 
  describe "GET /tasks/id" do

    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :get, "/tasks/1"
    end
  
    context "admin user with valid authentication" do
      before do
        @user = create(:user)
        @user.user_type = :admin
        sign_in @user
        @task = create(:task)
        get "/tasks/#{@task.id}"
      end
 
      it "returns 200" do
        expect(response).to have_http_status(200)
      end

    end

    context "ordinary user with valid authentication" do
        before do
            @user = create(:user)
            sign_in @user
            @task = create(:task)
            get "/tasks/#{@task.id}"
        end

        it "returns 200" do
            expect(response).to have_http_status(200)
        end

    end

  end
 
  describe "PUT /tasks/id" do

    context "With Invalid authentication headers" do
        it_behaves_like :deny_without_authorization, :put, "/tasks/1"
    end
  
    context "admin user with valid authentication and autorization" do
        before do
            @user = create(:user)
            @user.user_type = :admin
            sign_in @user
            @task = create(:task)
            put "/tasks/#{@task.id}", params: {task: attributes_for(:task)}
        end

        it "returns 302" do
            expect(response).to have_http_status(302)
        end

    end
    
    context "ordinary user with valid authentication" do
        before do
            @user = create(:user)
            sign_in @user
            @task = create(:task)
            put "/tasks/#{@task.id}", params: {task: attributes_for(:task)}
        end

        it "returns 302" do
            expect(response).to have_http_status(302)
        end
    end
  end

  describe "POST /tasks" do

    context "With Invalid authentication headers" do
        it_behaves_like :deny_without_authorization, :post, "/tasks"
    end
  
    context "admin user with valid authentication and autorization" do
        before do
            @user = create(:user)
            @user.user_type = :admin
            sign_in @user
            post "/tasks", params: {task: attributes_for(:task)}
        end

        it "returns 302" do
            expect(response).to have_http_status(302)
        end

    end
    
    context "ordinary user with valid authentication" do
        before do
            @user = create(:user)
            sign_in @user
            post "/tasks", params: {task: attributes_for(:task)}
        end

        it "returns 302" do
            expect(response).to have_http_status(302)
        end
    end
  end

  describe "Delete /tasks/id" do

    context "With Invalid authentication headers" do
        it_behaves_like :deny_without_authorization, :delete, "/tasks/1"
    end
  
    context "admin user with valid authentication and no autorization" do
        before do
            @user = create(:user)
            @user.user_type = :admin
            sign_in @user
            @task = create(:task)
            delete "/tasks/#{@task.id}"
        end

        it "returns 302" do
            expect(response).to have_http_status(302)
        end

    end
    
    context "ordinary user with valid authentication" do
        before do
            @user = create(:user)
            sign_in @user
            @task = create(:task)
            delete "/tasks/#{@task.id}"
        end

        it "returns 302" do
            expect(response).to have_http_status(302)
        end
    end
  end
 
end
