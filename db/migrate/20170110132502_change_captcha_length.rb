class ChangeCaptchaLength < ActiveRecord::Migration
  def up
    change_column :simple_captcha_data, :value, :string, :limit => 8
  end

  def down
  end
end
