class AddPictureToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :posts, :picture
  end
end
