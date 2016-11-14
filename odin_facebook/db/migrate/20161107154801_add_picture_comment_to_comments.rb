class AddPictureCommentToComments < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :comments, :comment_picture
  end
end
