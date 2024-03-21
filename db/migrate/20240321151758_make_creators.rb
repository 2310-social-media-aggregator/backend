class MakeCreators < ActiveRecord::Migration[7.1]
    def change
        create_table :creators do |t|
            t.string :name
            t.string :youtube_handle
      
            t.timestamps
        end
    end
end
