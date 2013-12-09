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
  let(:valid_attributes) { { "first_name" => "Jane", "last_name" => "Doe" } }

  # Programming Languages with a mapping to skill integers
  let(:programming_languages_attributes) { { "1" => "5", "2" => "2" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StudentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all students as @students" do
      student = Student.create! valid_attributes
      get :index, {}, valid_session
      assigns(:students).should eq([student])
    end
  end

  describe "GET show" do
    it "assigns the requested student as @student" do
      student = Student.create! valid_attributes
      get :show, {:id => student.to_param}, valid_session
      assigns(:student).should eq(student)
    end
  end

  describe "GET new" do
    it "assigns a new student as @student" do
      get :new, {}, valid_session
      assigns(:student).should be_a_new(Student)
    end
  end

  describe "GET edit" do
    it "assigns the requested student as @student" do
      student = Student.create! valid_attributes
      get :edit, {:id => student.to_param}, valid_session
      assigns(:student).should eq(student)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Student" do
        expect {
          post :create, {:student => valid_attributes}, valid_session
        }.to change(Student, :count).by(1)
      end

      it "assigns a newly created student as @student" do
        post :create, {:student => valid_attributes}, valid_session
        assigns(:student).should be_a(Student)
        assigns(:student).should be_persisted
      end

      it "redirects to the created student" do
        post :create, {:student => valid_attributes}, valid_session
        response.should redirect_to(Student.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved student as @student" do
        # Trigger the behavior that occurs when invalid params are submitted
        Student.any_instance.stub(:save).and_return(false)
        post :create, {:student => { "first_name" => "invalid value" }}, valid_session
        assigns(:student).should be_a_new(Student)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Student.any_instance.stub(:save).and_return(false)
        post :create, {:student => { "first_name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested student" do
        student = Student.create! valid_attributes
        # Assuming there are no other students in the database, this
        # specifies that the Student created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Student.any_instance.should_receive(:update).with({ "first_name" => "MyString" })
        put :update, {:id => student.to_param, :student => { "first_name" => "MyString" }}, valid_session
      end

      it "assigns the requested student as @student" do
        student = Student.create! valid_attributes
        put :update, {:id => student.to_param, :student => valid_attributes}, valid_session
        assigns(:student).should eq(student)
      end

      it "redirects to the student" do
        student = Student.create! valid_attributes
        put :update, {:id => student.to_param, :student => valid_attributes}, valid_session
        response.should redirect_to(student)
      end
    end

    describe "with invalid params" do
      it "assigns the student as @student" do
        student = Student.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Student.any_instance.stub(:save).and_return(false)
        put :update, {:id => student.to_param, :student => { "first_name" => "invalid value" }}, valid_session
        assigns(:student).should eq(student)
      end

      it "re-renders the 'edit' template" do
        student = Student.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Student.any_instance.stub(:save).and_return(false)
        put :update, {:id => student.to_param, :student => { "first_name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested student" do
      student = Student.create! valid_attributes
      expect {
        delete :destroy, {:id => student.to_param}, valid_session
      }.to change(Student, :count).by(-1)
    end

    it "redirects to the students list" do
      student = Student.create! valid_attributes
      delete :destroy, {:id => student.to_param}, valid_session
      response.should redirect_to(students_url)
    end
  end

  describe "GET matching" do
    it "finds all students with the requested programming language and language" do
      java = ProgrammingLanguage.new(:name => 'Java')
      php = ProgrammingLanguage.new(:name => 'php')
      german = Language.new(:name => 'German')
      english = Language.new(:name => 'English')

      FactoryGirl.create(:student, programming_languages: [java, php], languages: [german])
      FactoryGirl.create(:student, programming_languages: [java], languages: [german, english])
      FactoryGirl.create(:student, programming_languages: [php], languages: [german])
      FactoryGirl.create(:student, programming_languages: [php], languages: [english])
      FactoryGirl.create(:student, programming_languages: [java, php], languages: [german, english])

      students = Student.search_students_by_language_and_programming_language(["german"], ["Java"])
      get :matching, ({:languages => ["German"], :programming_languages => ["java"]}), valid_session
      assigns(:students).should eq(students)
    end
  end

  describe "POST create with programming languages skills" do
    it "creates a new Student" do
      java = ProgrammingLanguage.new(:name => 'Java')
      php = ProgrammingLanguage.new(:name => 'PHP')
      expect {
        post :create, {:student => valid_attributes, :programming_languages => programming_languages_attributes}, valid_session
      }.to change(Student, :count).by(1)
    end
  end

  describe "PUT update with programming languages skills" do
    it "updates the requested student with an existing programming language" do
      pl = ProgrammingLanguage.create([{name: 'MyProgrammingLanguage'}])
      pl_id = pl.first.id
      student = Student.create! :first_name => "Test", :last_name => "User", :programming_languages => pl, :programming_languages_students => ProgrammingLanguagesStudent.create([{programming_language_id: pl_id, skill: '4'}])
      ProgrammingLanguagesStudent.any_instance.should_receive(:update_attributes).with({ :skill => "2" })
      put :update, {:id => student.to_param, :student => { "first_name" => "Test2" }, :programming_languages => { pl_id.to_s => "2" }}, valid_session
    end
    it "updates the requested student with a new programming language" do
      pl = ProgrammingLanguage.create([{name: 'MyProgrammingLanguage'}, {name: 'MySecondProgrammingLanguage'}])
      pl_id = pl.first.id
      pl2_id = pl.last.id
      student = Student.create! :first_name => "Test", :last_name => "User", :programming_languages => [pl.first], :programming_languages_students => ProgrammingLanguagesStudent.create([{programming_language_id: pl_id, skill: '4'}])
      put :update, {:id => student.to_param, :student => { "first_name" => "Test2" }, :programming_languages => { pl2_id.to_s => "2" }}, valid_session
      student.programming_languages_students.last.skill == 2
      student.programming_languages.last == pl.last
    end
    it "updates the requested student with a removed programming language" do
      pl = ProgrammingLanguage.create([{name: 'MyProgrammingLanguage'}, {name: 'MySecondProgrammingLanguage'}])
      pl_id = pl.first.id
      pl2_id = pl.last.id
      student = Student.create! :first_name => "Test", :last_name => "User", :programming_languages => pl, :programming_languages_students => ProgrammingLanguagesStudent.create([{programming_language_id: pl_id, skill: '4'},{programming_language_id: pl2_id, skill: '2'}])
      put :update, {:id => student.to_param, :student => { "first_name" => "Test2" }, :programming_languages => { pl_id.to_s => "2" }}, valid_session
      student.programming_languages.size == 1
    end
  end
end