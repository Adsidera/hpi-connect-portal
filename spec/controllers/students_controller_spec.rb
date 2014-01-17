require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe StudentsController do

  # This should return the minimal set of attributes required to create a valid
  # Student. As you add validations to Student, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "firstname" => "Jane", "lastname" => "Doe", "role" => Role.create(:name => "Student"), "identity_url" => "af", "email" => "test@example", "semester" => "3", "education" => "Master", "academic_program" => "Volkswirtschaftslehre" } }

  # Programming Languages with a mapping to skill integers
  let(:programming_languages_attributes) { { "1" => "5", "2" => "2" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StudentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:staff_role) { FactoryGirl.create(:role, name: 'Staff', level: 2) }
  let(:staff) { FactoryGirl.create(:user, role: staff_role) }

  describe "GET index" do
    it "assigns all user as @users" do
      sign_in staff

      user = User.create! valid_attributes
      get :index, {}, valid_session
      assigns(:users).should eq(User.students.paginate(:page => 1, :per_page => 5))
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
    end

    it "checks if the user is a student" do
      user = FactoryGirl.create(:user, role: FactoryGirl.create(:role, name: "Research Assistant"))
      expect {
        get :show, {:id => user.to_param}, valid_session
        }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "GET edit" do
    it "assigns the requested student as @user" do
      student = User.create! valid_attributes
      get :edit, {:id => student.to_param}, valid_session
      assigns(:user).should eq(student)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        user = User.create! valid_attributes
        # Assuming there are no other students in the database, this
        # specifies that the Student created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update).with({ "firstname" => "MyString" })
        put :update, {:id => user.to_param, :user => {"firstname" => "MyString" }}, valid_session
      end

      it "assigns the requested student as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end

      it "redirects to the student" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to(student_path(user))
      end
    end

    describe "with invalid params" do
      it "assigns the student as @user" do
        student = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => student.to_param, :user => { "firstname" => "invalid value" }}, valid_session
        assigns(:user).should eq(student)
      end

      it "re-renders the 'edit' template" do
        student = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => student.to_param, :user => { "firstname" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "PATCH update" do
    before do
      @student = FactoryGirl.create(:user)
    end

    it "handles nil strings" do

      params = {
        "academic_program" => nil,
        "additional_information" => nil,
        "birthday" => nil,
        "education" => nil,
        "email" => "alexander.zeier@accenture.com",
        "facebook" => nil,
        "firstname" => "Alexander",
        "github" => nil,
        "homepage" => nil,
        "lastname" => "Zeier",
        "linkedin" => nil,
        "photo" => nil,
        "semester" => nil,
        "user_status_id" => "1",
        "xing" => nil
      }

      patch :update, { :id => @student.id, :user => params}

      response.should render_template("edit")
    end

    it "saves uploaded images" do
      patch :update, { :id => @student.id, :user => { "photo" => fixture_file_upload('images/test_picture.jpg', 'image/jpeg') } }
      response.should redirect_to(student_path(@student))
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested student" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, {:id => user.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the students list" do
      user = User.create! valid_attributes
      delete :destroy, {:id => user.to_param}, valid_session
      response.should redirect_to(students_path)
    end
  end

  describe "GET matching" do
    it "finds all users with the requested programming language, and language" do
      @programming_language_1 = FactoryGirl.create(:programming_language)
      @programming_language_2 = FactoryGirl.create(:programming_language)
      @language_1 = FactoryGirl.create(:language)
      @language_2 = FactoryGirl.create(:language)

      FactoryGirl.create(:user, programming_languages: [@programming_language_1, @programming_language_2], languages: [@language_1])
      FactoryGirl.create(:user, programming_languages: [@programming_language_1], languages: [@language_1, @language_2])
      FactoryGirl.create(:user, programming_languages: [@programming_language_2], languages: [@language_1])
      FactoryGirl.create(:user, programming_languages: [@programming_language_2], languages: [@language_2])
      FactoryGirl.create(:user, programming_languages: [@programming_language_1, @programming_language_2], languages: [@language_1, @language_2])

      user = User.search_students_by_language_and_programming_language([@language_1.name], [@programming_language_1.name])
      get :matching, ({:languages => [@language_1.name.capitalize], :programming_languages => [@programming_language_1.name.capitalize]}), valid_session
      assigns(:users).should eq(user)
    end
  end

  describe "PUT update with programming languages skills" do
    before(:each) do
      @student = FactoryGirl.create(:user, valid_attributes)
      @programming_language_1 = FactoryGirl.create(:programming_language)
      @programming_language_2 = FactoryGirl.create(:programming_language)
    end
    it "updates the requested student with an existing programming language" do
      @student.assign_attributes(:programming_languages_users => [FactoryGirl.create(:programming_languages_user, user: @student, programming_language: @programming_language_1, skill: '4')])
      @student.programming_languages_users.size.should eq(1)
      ProgrammingLanguagesUser.any_instance.should_receive(:update_attributes).with({ :skill => "2" })
      put :update, {:id => @student.to_param, :user => { "firstname" => "Max" }, :programming_languages => { @programming_language_1.id.to_s => "2" }}, valid_session
    end
    it "updates the requested student with a new programming language" do
      @student.assign_attributes(:programming_languages_users => [FactoryGirl.create(:programming_languages_user, user: @student, programming_language: @programming_language_1, skill: '4')])
      put :update, {:id => @student.to_param, :user => { "firstname" => "Max" }, :programming_languages => { @programming_language_1.id.to_s => "4", @programming_language_2.id.to_s => "2" }}, valid_session
      @student.reload
      @student.programming_languages_users.size.should eq(2)
      @student.programming_languages.first.should eq(@programming_language_1)
      @student.programming_languages.last.should eq(@programming_language_2)
    end
    it "updates the requested student with a removed programming language" do
      @student.assign_attributes(:programming_languages_users => [FactoryGirl.create(:programming_languages_user, user: @student, programming_language: @programming_language_1, skill: '4'), FactoryGirl.create(:programming_languages_user, programming_language_id: @programming_language_2.id, skill: '2')])
      put :update, {:id => @student.to_param, :user => { "firstname" => "Max" }, :programming_languages => { @programming_language_1.id.to_s => "2" }}, valid_session
      @student.reload
      @student.programming_languages_users.size.should eq(1)
      @student.programming_languages.first.should eq(@programming_language_1)
    end
  end

  describe "PUT update with languages skills" do
    before(:each) do
      @student = FactoryGirl.create(:user, valid_attributes)
      @language_1 = FactoryGirl.create(:language)
      @language_2 = FactoryGirl.create(:language)
    end
    it "updates the requested student with an existing language" do
      @student.assign_attributes(:languages_users => [FactoryGirl.create(:languages_user, user: @student, language: @language_1, skill: '4')])
      @student.languages_users.size.should eq(1)
      LanguagesUser.any_instance.should_receive(:update_attributes).with({ :skill => "2" })
      put :update, {:id => @student.to_param, :user => { "firstname" => "Max" }, :languages => { @language_1.id.to_s => "2" }}, valid_session
    end
    it "updates the requested student with a new language" do
      @student.assign_attributes(:languages_users => [FactoryGirl.create(:languages_user, user: @student, language: @language_1, skill: '4')])
      put :update, {:id => @student.to_param, :user => { "firstname" => "Max" }, :languages => { @language_1.id.to_s => "4", @language_2.id.to_s => "2" }}, valid_session
      @student.reload
      @student.languages_users.size.should eq(2)
      @student.languages.first.should eq(@language_1)
      @student.languages.last.should eq(@language_2)
    end
    it "updates the requested student with a removed language" do
      @student.assign_attributes(:languages_users => [FactoryGirl.create(:languages_user, user: @student, language: @language_1, skill: '4'), FactoryGirl.create(:languages_user, language_id: @language_2.id, skill: '2')])
      put :update, {:id => @student.to_param, :user => { "firstname" => "Max" }, :languages => { @language_1.id.to_s => "2" }}, valid_session
      @student.reload
      @student.languages_users.size.should eq(1)
      @student.languages.first.should eq(@language_1)
    end
  end

  describe "PUT update_role" do
    before(:each) do
        @student_role = FactoryGirl.create(:role)
        @student = FactoryGirl.create(:user, :role_id => @student_role.id)
        @staff_role = FactoryGirl.create(:role, :name => "Staff", :level => 2)
        @admin_role = FactoryGirl.create(:role, :name => "Admin", :level => 3)
        @chair = FactoryGirl.create(:chair)
    end

    describe "current user is deputy" do
      before(:each) do
        sign_in FactoryGirl.create(:user, role: @staff_role, chair: @chair)
      end

      it "updates role to Staff" do
        assert_equal(User.find(@student.id).role_id, @student_role.id)
        put :update_role, {:student_id => @student.to_param, :role_name => @staff_role.name}, valid_session
        assert_equal(@staff_role, User.find(@student.id).role)
      end

      it "updates role to Deputy" do
        put :update_role, {:student_id => @student.to_param, :role_name => "Deputy"}, valid_session
        assert_equal(@student, Chair.find(@chair.id).deputy)
      end
    end

    describe "current user is Admin" do
      before(:each) do
        sign_in FactoryGirl.create(:user, role: @admin_role)
      end

      it "updates role to Research Assistant" do
        put :update_role, {:student_id => @student.to_param, :role_name => @staff_role.name, :chair_name => @chair.name}, valid_session
        assert_equal(@staff_role, User.find(@student.id).role)
        assert_equal(@chair, User.find(@student.id).chair)
      end

      it "updates role to Deputy" do
        put :update_role, {:student_id => @student.to_param, :role_name => "Deputy", :chair_name => @chair.name}, valid_session
        assert_equal(User.find(@student.id), Chair.find(@chair.id).deputy)
        assert_equal(@staff_role, User.find(@student.id).role)
      end

      it "updates role to Admin" do
        put :update_role, {:student_id => @student.to_param, :role_name => @admin_role.name}, valid_session
        assert_equal(@admin_role, User.find(@student.id).role)
      end
    end
  end
end