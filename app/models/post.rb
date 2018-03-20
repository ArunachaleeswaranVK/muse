class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    
    acts_as_votable
    
     has_attached_file :image
     validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png",
     "image/gif", "application/pdf"]
    
    def self.search(search)
        if search
            where(["title LIKE ?","%#{search}%"])
        else
            all.order("CREATED_AT DESC")
        end 
    end   
end
