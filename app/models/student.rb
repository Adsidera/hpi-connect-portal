class Student < ActiveRecord::Base
	has_and_belongs_to_many :languages
	has_and_belongs_to_many :programming_languages
    validates :first_name, :last_name, presence: true

	has_attached_file 	:photo,
						:url  => "/assets/students/:id/:style/:basename.:extension",
    					:path => ":rails_root/public/assets/students/:id/:style/:basename.:extension"
    validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']

    has_attached_file 	:cv,
						:url  => "/assets/students/:id/:style/:basename.:extension",
    					:path => ":rails_root/public/assets/students/:id/:style/:basename.:extension"
	validates_attachment_content_type :cv, :content_type => ['application/pdf']

    def self.search_student(string)
    	string = string.downcase
        search_results = Student.where("
                lower(first_name) LIKE ?
                OR lower(last_name) LIKE ?
                OR lower(academic_program) LIKE ?
                OR lower(education) LIKE ?
                OR lower(homepage) LIKE ?
                OR lower(github) LIKE ?
                OR lower(facebook) LIKE ?
                OR lower(xing) LIKE ?
                OR lower(linkedin) LIKE ?
                ", string, string, string, string, string, string, string, string, string)
    	search_results += search_students_by_programming_language(string)
        search_results += search_students_by_language(string)
    	search_results.uniq.sort_by{|x| [x.last_name, x.first_name]}
    end

    def self.search_students_by_programming_language(string)
    	Student.joins(:programming_languages).where('lower(programming_languages.name) LIKE ?',string.downcase).
        sort_by{|x| [x.last_name, x.first_name]}
    end

     def self.search_students_by_language(string)
        Student.joins(:languages).where('lower(languages.name) LIKE ?',string.downcase).
        sort_by{|x| [x.last_name, x.first_name]}
    end

    def self.search_students_by_language_and_programming_language(language_array, programming_language_array)
       matching_students = Student.all 

       language_array.each do |language|
        matching_students = matching_students & search_students_by_language(language)
       end
       
       programming_language_array.each do |programming_language|
        matching_students = matching_students & search_students_by_programming_language(programming_language)
       end

       matching_students
    end           
end
