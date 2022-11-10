# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  role_id                :bigint(8)
#  avatar                 :string
#  name_ru                :string
#  name_en                :string
#  surname_ru             :string
#  surname_en             :string
#  main_language_id       :integer
#  description_ru         :text
#  description_en         :text
#  main_phone             :string
#  additional_phone       :string
#  contact_email          :string
#  vk_link                :string
#  instagram_link         :string
#  facebook_link          :string
#  city_id                :integer
#  region_id              :integer
#  country_id             :integer
#  confirmed_at           :datetime
#  confirmation_token     :string
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#

class User < ApplicationRecord
  TEMP_EMAIL_PREFIX = 'change@me'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook vkontakte google_oauth2]

  has_many :user_identities, dependent: :destroy
  has_many :users_tours, dependent: :destroy
  has_many :tours, through: :users_tours, dependent: :destroy
  has_many :tour_comments, dependent: :destroy
  has_many :stories

  belongs_to :country, optional: true
  belongs_to :city, optional: true
  belongs_to :region, optional: true
  belongs_to :main_language, class_name: 'Language', optional: true

  mount_uploader :avatar, UserAvatarUploader

  validates :email, presence: true, uniqueness: true

  scope :active, -> { where('email ilike ?', '%@%') }

  class << self
    def find_for_oauth(auth, signed_in_resource = nil)
      identity = UserIdentity.find_for_oauth(auth)

      user = signed_in_resource ? signed_in_resource : identity.user

      if user.nil?
        email = auth.info.email
        user = User.find_by(email: email)

        if user.nil?
          user = User.new(
            email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: Devise.friendly_token[0, 20]
          )
          user.skip_confirmation!
          user.save!
        end
      end

      if identity.user != user
        identity.user = user
        identity.save!
      end

      user
    end
  end

  def presense
    "#{name_ru} #{surname_ru}"
  end
end
