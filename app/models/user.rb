class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
    has_one_attached :avatar
    after_commit :add_default_avatar, on: %i[create update]

    def avatar_thumbnail
        if avatar.attached?
            avatar.variant(resize: "150x150!").processed 
        else 
            "/duong.jpg"
        end
    end

    private
    def add_default_avatar
        unless avatar.attached?
        avatar.attach(
            io: File.open(Rails.root.join(
                    'app', 'assets', 'images', 'duong.jpg'
                )
            ), filename: 'duong.jpg',
            content_type: 'image/jpg'
        )
        end
    end
end
