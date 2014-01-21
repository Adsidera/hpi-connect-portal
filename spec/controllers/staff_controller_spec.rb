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

describe StaffController do

  # This should return the minimal set of attributes required to create a valid
  # Staff. As you add validations to Staff, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "firstname" => "Jane", "lastname" => "Doe", "role" => Role.create(:name => "Staff"), "identity_url" => "af", "email" => "test@example"} }
  let(:admin_role) { FactoryGirl.create(:role, name: 'Admin', level: 3) }
  # Programming Languages with a mapping to skill integers
  let(:programming_languages_attributes) { { "1" => "5", "2" => "2" } }


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StaffController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all staff as @staff" do
      admin = FactoryGirl.create(:user, role: admin_role)  
      sign_in admin

      staff = User.create! valid_attributes
      get :index, {}, valid_session

      assigns(:users).should eq([staff])
    end
  end

  describe "GET show" do
    it "assigns the requested staff as @staff" do
      user = User.create! valid_attributes
      get :show, {:id => user.to_param}, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "GET edit" do
    it "assigns the requested staff as @staff" do
      staff = User.create! valid_attributes
      sign_in staff
      get :edit, {:id => staff.to_param}, valid_session
      assigns(:user).should eq(staff)
    end
  end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Staff" do
  #       expect {
  #         post :create, {:staff => valid_attributes}, valid_session
  #       }.to change(Staff, :count).by(1)
  #     end

  #     it "assigns a newly created staff as @staff" do
  #       post :create, {:staff => valid_attributes}, valid_session
  #       assigns(:staff).should be_a(Staff)
  #       assigns(:staff).should be_persisted
  #     end

  #     it "redirects to the created staff" do
  #       post :create, {:staff => valid_attributes}, valid_session
  #       response.should redirect_to(Staff.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved staff as @staff" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Staff.any_instance.stub(:save).and_return(false)
  #       post :create, {:staff => {  }}, valid_session
  #       assigns(:staff).should be_a_new(Staff)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Staff.any_instance.stub(:save).and_return(false)
  #       post :create, {:staff => {  }}, valid_session
  #       response.should render_template("new")
  #     end
  #   end
  # end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested staff" do
        staff = User.create! valid_attributes
        # Assuming there are no other staff in the database, this
        # specifies that the Staff created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update).with({ "firstname" => "MyString" })
        put :update, {:id => staff.to_param, :user => { "firstname" => "MyString" }}, valid_session
      end

      it "assigns the requested staff as @staff" do
        staff = User.create! valid_attributes
        put :update, {:id => staff.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(staff)
      end

      it "redirects to the staff" do
        staff = User.create! valid_attributes
        put :update, {:id => staff.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to(staff_path(staff))
      end
    end

    describe "with invalid params" do
      it "assigns the staff as @staff" do
        staff = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => staff.to_param, :user => { "firstname" => "invalid value" }}, valid_session
        assigns(:user).should eq(staff)
      end

      it "re-renders the 'edit' template" do
        staff = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => staff.to_param, :user => { "firstname" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested staff" do
      staff = User.create! valid_attributes
      expect {
        delete :destroy, {:id => staff.to_param}, valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the staff list" do
      staff = User.create! valid_attributes
      delete :destroy, {:id => staff.to_param}, valid_session
      response.should redirect_to(staff_index_path)
    end
  end
  
  describe "PUT update with programming languages skills" do
    before(:each) do
      @staff = FactoryGirl.create(:user, valid_attributes)
      @programming_language_1 = FactoryGirl.create(:programming_language, name: 'Java')
      @programming_language_2 = FactoryGirl.create(:programming_language, name: 'Go')
    end
    it "updates the requested staff with an existing programming language" do
      @staff.assign_attributes(:programming_languages_users => [FactoryGirl.create(:programming_languages_user, user: @staff, programming_language: @programming_language_1, skill: '4')])
      @staff.programming_languages_users.size.should eq(1)
      ProgrammingLanguagesUser.any_instance.should_receive(:update_attributes).with({ :skill => "2" })
      put :update, {:id => @staff.to_param, :user => { "firstname" => "Max" }, :programming_languages => { @programming_language_1.id.to_s => "2" }}, valid_session
    end
    it "updates the requested staff with a new programming language" do
      @staff.assign_attributes(:programming_languages_users => [FactoryGirl.create(:programming_languages_user, user: @staff, programming_language: @programming_language_1, skill: '4')])
      put :update, {:id => @staff.to_param, :user => { "firstname" => "Max" }, :programming_languages => { @programming_language_1.id.to_s => "4", @programming_language_2.id.to_s => "2" }}, valid_session
      @staff.reload
      @staff.programming_languages_users.size.should eq(2)
      @staff.programming_languages.first.should eq(@programming_language_1)
      @staff.programming_languages.last.should eq(@programming_language_2)
    end
    it "updates the requested staff with a removed programming language" do
      @staff.assign_attributes(:programming_languages_users => [FactoryGirl.create(:programming_languages_user, user: @staff, programming_language: @programming_language_1, skill: '4'), FactoryGirl.create(:programming_languages_user, programming_language_id: @programming_language_2.id, skill: '2')])
      put :update, {:id => @staff.to_param, :user => { "firstname" => "Max" }, :programming_languages => { @programming_language_1.id.to_s => "2" }}, valid_session
      @staff.reload
      @staff.programming_languages_users.size.should eq(1)
      @staff.programming_languages.first.should eq(@programming_language_1)
    end
  end

  describe "PUT update with languages skills" do
    before(:each) do
      @staff = FactoryGirl.create(:user, valid_attributes)
      @language_1 = FactoryGirl.create(:language, name: 'English')
      @language_2 = FactoryGirl.create(:language, name: 'German')
    end
    it "updates the requested staff with an existing language" do
      @staff.assign_attributes(:languages_users => [FactoryGirl.create(:languages_user, user: @staff, language: @language_1, skill: '4')])
      @staff.languages_users.size.should eq(1)
      LanguagesUser.any_instance.should_receive(:update_attributes).with({ :skill => "2" })
      put :update, {:id => @staff.to_param, :user => { "firstname" => "Max" }, :languages => { @language_1.id.to_s => "2" }}, valid_session
    end
    it "updates the requested staff with a new language" do
      @staff.assign_attributes(:languages_users => [FactoryGirl.create(:languages_user, user: @staff, language: @language_1, skill: '4')])
      put :update, {:id => @staff.to_param, :user => { "firstname" => "Max" }, :languages => { @language_1.id.to_s => "4", @language_2.id.to_s => "2" }}, valid_session
      @staff.reload
      @staff.languages_users.size.should eq(2)
      @staff.languages.first.should eq(@language_1)
      @staff.languages.last.should eq(@language_2)
    end
    it "updates the requested staff with a removed language" do
      @staff.assign_attributes(:languages_users => [FactoryGirl.create(:languages_user, user: @staff, language: @language_1, skill: '4'), FactoryGirl.create(:languages_user, language_id: @language_2.id, skill: '2')])
      put :update, {:id => @staff.to_param, :user => { "firstname" => "Max" }, :languages => { @language_1.id.to_s => "2" }}, valid_session
      @staff.reload
      @staff.languages_users.size.should eq(1)
      @staff.languages.first.should eq(@language_1)
    end
  end

  describe "PUT update_role" do
    before(:each) do
        @student_role = FactoryGirl.create(:role, :name => "Student", :level => 1)
        @staff_role = FactoryGirl.create(:role, :name => "Staff", :level => 2)
        @chair = FactoryGirl.create(:chair)
        @staff_member = FactoryGirl.create(:user, :role => @staff_role, :chair => @chair)
        @admin_role = FactoryGirl.create(:role, :name => "Admin", :level => 3)
    end


    describe "current user is Admin" do
      before(:each) do
        sign_in FactoryGirl.create(:user, role: @admin_role)
      end

      it "updates role of staff_member to student" do 
        put :set_role_to_student, {:user_id => @staff_member.to_param}
        assert_equal(@student_role, User.find(@staff_member.id).role)
        assert_equal(nil, User.find(@staff_member.id).chair)
      end

      it "updates role of deputy to student" do 
        @chair.deputy = @staff_member
        new_deputy = FactoryGirl.create(:user, :role => @student_role)
        put :set_role_to_student, {:user_id => @staff_member.to_param, :new_deputy_id => new_deputy.to_param}
        assert_equal(@student_role, User.find(@staff_member.id).role)
        assert_equal(nil, User.find(@staff_member.id).chair)
        assert_equal(new_deputy, Chair.find(@chair).deputy)
      end

    end
  end
end
