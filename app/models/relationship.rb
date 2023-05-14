class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  # 規約: "モデル名_id" => Follower_idを探しにいく => follower_idとFollower classが紐付けらる
  # follower_idっていうカラムがRelationshipテーブルの中にあるんですが、
  #それはUser classと紐づけるためのカラムなんですよ
  belongs_to :followed, class_name: "User"
  # 規約: "モデル名_id" => Followed_idを探しにいく => followed_idとFollowed classが紐付けらる
  # followed_idっていうカラムがRelationshipテーブルの中にあるんですが、
  #それはUser classと紐づけるためのカラムなんですよ
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  
end
