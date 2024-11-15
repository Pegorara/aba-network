class PostSerializer < ApplicationSerializer
  def self.call(post)
    base_data = {
      content: post.content,
      users: post.users.map { |user| UserSerializer.call(user) }
    }
    base_data.merge(serialize_timestamps(post))
  end
end
