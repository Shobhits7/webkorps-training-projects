module ResumeGeneration
    class ResumeGenerator
        def initialize
            @resume_values = Hash.new
            inputs = get_user_inputs()
            create_resume_file
        end

        def get_user_inputs

            inputList = [
                "Name",
                "Father Name",
                "Gender [m/f]",
                "Address",
                "Languages",
                "Secondary class %",
                "Senior secondary class %",
                "College aggregate score",
                "Hobbies",
                "Strengths",
            ]

            for index in inputList
                print "Enter your #{index}: "
                val = gets.chomp.to_s
                if !val.nil? && !val.empty?  # if in input is not given it will not add the query in resume
                    @resume_values[index]=val.capitalize()
                end
            end

            email_validated = true
            dob_validated=true
            phone_validated=true

            while email_validated
                print "Enter your Mail ID: "
                email = gets.chomp.to_s
                if email =~ EMAIL_REGEX
                    @resume_values["Mail ID"] = email
                    email_validated = false
                else
                    puts "Invalid email entered!"
                end
            end

            while dob_validated
                print "Enter your date of birth in (yyyy-mm-dd): "
                dob = gets.chomp.to_s
                if dob =~ DOB_REGEX
                    @resume_values["Date of Birth"] = dob
                    dob_validated=false
                else
                    puts "Invalid DOB entered use correct format"
                end
            end

            while phone_validated
                print "Enter your contact no. in 9999999999 format: "
                phone = gets.chomp.to_s
                if phone =~ PHONE_NUMBER_REGEX
                    @resume_values["Contact No."] = phone
                    phone_validated=false
                else
                    puts "Invalid contact no. entered use correct format"
                end
            end

            return @resume_values
        end

        def create_resume_file
            no = rand(0..99999) # to prevent from same file name error
            unless File.exists?("resume_project/Generated_resumes/#{@resume_values["Name"]}_#{no}.txt")
                @file = File.new("resume_project/Generated_resumes/#{@resume_values["Name"]}_#{no}.txt","w")
                # Adding values to the file
                @file.puts("===========================================Resume=====================================")
                @resume_values.each { |index,entries|
                    @file.puts(
                        "=> #{index}: #{entries}"
                    )
                }
                @file.puts("======================================================================================")
                puts "======================================================================================"

                puts "Sucessfully created resume file with name #{@resume_values["Name"]}_#{no}.txt in Generated_resumes folder."

            else
                puts "Sorry, File with same name already exists please try again!"

            end
        end
    end
end
