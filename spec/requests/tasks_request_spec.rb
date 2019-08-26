require 'rails_helper'
 
RSpec.describe "Task", type: :request do

  describe "GET /index" do

    context "With Invalid authentication" do
        it_behaves_like :deny_without_authorization, :get, "/tasks" 
    end
 
    context "ordinary user with valid authentication" do
      before do
        @user = create(:user)
        
        10.times do
            task = FactoryBot.create(:task)
            task.user = @user
            task.save
        end

        auth = @user.create_new_auth_token.merge({'HTTP_ACCEPT'=> 'application/json'})
        get "/tasks", params: {}, headers: auth
      end
 
      it "returns 200" do
        expect(response).to have_http_status(200)
      end

      it "returns all user tasks" do
        json = JSON.parse(response.body)
        tasks = @user.tasks
        expect(json.count).to eql(tasks.count)
        tasks.each do |task|
            json.each do |t|
                if task.id == t["id"]
                    expect(task.name).to eql(t["name"])
                    expect(task.description).to eql(t["description"])
                end
            end
        end
      end
    end

  end
 
  describe "GET /tasks/id" do

    context "With Invalid authentication headers" do
      it_behaves_like :deny_without_authorization, :get, "/tasks/1"
    end
  
    context "with valid authentication and no autorization" do
      before do
        @user = create(:user)
        another_user = create(:user)

        task = FactoryBot.create(:task)
        task.user = another_user
        task.save
        
        #@task = create(:task)
        auth = @user.create_new_auth_token.merge({'HTTP_ACCEPT'=> 'application/json'})
        get "/tasks/#{task.id}", params: {}, headers: auth
      end
 
      it "returns 401" do
        expect(response).to have_http_status(401)
      end

    end

    context "with valid authentication and autorization" do
        before do
          @user = create(:user)

          @task = FactoryBot.create(:task)
          @task.user = @user
          @task.save
          
          auth = @user.create_new_auth_token.merge({'HTTP_ACCEPT'=> 'application/json'})
          get "/tasks/#{@task.id}", params: {}, headers: auth
        end
   
        it "returns 200" do
          expect(response).to have_http_status(200)
        end

        it "returns the current tasks" do
            json = JSON.parse(response.body)
            expect(@task.id).to eql(json["id"])
            expect(@task.name).to eql(json["name"])
            expect(@task.description).to eql(json["description"])
        end
    end


  end
 
  describe "PUT /tasks/id" do

    context "With Invalid authentication headers" do
        it_behaves_like :deny_without_authorization, :put, "/tasks/1"
    end

    context "with valid authentication and no autorization" do
        before do
            @user = create(:user)
            another_user = create(:user)

            task = FactoryBot.create(:task)
            task.user = another_user
            task.save
            
            
            auth = @user.create_new_auth_token.merge({'HTTP_ACCEPT'=> 'application/json'})
            put "/tasks/#{task.id}", params: {task: attributes_for(:task)}, headers: auth
        end

        it "returns 401" do
            expect(response).to have_http_status(401)
        end
    end

    context "with valid authentication and autorization" do
        before do
          @user = create(:user)

          task = FactoryBot.create(:task)
          task.user = @user
          task.save
          
          @updated_task = attributes_for(:task)
          auth = @user.create_new_auth_token.merge({'HTTP_ACCEPT'=> 'application/json'})
          put "/tasks/#{task.id}", params: {task: @updated_task}, headers: auth
        end
   
        it "returns 200" do
          expect(response).to have_http_status(200)
        end

        it "returns the current tasks" do
            json = JSON.parse(response.body)
            expect(@updated_task[:name]).to eql(json["name"])
            expect(@updated_task[:description]).to eql(json["description"])
        end
    end

  end

  describe "POST /tasks" do

    context "With Invalid authentication headers" do
        it_behaves_like :deny_without_authorization, :post, "/tasks"
    end

    context "ordinary user with valid authentication" do
        before do
            @user = create(:user)
            sign_in @user
            auth = @user.create_new_auth_token.merge({'HTTP_ACCEPT'=> 'application/json'})
            post "/tasks", params: {task: attributes_for(:task)}, headers: auth
        end

        it "returns 200" do
            expect(response).to have_http_status(200)
            expect(Task.all.count).to eql(1)
        end
    end

  end

  describe "Delete /tasks/id" do

    context "With Invalid authentication headers" do
        it_behaves_like :deny_without_authorization, :delete, "/tasks/1"
    end

    context "with valid authentication and no autorization" do
        before do
            @user = create(:user)
            another_user = create(:user)

            task = FactoryBot.create(:task)
            task.user = another_user
            task.save
            
            
            auth = @user.create_new_auth_token.merge({'HTTP_ACCEPT'=> 'application/json'})
            delete "/tasks/#{task.id}", params: {}, headers: auth
        end

        it "returns 401" do
            expect(response).to have_http_status(401)
        end
    end
  
    context "with valid authentication and no autorization" do
        before do
            @user = create(:user)
            

            task = FactoryBot.create(:task)
            task.user = @user
            task.save
            
            
            auth = @user.create_new_auth_token.merge({'HTTP_ACCEPT'=> 'application/json'})
            delete "/tasks/#{task.id}", params: {}, headers: auth
        end

        it "returns 200" do
            expect(response).to have_http_status(200)
            expect(Task.all.count).to eql(0)
        end
    end
  end
 
end
