class AddYouTubeVideoToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :you_tube_video, :text
  end
end
